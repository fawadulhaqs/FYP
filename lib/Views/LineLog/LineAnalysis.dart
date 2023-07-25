import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LineAnalysis extends StatefulWidget {
  final depId;
  final subId;
  final machineId;
  const LineAnalysis({Key? key, this.depId, this.subId, this.machineId}) : super(key: key);

  @override
  _LineAnalysisState createState() => _LineAnalysisState();
}

class _LineAnalysisState extends State<LineAnalysis> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final firestore = FirebaseFirestore.instance;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  double averageAva = 0.0;
  int limit=21;
  RxString Limit= ''.obs;

  List<_ChartData> myChartData = <_ChartData>[];

  Future<void> getDataFromFireStore(limit) async {
    final snapShotsValue = await FirebaseFirestore.instance
        .collection('Departments')
        .doc(widget.depId)
        .collection('Sub-Department')
        .doc(widget.subId)
        .collection('Machines')
        .doc(widget.machineId)
        .collection('Logs')
        .orderBy('LogDate', descending: true)
        .limit(limit)
        .get();
    List<_ChartData> list = snapShotsValue.docs
        .map((e) => _ChartData(
        x: DateTime.fromMillisecondsSinceEpoch(
            e.data()['LogDate'].millisecondsSinceEpoch),

        y: e.data()['Availability']))
        .toList();
    averageAva = list.map((e) => e.y!).reduce((a, b) => a + b) /
        snapShotsValue.docs.length;
    setState(() {
      myChartData = list;
    });
  }

  void initState() {
    getDataFromFireStore(limit).then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });

    _tooltipBehavior = TooltipBehavior(enable: true);
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
              hint: Limit ==
                  ''
                  ? Text('Select Duration')
                  : Text(
                Limit.value,
                style:
                TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 20.0,
              style: TextStyle(
                  color: Colors.black, fontSize: 15),
              items: [
                'Last Week',
                'Last Month',
                'Last 3 Months'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                if(val=='Last Week'){
                  Limit.value = val.toString();

                  limit=21;
                  getDataFromFireStore(limit);
                  setState(() {

                  });
                }
                else if(val=='Last Month'){
                  Limit.value = val.toString();
                  limit=90;
                  getDataFromFireStore(limit);
                  setState(() {

                  });
                }
                else if(val=='Last 3 Months'){
                  Limit.value = val.toString();
                  limit=270;
                  getDataFromFireStore(limit);
                  setState(() {

                  });
                }
              },
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {

                  _refreshIndicatorKey.currentState?.show();
                  setState(() {});
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                )
            ),
          ],
        ),
          body: SingleChildScrollView(
            child: RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  Future.delayed(Duration(seconds: 2));
                  getDataFromFireStore(limit);
                },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
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
                            child: Text('Work Efficiency',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.brown,fontWeight: FontWeight.bold)
                            ),
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
                                      value: averageAva,
                                      enableAnimation: true,
                                      animationDuration: 6500.0,
                                      animationType: AnimationType.elasticOut,
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(
                                            child: Text(
                                                '${averageAva.toStringAsFixed(2)}%',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                    FontWeight.bold))),
                                        angle: 90,
                                        positionFactor: 0.5)
                                  ])
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
                              child: Text('Availability:',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.brown,fontWeight: FontWeight.bold)
                              ),
                            ),
                            Container(
                              height: 400,
                                child: SfCartesianChart(
                                    // title: ChartTitle(text: 'Machine Availability per Shift'),
                                    legend: Legend(
                                      isVisible: true,
                                      position: LegendPosition.bottom,
                                    ),
                                    tooltipBehavior: _tooltipBehavior,
                                    zoomPanBehavior: _zoomPanBehavior,
                                    primaryXAxis: DateTimeAxis(
                                        edgeLabelPlacement: EdgeLabelPlacement.shift),
                                    primaryYAxis: NumericAxis(
                                        labelFormat: '{value}%',
                                      minimum: 0.0,
                                        maximum: 100.0,

                                       ),
                                    series: <ChartSeries>[
                                      // Renders line chart
                                      LineSeries<_ChartData, DateTime>(
                                        color: Colors.brown,
                                        name: 'Percentage',
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
                                                  isVisible: true, width: 4, height: 4),
                                              forwardForecast: 10,
                                              // backwardForecast: 30,
                                              name: 'Availability Forecast')
                                        ],

                                        xValueMapper: (_ChartData sales, _) => sales.x,
                                        yValueMapper: (_ChartData sales, _) => sales.y,
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

