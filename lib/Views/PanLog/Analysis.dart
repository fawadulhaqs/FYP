import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../Controller/Logs/LogController.dart';

class Analysis extends StatefulWidget {
  final depId;
  final subId;
  final machineId;
  const Analysis({Key? key, this.depId, this.subId, this.machineId})
      : super(key: key);

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final collectiveController = Get.put(LogController());

  final firestore = FirebaseFirestore.instance;

  List<_ChartData> myChartData = <_ChartData>[];
  List<_FatChartData> fatChartData = <_FatChartData>[];
  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _fattooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  double averageTime = 0.0;
  double averageFat = 0.0;
  int limit = 21;
  RxString Limit = ''.obs;
  late double sunFat;

  Future<void> getDataFromFireStore(limit) async {
    final snapShotsValue = await FirebaseFirestore.instance
        .collection('Departments')
        .doc(widget.depId)
        .collection('Sub-Department')
        .doc(widget.subId)
        .collection('Machines')
        .doc(widget.machineId)
        .collection('Log')
        .orderBy('LogDate', descending: true)
        .limit(limit)
        .get();
    List<_ChartData> list = snapShotsValue.docs.map((e) {
      String indicator;

      if (e.data()['OverAllTime'] <= 330) {
        indicator = 'No Delay';
        collectiveController.noDelay++;
      } else {
        indicator = 'Delayed ${e.data()['OverAllTime'] - 330} min';
        collectiveController.delay++;
      }
      print(' NO DELAY ${collectiveController.noDelay}');
      print(' DELAY ${collectiveController.delay}');
      collectiveController.per =
          ((collectiveController.noDelay / snapShotsValue.docs.length) * 100.0);
      print('percentage ${collectiveController.per}');

      return _ChartData(
          x: DateTime.fromMillisecondsSinceEpoch(
              e.data()['LogDate'].millisecondsSinceEpoch),

          // DateTime.fromMillisecondsSinceEpoch(
          //     e.data()['LogDate'].millisecondsSinceEpoch),
          y: e.data()['OverAllTime']);
    }).toList();

    if (snapShotsValue.docs.length >= 1) {
      averageTime = list.map((e) => e.y).reduce((a, b) => a + b) /
              snapShotsValue.docs.length ??
          0;
    }
    print(averageTime);
    setState(() {
      myChartData = list;
    });
  }

  Future<void> getFatChargeDataFromFireStore(limit) async {
    final snapShotsValue = await FirebaseFirestore.instance
        .collection('Departments')
        .doc(widget.depId)
        .collection('Sub-Department')
        .doc(widget.subId)
        .collection('Machines')
        .doc(widget.machineId)
        .collection('Log')
        .orderBy('LogDate', descending: true)
        .limit(limit)
        .get();
    print('length is ...${snapShotsValue.docs.length}');

    List<_FatChartData> fatlist = snapShotsValue.docs.map((e) {
      return _FatChartData(
          x: DateTime.fromMillisecondsSinceEpoch(
              e.data()['LogDate'].millisecondsSinceEpoch),
          y: e.data()['LogFatChange']);
    }).toList();
    if (snapShotsValue.docs.length >= 1) {
      averageFat = fatlist.map((e) => e.y).reduce((a, b) => a + b) /
          snapShotsValue.docs.length??0;
    }
    print(averageFat);
    setState(() {
      fatChartData = fatlist;
    });
  }

  @override
  void initState() {
    getDataFromFireStore(limit).then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    getFatChargeDataFromFireStore(limit).then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    _tooltipBehavior = TooltipBehavior(enable: true);
    _fattooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        enableDoubleTapZooming: true,
        enablePanning: true);
    super.initState();
    print('initState called');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Container(
              child: DropdownButtonFormField(
                hint: Limit == ''
                    ? Text('Select Duration')
                    : Text(
                        Limit.value,
                        style: TextStyle(color: Colors.black),
                      ),
                isExpanded: true,
                iconSize: 20.0,
                style: TextStyle(color: Colors.black, fontSize: 15),
                items: ['Last Week', 'Last Month', 'Last 3 Months'].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  if (val == 'Last Week') {
                    Limit.value = val.toString();
                    collectiveController.delay = 0;
                    collectiveController.noDelay = 0;
                    collectiveController.per = 0.0;
                    limit = 21;
                    getDataFromFireStore(limit);
                    getFatChargeDataFromFireStore(limit);
                    setState(() {});
                  } else if (val == 'Last Month') {
                    Limit.value = val.toString();
                    collectiveController.delay = 0;
                    collectiveController.noDelay = 0;
                    collectiveController.per = 0.0;
                    limit = 90;
                    getDataFromFireStore(limit);
                    getFatChargeDataFromFireStore(limit);
                    setState(() {});
                  } else if (val == 'Last 3 Months') {
                    Limit.value = val.toString();
                    collectiveController.delay = 0;
                    collectiveController.noDelay = 0;
                    collectiveController.per = 0.0;
                    limit = 270;
                    getDataFromFireStore(limit);
                    getFatChargeDataFromFireStore(limit);
                    setState(() {});
                  }
                },
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    collectiveController.delay = 0;
                    collectiveController.noDelay = 0;
                    collectiveController.per = 0.0;
                    _refreshIndicatorKey.currentState?.show();
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              key: _refreshIndicatorKey,
              onRefresh: () async {
                Future.delayed(Duration(seconds: 2));
                getDataFromFireStore(limit);
                getFatChargeDataFromFireStore(limit);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Work Efficiency:',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        endValue: 33,
                                        color: Colors.red,
                                        startWidth: 10,
                                        endWidth: 10),
                                    GaugeRange(
                                        startValue: 33,
                                        endValue: 66,
                                        color: Colors.orange,
                                        startWidth: 10,
                                        endWidth: 10),
                                    GaugeRange(
                                        startValue: 66,
                                        endValue: 100,
                                        color: Colors.green,
                                        startWidth: 10,
                                        endWidth: 10)
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: collectiveController.per,
                                      enableAnimation: true,
                                      animationDuration: 6500.0,
                                      animationType: AnimationType.elasticOut,
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(
                                            child: Text(
                                                '${collectiveController.per.toStringAsFixed(2)}%',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        angle: 90,
                                        positionFactor: 0.5)
                                  ])
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${collectiveController.noDelay}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0)),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${collectiveController.delay}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0)),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ],
                      ),
                      color: Colors.white,
                      elevation: 10,
                    ),
                    Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Process Duration:',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown),
                              ),
                            ),
                            Container(
                                child: SfCartesianChart(
                                    title: ChartTitle(
                                        text:
                                            'Average: ${averageTime.toStringAsFixed(1)} min',
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    legend: Legend(
                                      isVisible: true,
                                      position: LegendPosition.bottom,
                                    ),
                                    tooltipBehavior: _tooltipBehavior,
                                    zoomPanBehavior: _zoomPanBehavior,
                                    primaryXAxis: DateTimeAxis(
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift),
                                    primaryYAxis: NumericAxis(
                                        numberFormat: NumberFormat.compact(),
                                        labelFormat: '{value} min'),
                                    series: <ChartSeries>[
                                  // Renders line chart
                                  LineSeries<_ChartData, DateTime>(
                                    color: Colors.brown,
                                    name: 'Process Duration',
                                    markerSettings: const MarkerSettings(
                                        isVisible: true, width: 4, height: 4),
                                    dataSource: myChartData,
                                    trendlines: <Trendline>[
                                      Trendline(
                                          color: Colors.orange,
                                          enableTooltip: true,
                                          dashArray: <double>[10, 10],
                                          type: TrendlineType.polynomial,
                                          markerSettings: MarkerSettings(
                                              isVisible: true,
                                              width: 4,
                                              height: 4),
                                          forwardForecast: 10,
                                          // backwardForecast: 30,
                                          name: 'Performance Forecast')
                                    ],

                                    xValueMapper: (_ChartData sales, _) =>
                                        sales.x,
                                    yValueMapper: (_ChartData sales, _) =>
                                        sales.y,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    enableTooltip: true,
                                    // name: 'Time to complete one process',
                                  ),
                                ])),
                          ],
                        )),
                    Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Fat Charge',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown),
                              ),
                            ),
                            Container(
                                child: SfCartesianChart(
                                    title: ChartTitle(
                                        text:
                                            'Average: ${averageFat.toStringAsFixed(2)} fat',
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    legend: Legend(
                                        isVisible: true,
                                        position: LegendPosition.bottom),
                                    tooltipBehavior: _fattooltipBehavior,
                                    zoomPanBehavior: _zoomPanBehavior,
                                    primaryXAxis: DateTimeAxis(
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift),
                                    primaryYAxis:
                                        NumericAxis(labelFormat: '{value} fat'),
                                    series: <ChartSeries>[
                                  // Renders line chart
                                  LineSeries<_FatChartData, DateTime>(
                                    color: Colors.brown,
                                    name: 'FatCharge',
                                    markerSettings: const MarkerSettings(
                                        isVisible: true, width: 4, height: 4),
                                    dataSource: fatChartData,
                                    trendlines: <Trendline>[
                                      Trendline(
                                          color: Colors.orange,
                                          dashArray: <double>[10, 10],
                                          type: TrendlineType.polynomial,
                                          forwardForecast: 10,
                                          markerSettings: MarkerSettings(
                                              isVisible: true,
                                              width: 4,
                                              height: 4),
                                          name: 'Fat Charge Forecast')
                                    ],
                                    xValueMapper: (_FatChartData sales, _) =>
                                        sales.x,
                                    yValueMapper: (_FatChartData sales, _) =>
                                        sales.y,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    enableTooltip: true,
                                    // name: 'Time to complete one process',
                                  ),
                                ])),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class _ChartData {
  _ChartData({this.x, this.y});
  final x;
  final y;
}

class _FatChartData {
  _FatChartData({this.x, this.y});
  final x;
  final y;
}
