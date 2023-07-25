import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DepAnalysis extends StatefulWidget {
  final depId;
  const DepAnalysis({Key? key, this.depId}) : super(key: key);

  @override
  _DepAnalysisState createState() => _DepAnalysisState();
}

class _DepAnalysisState extends State<DepAnalysis> {
  List<_ChartData> myChartData = <_ChartData>[];
  double averageTime = 0.0;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  Future<void> getDataFromFireStore() async {
    final snapShotsValue = await FirebaseFirestore.instance
        .collection('Departments')
        .doc(widget.depId.id)
        .collection('Analysis')
        .orderBy('Sent_At', descending: true)
        .limit(90)
        .get();
    List<_ChartData> list = snapShotsValue.docs.map((e) {
      return _ChartData(
          x: DateTime.fromMillisecondsSinceEpoch(
              e.data()['Sent_At'].millisecondsSinceEpoch),
          y: e.data()['Performance']);
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

  @override
  void initState() {
    getDataFromFireStore().then((results) {
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
    // double per=averageTime;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      // color: Colors.blue,
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                              showAxisLine: false,
                              showLabels: false,
                              showTicks: false,
                              startAngle: 180,
                              endAngle: 360,
                              maximum: 100,
                              canScaleToFit: true,
                              radiusFactor: 0.79,
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                    needleEndWidth: 5,
                                    needleLength: 0.7,
                                    value: averageTime,
                                    enableAnimation: true,
                                    knobStyle: KnobStyle(knobRadius: 0)),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text(
                                            '${averageTime.toStringAsFixed(0)}%',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.2)
                              ],
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 20,
                                    startWidth: 0.45,
                                    endWidth: 0.45,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    color: const Color(0xFFDD3800)),
                                GaugeRange(
                                    startValue: 20.5,
                                    endValue: 40,
                                    startWidth: 0.45,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    endWidth: 0.45,
                                    color: const Color(0xFFFF4100)),
                                GaugeRange(
                                    startValue: 40.5,
                                    endValue: 60,
                                    startWidth: 0.45,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    endWidth: 0.45,
                                    color: const Color(0xFFFFBA00)),
                                GaugeRange(
                                    startValue: 60.5,
                                    endValue: 80,
                                    startWidth: 0.45,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    endWidth: 0.45,
                                    color: const Color(0xFFFFDF10)),
                                GaugeRange(
                                    startValue: 80.5,
                                    endValue: 100,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    startWidth: 0.45,
                                    endWidth: 0.45,
                                    color: const Color(0xFF8BE724)),
                                GaugeRange(
                                    startValue: 100.5,
                                    endValue: 120,
                                    startWidth: 0.45,
                                    endWidth: 0.45,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    color: const Color(0xFF64BE00)),
                              ]),
                          RadialAxis(
                            showAxisLine: false,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 180,
                            endAngle: 360,
                            maximum: 120,
                            radiusFactor: 0.85,
                            canScaleToFit: true,
                            pointers: <GaugePointer>[
                              MarkerPointer(
                                  markerType: MarkerType.text,
                                  text: 'Poor',
                                  value: 20.5,
                                  textStyle: GaugeTextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Times'),
                                  offsetUnit: GaugeSizeUnit.factor,
                                  markerOffset: -0.12),
                              MarkerPointer(
                                  markerType: MarkerType.text,
                                  text: 'Average',
                                  value: 60.5,
                                  textStyle: GaugeTextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Times'),
                                  offsetUnit: GaugeSizeUnit.factor,
                                  markerOffset: -0.12),
                              MarkerPointer(
                                  markerType: MarkerType.text,
                                  text: 'Good',
                                  value: 100,
                                  textStyle: GaugeTextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Times'),
                                  offsetUnit: GaugeSizeUnit.factor,
                                  markerOffset: -0.12)
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: SfCartesianChart(
                            primaryXAxis: DateTimeAxis(
                                edgeLabelPlacement: EdgeLabelPlacement.shift),
                            primaryYAxis: NumericAxis(
                              numberFormat: NumberFormat.compact(),
                              labelFormat: '{value}%',
                              minimum: 30.0,
                              maximum: 120.0,
                            ),
                            series: <ChartSeries>[
                              // Renders line chart
                              SplineSeries<_ChartData, DateTime>(
                                color: Colors.brown,
                                name: 'Min to complete',
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
                                      name: 'Performance Forecast')
                                ],
                                xValueMapper: (_ChartData sales, _) => sales.x,
                                yValueMapper: (_ChartData sales, _) => sales.y,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                                enableTooltip: true,
                                // name: 'Time to complete one process',
                              ),
                            ],
                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.top,
                            ),
                            tooltipBehavior: _tooltipBehavior,
                            zoomPanBehavior: _zoomPanBehavior,
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData({this.x, this.y});
  final x;
  final y;
}
