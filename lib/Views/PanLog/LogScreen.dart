import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Logs/LogController.dart';

class LogScreen extends StatefulWidget {
  final machine;
  final subid;
  final depid;
  const LogScreen({Key? key, this.machine, this.subid, this.depid})
      : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final collectiveController = Get.put(LogController());
  @override
  Widget build(BuildContext context) {
    final timeTaken = collectiveController.logendingDate
        .difference(collectiveController.logstartingDate)
        .inMinutes;
    collectiveController.overallTime = timeTaken;

    return Card(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Card(
                elevation: 10,
                // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 15),
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: collectiveController.logDate,
                    validator: (value) {
                      return collectiveController.validateDate(value!);
                    },
                    onTap: () {
                      collectiveController.selectDate(context);
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
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 15),
                    validator: (value) {
                      return collectiveController.validateStartTime(value!);
                    },
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: collectiveController.logStartTime,
                    onTap: () {
                      collectiveController.logstartTime(context);
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
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 15),
                    validator: (value) {
                      return collectiveController.validateEndingTime(value!);
                    },
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: collectiveController.logEndTime,
                    onTap: () async {
                      collectiveController.logendTime(context);
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
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Card(
                elevation: 10,
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
                          collectiveController.shiftValue.value =
                              val.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, left: 10),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Base:',
                            style: TextStyle(fontSize: 15),
                          )),
                      DropdownButtonFormField(
                        hint: Text('Select Base'),
                        isExpanded: true,
                        iconSize: 20.0,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        items: ['Lux', 'LifeBoy White', 'LifeBoy Red'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        validator: (value) =>
                            value == null ? 'please select' : null,
                        onChanged: (val) {
                          collectiveController.baseValue.value = val.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, left: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Boil No.',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: collectiveController.logBoiler,
                        decoration: InputDecoration(
                          hintText: 'Enter Boile No:',
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        validator: (value) {
                          return collectiveController.validateBiloNo(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, left: 10),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Operator:',
                            style: TextStyle(fontSize: 15),
                          )),
                      DropdownButtonFormField(
                        hint: Text('Select Operator'),
                        isExpanded: true,
                        iconSize: 20.0,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        items: [
                          'Shahzad Ahmed(1416)',
                          'Ejaz Ahmed(1353)',
                          'Rashid Iqbal(1395)',
                          'Abdul Rauf(1315)',
                          'Zulfiqar Ali(1349)',
                          'Saifullah Khan(1592)',
                          'Ali Ashraf(1598)',
                          'Waqar Khan(1611)',
                          'M.Ismail(1340)',
                          'Muhammad Ali(1324)',
                          'Azizullah(1309)',
                          'Khlid Mehmood(1330)',
                          'Yasir Akhtar Shah(1465)',
                          'Husnain Shah(1604)',
                          'Fakhar Manzor(1586)',
                          'Imran Ali(1323)',
                          'Ajmal Fareed(1322)',
                          'M.Amir Alam(1305)',
                          'Salman Mukaram(1635)',
                          'M.Yousaf(1553)',
                          'M.Umer Ameen(1577)',
                          'Jaffar Husain(1462)'
                        ].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        validator: (value) =>
                            value == null ? 'Please select' : null,
                        onChanged: (val) {
                          collectiveController.operatorValue.value =
                              val.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, left: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Sample#',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: collectiveController.logSample,
                        decoration: InputDecoration(
                          hintText: 'Enter Smaple#',
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        validator: (value) {
                          return collectiveController.validateSampleNo(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
