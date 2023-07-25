import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/LineLogController.dart';

class LinrLog extends StatefulWidget {
  final machine;
  final subid;
  final depid;
  const LinrLog({Key? key, this.machine, this.subid, this.depid})
      : super(key: key);

  @override
  State<LinrLog> createState() => _LinrLogState();
}

class _LinrLogState extends State<LinrLog> {
  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  final linelogController = Get.put(LineLogController());
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _myKey,
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      child: IconButton(
                          alignment: Alignment(-1, 0),
                          onPressed: () {},
                          icon: Icon(Icons.remove))),
                  Expanded(
                      child: Center(
                    child: Text("LOG's"),
                  )),
                  Expanded(
                      child: IconButton(
                          alignment: Alignment(1, 0),
                          onPressed: () {
                            final isValid = _myKey.currentState!.validate();
                            if(isValid) {
                              linelogController.availabilityPercentage =
                                  ((linelogController.overallTime -
                                      linelogController.idleTimeMin) /
                                      linelogController.overallTime) * 100;
                              print(linelogController.availabilityPercentage);
                              linelogController.OnContinue(widget.depid, widget.subid, widget.machine.id);
                            }
                          },
                          icon: Icon(Icons.save))),
                ],
              ),
              Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Divider(color: Colors.black),
                      Text('Machine Avaiability'),
                      Divider(color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: Card(
                              elevation: 0,
                              // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 15),
                                  focusNode: AlwaysDisabledFocusNode(),
                                  controller: linelogController.logdate,
                                  validator: (value) {
                                    return linelogController.validateDate(value!);
                                  },
                                  onTap: () {
                                    linelogController.selectDate(context);
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Date:',
                                      labelStyle:
                                      TextStyle(color: Colors.black, fontSize: 15),
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    return linelogController.validateStartTime(value!);
                                  },
                                  focusNode: AlwaysDisabledFocusNode(),
                                  controller: linelogController.startTime,
                                  onTap: () {
                                    linelogController.logstartTime(context);
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Start Time:',
                                      labelStyle:
                                      TextStyle(color: Colors.black, fontSize: 15),
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    return linelogController.validateEndingTime(value!);
                                  },
                                  focusNode: AlwaysDisabledFocusNode(),
                                  controller: linelogController.endTime,
                                  onTap: () async {
                                    linelogController.logendTime(context);
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'End Time:',
                                      labelStyle:
                                      TextStyle(color: Colors.black, fontSize: 15),
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, left: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Shift:',
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                              ),
                              DropdownButtonFormField(
                                hint: Text('Select Shift'),
                                isExpanded: true,
                                iconSize: 20.0,
                                style: TextStyle(color: Colors.black, fontSize: 15),
                                items: ['A', 'B', 'C'].map(
                                      (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                validator: (value) =>
                                value == null ? 'please select shift' : null,
                                onChanged: (val) {
                                  linelogController.logShift.value =
                                      val.toString();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.black),
                      Text('Idle time/Breaks'),
                      Divider(color: Colors.black),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 22),
                                        // validator: (value) {
                                        //   return linelogController.validateStartTime(value!);
                                        // },
                                        focusNode: AlwaysDisabledFocusNode(),
                                        controller: linelogController.idleStartTime,
                                        onTap: () {
                                          linelogController.idlestartTime(context);
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Start Time:',
                                            labelStyle:
                                            TextStyle(color: Colors.black, fontSize: 15), border: UnderlineInputBorder()),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 22),
                                        // validator: (value) {
                                        //   return linelogController.validateEndingTime(value!);
                                        // },
                                        focusNode: AlwaysDisabledFocusNode(),
                                        controller: linelogController.idleEndTime,
                                        onTap: () async {
                                          linelogController.idleendTime(context);
                                          setState(() {
                                            print(linelogController.idleDiff);
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'End Time:',
                                            labelStyle:
                                            TextStyle(color: Colors.black, fontSize: 15),
                                            border: UnderlineInputBorder()),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 22),
                                      // validator: (value) => value == null ? 'Please enter reason' :null,
                                      // focusNode: AlwaysDisabledFocusNode(),
                                      controller: linelogController.idleRsn,
                                      onTap: () async {
                                        setState(() {
                                          // print(linelogController.idleDiff);
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Reason for a Break',
                                          labelStyle:
                                          TextStyle(color: Colors.black, fontSize: 15),
                                          border: UnderlineInputBorder()),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      linelogController.numberList
                                          .add(linelogController.idleDiff);
                                      linelogController.idleTimeMin=linelogController.idleTimeMin+linelogController.idleDiff;
                                      linelogController.rsnList.add(linelogController.idleRsn.text);
                                      print('Availability  ${linelogController.overallTime}');
                                      print('Total Time  ${linelogController.idleTimeMin}');
                                      linelogController.idleStartTime.clear();
                                      linelogController.idleEndTime.clear();

                                      setState(() {});
                                      linelogController.idleRsn.clear();
                                    },
                                    child: Text('Add'),
                                  ),
                                ],
                              )
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  Text('List'),
                                  SingleChildScrollView(
                                    child: Card(
                                      elevation: 0,
                                      child: Container(
                                        height: 270,
                                        child: ListView.builder(
                                            itemCount: linelogController.numberList.length,
                                            itemBuilder: ((context, index) {
                                              return Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      // print(linelogController.numberList[index]);
                                                      linelogController.idleTimeMin=linelogController.idleTimeMin-linelogController.numberList[index];
                                                      linelogController.numberList.removeAt(index);


                                                      print(linelogController.idleTimeMin);
                                                      setState(() {});
                                                    },
                                                    child: Text(
                                                      '${linelogController.numberList[index]} min for ${linelogController.rsnList[index]}',textAlign: TextAlign.start,),
                                                  ),
                                                ],
                                              );
                                            })),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // TextButton(
              //   onPressed: () async {
              //     await firestore
              //         .collection('Array')
              //         .doc('Hello')
              //         .set({'NewArray': linelogController.numberList});
              //     setState(() {});
              //   },
              //   child: Text('Add database'),
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
