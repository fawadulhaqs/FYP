import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_fyp_impas/Controller/SubDepartment/SubdepertmentController.dart';
import 'package:project_fyp_impas/Views/Machines.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../Widgets/MyDrawer.dart';

class SubDepartments extends StatefulWidget {
  final data;
  SubDepartments({Key? key, required this.data}) : super(key: key);

  @override
  _SubDepartmentsState createState() => _SubDepartmentsState();
}

class _SubDepartmentsState extends State<SubDepartments> {
  List<_ChartData> myChartData = <_ChartData>[];
  double averageTime = 0.0;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  Future<void> getDataFromFireStore() async {
    final snapShotsValue = await FirebaseFirestore.instance
        .collection('Departments')
        .doc(widget.data.id)
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
    final firestore = FirebaseFirestore.instance;
    final subController = Get.put(SubDepartmentController());

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('${widget.data['Department_Name']}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.brown.shade400,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Container(
                        width: 340,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(100),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SfRadialGauge(
                            title: GaugeTitle(
                                text: 'Department Performance',
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
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
                                        needleColor: Colors.white,
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white))),
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
                                          color: Colors.white),
                                      offsetUnit: GaugeSizeUnit.factor,
                                      markerOffset: -0.12),
                                  MarkerPointer(
                                      markerType: MarkerType.text,
                                      text: 'Average',
                                      value: 60.5,
                                      textStyle: GaugeTextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white),
                                      offsetUnit: GaugeSizeUnit.factor,
                                      markerOffset: -0.12),
                                  MarkerPointer(
                                      markerType: MarkerType.text,
                                      text: 'Good',
                                      value: 100,
                                      textStyle: GaugeTextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white),
                                      offsetUnit: GaugeSizeUnit.factor,
                                      markerOffset: -0.12)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0,
                      color: Colors.brown.shade400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Container(
                          height: 250,
                          width: 340,
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(100),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: SfCartesianChart(
                            primaryXAxis: DateTimeAxis(
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                labelStyle: TextStyle(color: Colors.white)),
                            primaryYAxis: NumericAxis(
                              numberFormat: NumberFormat.compact(),
                              labelFormat: '{value}%',
                              labelStyle: TextStyle(color: Colors.white),
                              minimum: 30.0,
                              maximum: 120.0,
                            ),
                            series: <ChartSeries>[
                              // Renders line chart
                              SplineSeries<_ChartData, DateTime>(
                                color: Colors.white,
                                name: 'Performace',
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
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: false,
                                    textStyle: TextStyle(color: Colors.white)),
                                enableTooltip: true,
                                // name: 'Time to complete one process',
                              ),
                            ],
                            legend: Legend(
                                isVisible: true,
                                position: LegendPosition.top,
                                textStyle: TextStyle(color: Colors.white)),
                            tooltipBehavior: _tooltipBehavior,
                            zoomPanBehavior: _zoomPanBehavior,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: DottedDecoration(
                    shape: Shape.box,
                    color: Colors.brown,
                    strokeWidth: 2,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        subController.createDialog(context, widget.data.id);
                      },
                      child: Text(
                        'Create Sub-Department',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.brown, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
              color: Colors.black54,
            ),
            StreamBuilder(
              stream: firestore
                  .collection('Departments')
                  .doc(widget.data.id)
                  .collection('Sub-Department')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final subdata = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                              Machines(
                                  depdata: widget.data.id, subdata: subdata),
                              transition: Transition.rightToLeft);
                        },
                        child: Material(
                          color: Colors.brown.shade400,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(100),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0, top: 14),
                                      child: Text(
                                        subdata['Sub-Department_Name'] ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment(1.05, 0),
                                        child: PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Colors.white,
                                            ),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem<int>(
                                                  value: 0,
                                                  child: Text("Delete"),
                                                ),
                                              ];
                                            },
                                            onSelected: (value) {
                                              if (value == 0) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CupertinoAlertDialog(
                                                        title: const Text(
                                                            'Delete'),
                                                        content: Text(
                                                            "Deleting Department will delete all your data saved in it"),
                                                        actions: <Widget>[
                                                          CupertinoDialogAction(
                                                            onPressed:
                                                                () async {
                                                              await firestore
                                                                  .collection(
                                                                      'Departments')
                                                                  .doc(widget
                                                                      .data.id)
                                                                  .collection(
                                                                      'Sub-Department')
                                                                  .doc(subdata
                                                                      .id)
                                                                  .delete()
                                                                  .catchError(
                                                                      (e) {
                                                                print(e);
                                                              }).then((value) =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop());
                                                            },
                                                            child: const Text(
                                                                'Yes'),
                                                          ),
                                                          CupertinoDialogAction(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  "No");
                                                            },
                                                            child: const Text(
                                                                'No'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              }
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, top: 14),
                                  child: Text(
                                      'Sub-Departments Head : ' +
                                          subdata['Head_of_Sub-Department'],
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
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
