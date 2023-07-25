import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/MachineController.dart';
import 'package:project_fyp_impas/Views/PanLog/ViewMachine.dart';
import 'package:project_fyp_impas/Widgets/MyDrawer.dart';

import 'LineLog/ViewLineMachine.dart';

class Machines extends StatefulWidget {
  final depdata;
  final subdata;
  const Machines({Key? key, required this.depdata, required this.subdata})
      : super(key: key);

  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final machineController = Get.put(MachineController());
    // final logController = Get.put(LogController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(widget.subdata['Sub-Department_Name']),
        centerTitle: true,
        actions: [],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        machineController.createDialog(
                            context, widget.depdata, widget.subdata.id);
                      },
                      child: Text(
                        'Add Machines',
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
                  .doc(widget.depdata)
                  .collection('Sub-Department')
                  .doc(widget.subdata.id)
                  .collection('Machines')
                  .orderBy('SentAt')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 200,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          mainAxisExtent: 150,
                          childAspectRatio: 3 / 2,
                          maxCrossAxisExtent: 300),
                      physics: NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final machinedata = snapshot.data!.docs[index];

                        if (machinedata['Machine_Type'] ==
                            "Baser or Pan, for base making") {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                  VIewMachine(
                                      depid: widget.depdata,
                                      subid: widget.subdata.id,
                                      machinedata: machinedata),
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
                                // height: 150,
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
                                            machinedata['Machine_Name'] ?? "",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Flexible(
                                          child: Align(
                                            alignment: Alignment(1.1, 0),
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
                                                        builder: (BuildContext
                                                            context) {
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
                                                                          .depdata)
                                                                      .collection(
                                                                          'Sub-Department')
                                                                      .doc(widget
                                                                          .subdata
                                                                          .id)
                                                                      .collection(
                                                                          'Machines')
                                                                      .doc(machinedata
                                                                          .id)
                                                                      .delete()
                                                                      .catchError(
                                                                          (e) {
                                                                    print(e);
                                                                  }).then((value) =>
                                                                          Navigator.of(context)
                                                                              .pop());
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                              ),
                                                              CupertinoDialogAction(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      "No");
                                                                },
                                                                child:
                                                                    const Text(
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
                                        'Machine Type : ' +
                                            machinedata['Machine_Type'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                  ViewLineMachine(
                                      depid: widget.depdata,
                                      subid: widget.subdata.id,
                                      machinedata: machinedata),
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
                                // height: 150,
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
                                            machinedata['Machine_Name'] ?? "",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Flexible(
                                          child: Align(
                                            alignment: Alignment(1.1, 0),
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
                                                        builder: (BuildContext
                                                            context) {
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
                                                                          .depdata)
                                                                      .collection(
                                                                          'Sub-Department')
                                                                      .doc(widget
                                                                          .subdata
                                                                          .id)
                                                                      .collection(
                                                                          'Machines')
                                                                      .doc(machinedata
                                                                          .id)
                                                                      .delete()
                                                                      .catchError(
                                                                          (e) {
                                                                    print(e);
                                                                  }).then((value) =>
                                                                          Navigator.of(context)
                                                                              .pop());
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                              ),
                                                              CupertinoDialogAction(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      "No");
                                                                },
                                                                child:
                                                                    const Text(
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
                                        'Machine Type : ' +
                                            machinedata['Machine_Type'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
