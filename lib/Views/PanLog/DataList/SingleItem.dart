import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../CRUD.dart';
import '../../../Controller/Logs/LogController.dart';
import '../../../Models/PanLogModel.dart';

class SingleCard extends StatefulWidget {
  final depId;
  final subId;
  final machineId;
  SingleCard(
      {Key? key,
      required this.collectiveModel,
      this.depId,
      this.subId,
      this.machineId})
      : super(key: key);
  final CollectiveModel collectiveModel;

  @override
  _SingleCardState createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  final collectiveController = Get.put(LogController());

  // getData() async {
  //   return await FirebaseFirestore.instance
  //       .collection('logSheetInfo')
  //       .doc(widget.collectiveModel.id)
  //       .get();
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      // getData();
    });
  }

  TextEditingController log1 = TextEditingController();
  TextEditingController log2 = TextEditingController();
  TextEditingController sap1 = TextEditingController();
  TextEditingController sap2 = TextEditingController();
  TextEditingController cir1 = TextEditingController();
  TextEditingController cir2 = TextEditingController();
  int? sapTimeLoss = 0;
  int? cirTimeLoss = 0;
  DateTime? logendingDate;
  DateTime? logstartingDate;
  int? overall;
  String? boilno;
  DateTime? sapendingDate;
  DateTime? sapstartingDate;
  int? sapoverall = 0;
  DateTime? cirendingDate;
  DateTime? cirstartingDate;
  int? ciroverall;
  int? water1;
  int? water2;
  int? water3;
  int? water4;
  int? costic2;
  int? costic1;
  int? costic3;
  int? costic4;
  int? palm2;
  int? palm1;
  int? palm3;
  int? palm4;
  int? hard1;
  int? hard2;
  int? hard3;
  int? hard4;
  int? dfa2;
  int? dfa1;
  int? dfa3;
  int? dfa4;
  int? pko2;
  int? pko1;
  int? pko3;
  int? pko4;
  int? lab2;
  int? lab1;
  int? lab3;
  int? lab4;
  int? salt2;
  int? salt1;
  int? salt3;
  int? salt4;
  int? sv2;
  int? sv1;
  int? sv3;
  int? sv4;
  int? tur2;
  int? tur1;
  int? tur3;
  int? tur4;
  int? waterAll;
  int? costicAll;
  int? palmAll;
  int? hardAll;
  int? dfaAll;
  int? pkoAll;
  int? labAll;
  int? saltAll;
  int? svAll;
  int? turAll;
  double? fatAll;
  String? logSample;
  String? fatCharge;
  RxString? sapLossesValue;
  RxString? cirLossesValue;
  crudeMethods crudObj = new crudeMethods();

  Future _updateLogDialog(BuildContext context, selectedDoc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Update Log', style: TextStyle(fontSize: 15)),
              content: Column(
                children: [
                  TextFormField(
                    controller: log1,
                    focusNode: AlwaysDisabledFocusNode(),
                    onTap: () async {
                      logstartTime(context);
                    },
                    decoration: InputDecoration(
                        labelText:
                            '${widget.collectiveModel.startTime} Start Time'),
                  ),
                  TextFormField(
                    controller: log2,
                    focusNode: AlwaysDisabledFocusNode(),
                    onTap: () async {
                      logendTime(context);
                    },
                    decoration: InputDecoration(
                        labelText:
                            '${widget.collectiveModel.endTime} End Time'),
                  ),
                  TextFormField(
                    initialValue: '${widget.collectiveModel.boilNo}',
                    decoration: InputDecoration(
                        hintText: '${widget.collectiveModel.boilNo}',
                        labelText: 'Boiler No.'),
                    onChanged: (value) {
                      this.boilno = value.toString();
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        final timeTaken = logendingDate!
                            .difference(logstartingDate!)
                            .inMinutes;
                        overall = timeTaken;
                        crudObj
                            .updateData(widget.depId, widget.subId,
                                widget.machineId, selectedDoc, {
                              'LogStartTime': this.log1.text,
                              'LogEndTime': this.log2.text,
                              'OverAllTime': this.overall,
                              'LogBoilNo': this.boilno
                            })
                            .then((result) {})
                            .catchError((e) {
                              print(e);
                            });
                        double analyticPer;
                        if (timeTaken > 330) {
                          analyticPer = (330 / timeTaken) * 100;
                        } else {
                          analyticPer = 100.0;
                        }
                        crudObj.AnalyticalUpdate(
                            widget.depId,
                            '${selectedDoc}${widget.machineId}',
                            {'Performance': analyticPer});
                      });
                    },
                    child: Text('Update')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
              ],
            ),
          );
        });
  }

  Future _updateSapDialog(BuildContext context, selectedDoc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Update Info', style: TextStyle(fontSize: 15)),
              content: Column(
                children: [
                  TextFormField(
                    // initialValue: '${collectiveModel.startTimeSoap}',
                    controller: sap1,
                    focusNode: AlwaysDisabledFocusNode(),
                    onTap: () async {
                      sapstartTime(context);
                    },
                    decoration: InputDecoration(
                        labelText:
                            '${widget.collectiveModel.startTimeSoap} Sap Start Time'),
                  ),
                  TextFormField(
                    // initialValue: '${collectiveModel.endTimeSoap}',
                    controller: sap2,
                    focusNode: AlwaysDisabledFocusNode(),
                    onTap: () async {
                      sapendTime(context);
                    },
                    decoration: InputDecoration(
                        labelText:
                            '${widget.collectiveModel.endTimeSoap} Sap End Time'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                                      'DownTime Losses',
                                      style: TextStyle(fontSize: 15),
                                    )),
                                DropdownButtonFormField(
                                  hint: sapLossesValue == null
                                      ? Text('Select Reason')
                                      : Text(
                                          sapLossesValue!.value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 20.0,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  items: [
                                    'None',
                                    '1) Load cell t61 line block',
                                    '2) Load cell t62 line block',
                                    '3) Load cell t5 line block',
                                    '4) Load cell pko line block',
                                    '5) Load cell t61 gasket damage/ actuator malfunction/manual valve leak',
                                    '6) Load cell t62 gasket damage/ actuator malfunction/manual valve leak',
                                    '7) Load cell t5 gasket damage/ actuator malfunction/manual valve leak',
                                    '8) Load cell pko gasket damage/ actuator malfunction/manual valve leak',
                                    '9) Lauric acid line block',
                                    '10) Sru6 pump sealing water low pressure',
                                    '11) Safety interlock of pump due to high pressure',
                                    '12) Safety interlock due to pan 14/15 high level sensor',
                                    '13) Bleached oil unavailability',
                                    '14) High temperature of lauric',
                                    '15) High temperature of PST',
                                    '16) High temperature of Palm oil',
                                    '17) Caustic feed pump problem',
                                    '18) Sap late due to load cell unavailability',
                                    '19) Sap late due to caustic late reaction',
                                    '20) Sap late due to conditions of sap not meeting',
                                    '21) Sap late due to RO water unavailability',
                                    '22) Sap late due to sru 6 pump stuck',
                                    '23) Sap late due to transfer line block',
                                    '24) Sap late due to unavailability of man power',
                                    '25) Sap late due to no power supply',
                                    '26) Sap late due to pan agitator issue',
                                    '27) soap pump liquidation line block',
                                    '28) Pump Blockage',
                                    '29) Pump Mechanical Fault',
                                    '30) Pump Electrical Fault of motor',
                                    '31) Pump Electrical Fault of UFD',
                                    '32) Pump Electrical Fault of safety Switch/ Emergency Switch',
                                    '33) Agitator failure centre/slide',
                                    '34) Sap late due to high Caustic',
                                    '35) Sap late due to low Caustic',
                                    '36) Sap late due to caustic nil'
                                  ].map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  validator: (value) {
                                    return collectiveController
                                        .validateLosses(value);
                                  },
                                  onChanged: (val) {
                                    sapLossesValue!.value = val.toString();
                                    setState(() {});
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
                                  child: Text('Total Time Loss',
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ),
                                TextFormField(
                                  initialValue: '${sapTimeLoss} min',
                                  focusNode: AlwaysDisabledFocusNode(),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Time In Minutes',
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      final timeTaken =
                          sapendingDate!.difference(sapstartingDate!).inMinutes;
                      sapoverall = timeTaken;
                      if (timeTaken > 180) {
                        sapTimeLoss = timeTaken - 180;
                      }
                      crudObj
                          .updateData(widget.depId, widget.subId,
                              widget.machineId, selectedDoc, {
                            'SapStartTime': this.sap1.text,
                            'SapEndTime': this.sap2.text,
                            'SapActTime': this.sapoverall,
                            'SapTimeLoss': this.sapTimeLoss,
                            'SapLosses': this.sapLossesValue!.value,
                          })
                          .then((result) {})
                          .catchError((e) {
                            print(e);
                          });
                      setState(() {});
                    },
                    child: Text('Update')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
              ],
            ),
          );
        });
  }

  Future _updateCirDialog(BuildContext context, selectedDoc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Update Info', style: TextStyle(fontSize: 15)),
              content: Column(
                children: [
                  TextFormField(
                    // initialValue: '${collectiveModel.startTimeCir}',
                    controller: cir1,
                    focusNode: AlwaysDisabledFocusNode(),
                    onTap: () async {
                      cirstartTime(context);
                    },
                    decoration: InputDecoration(
                        labelText:
                            '${widget.collectiveModel.startTimeCir} Cir. Start Time'),
                  ),
                  TextFormField(
                    // initialValue: '${collectiveModel.endTimeCir}',
                    controller: cir2,
                    focusNode: AlwaysDisabledFocusNode(),
                    onTap: () async {
                      cirendTime(context);
                    },
                    decoration: InputDecoration(
                        labelText:
                            '${widget.collectiveModel.endTimeCir} Cir. End Time'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                                      'DownTime Losses',
                                      style: TextStyle(fontSize: 15),
                                    )),
                                DropdownButtonFormField(
                                  hint: cirLossesValue == null
                                      ? Text('Select Reason')
                                      : Text(
                                          cirLossesValue!.value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 20.0,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  items: [
                                    'None',
                                    '1) Load cell t61 line block',
                                    '2) Load cell t62 line block',
                                    '3) Load cell t5 line block',
                                    '4) Load cell pko line block',
                                    '5) Load cell t61 gasket damage/ actuator malfunction/manual valve leak',
                                    '6) Load cell t62 gasket damage/ actuator malfunction/manual valve leak',
                                    '7) Load cell t5 gasket damage/ actuator malfunction/manual valve leak',
                                    '8) Load cell pko gasket damage/ actuator malfunction/manual valve leak',
                                    '9) Lauric acid line block',
                                    '10) Sru6 pump sealing water low pressure',
                                    '11) Safety interlock of pump due to high pressure',
                                    '12) Safety interlock due to pan 14/15 high level sensor',
                                    '13) Bleached oil unavailability',
                                    '14) High temperature of lauric',
                                    '15) High temperature of PST',
                                    '16) High temperature of Palm oil',
                                    '17) Caustic feed pump problem',
                                    '18) Sap late due to load cell unavailability',
                                    '19) Sap late due to caustic late reaction',
                                    '20) Sap late due to conditions of sap not meeting',
                                    '21) Sap late due to RO water unavailability',
                                    '22) Sap late due to sru 6 pump stuck',
                                    '23) Sap late due to transfer line block',
                                    '24) Sap late due to unavailability of man power',
                                    '25) Sap late due to no power supply',
                                    '26) Sap late due to pan agitator issue',
                                    '27) soap pump liquidation line block',
                                    '28) Pump Blockage',
                                    '29) Pump Mechanical Fault',
                                    '30) Pump Electrical Fault of motor',
                                    '31) Pump Electrical Fault of UFD',
                                    '32) Pump Electrical Fault of safety Switch/ Emergency Switch',
                                    '33) Agitator failure centre/slide',
                                    '34) Sap late due to high Caustic',
                                    '35) Sap late due to low Caustic',
                                    '36) Sap late due to caustic nil'
                                  ].map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  validator: (value) {
                                    return collectiveController
                                        .validateLosses(value);
                                  },
                                  onChanged: (val) {
                                    cirLossesValue!.value = val.toString();
                                    setState(() {});
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
                                  child: Text('Total Time Loss',
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  initialValue: '${cirTimeLoss} min',
                                  focusNode: AlwaysDisabledFocusNode(),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Time In Minutes',
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      final timeTaken =
                          cirendingDate!.difference(cirstartingDate!).inMinutes;
                      ciroverall = timeTaken;
                      if (timeTaken > 90) {
                        cirTimeLoss = timeTaken - 90;
                      }
                      // cirTimeLoss=0;
                      crudObj.updateData(widget.depId, widget.subId,
                          widget.machineId, selectedDoc, {
                        'CirStartTime': this.cir1.text,
                        'CirEndTime': this.cir2.text,
                        'CirActTIme': this.ciroverall,
                        'CirTimeLoss': this.cirTimeLoss,
                        'CirLosses': this.cirLossesValue!.value,
                      }).then((result) {
                        // Get.snackbar('Updated', 'Circulation Updated');
                      }).catchError((e) {
                        print(e);
                      });
                      setState(() {});
                    },
                    child: Text('Update')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
        widget.collectiveModel.date!.microsecondsSinceEpoch);
    var formatedDate = DateFormat.yMMMd().format(dt);
    print('date is${DateFormat.yMMMd().format(dt)}');
    var soapDiff = widget.collectiveModel.actTimeSoap;
    boilno = widget.collectiveModel.boilNo!;
    overall = widget.collectiveModel.overall!;

    sapLossesValue = '${widget.collectiveModel.downTimeLossSoap}'.obs;
    cirLossesValue = '${widget.collectiveModel.downTimeLossCir}'.obs;
    cirTimeLoss = widget.collectiveModel.cirtimeLoss;
    sapTimeLoss = widget.collectiveModel.saptimeLoss;
    water1 = widget.collectiveModel.water1st!;
    water2 = widget.collectiveModel.water2nd!;
    water3 = widget.collectiveModel.watercir!;
    water4 = widget.collectiveModel.watercor!;
    costic1 = widget.collectiveModel.costic1st!;
    costic2 = widget.collectiveModel.costic2nd!;
    costic3 = widget.collectiveModel.costiccir!;
    costic4 = widget.collectiveModel.costiccor!;
    palm1 = widget.collectiveModel.palm1st!;
    palm2 = widget.collectiveModel.palm2nd!;
    palm3 = widget.collectiveModel.palmcir!;
    palm4 = widget.collectiveModel.palmcor!;
    hard1 = widget.collectiveModel.hard1st!;
    hard2 = widget.collectiveModel.hard2nd!;
    hard3 = widget.collectiveModel.hardcir!;
    hard4 = widget.collectiveModel.hardcor!;
    dfa1 = widget.collectiveModel.dfa1st!;
    dfa2 = widget.collectiveModel.dfa2nd!;
    dfa3 = widget.collectiveModel.dfacir!;
    dfa4 = widget.collectiveModel.dfacor!;
    pko1 = widget.collectiveModel.pko1st!;
    pko2 = widget.collectiveModel.pko2nd!;
    pko3 = widget.collectiveModel.pkocir!;
    pko4 = widget.collectiveModel.pkocor!;
    lab1 = widget.collectiveModel.lab1st!;
    lab2 = widget.collectiveModel.lab2nd!;
    lab3 = widget.collectiveModel.labcir!;
    lab4 = widget.collectiveModel.labcor!;
    salt1 = widget.collectiveModel.salt1st!;
    salt2 = widget.collectiveModel.salt2nd!;
    salt3 = widget.collectiveModel.saltcir!;
    salt4 = widget.collectiveModel.saltcor!;
    sv1 = widget.collectiveModel.sv1st!;
    sv2 = widget.collectiveModel.sv2nd!;
    sv3 = widget.collectiveModel.svcir!;
    sv4 = widget.collectiveModel.svcor!;
    tur1 = widget.collectiveModel.tur1st!;
    tur2 = widget.collectiveModel.tur2nd!;
    tur3 = widget.collectiveModel.turcir!;
    tur4 = widget.collectiveModel.turcor!;

    waterAll = widget.collectiveModel.waterAll!;
    costicAll = widget.collectiveModel.costicAll!;
    palmAll = widget.collectiveModel.palmAll!;
    hardAll = widget.collectiveModel.hardAll!;
    dfaAll = widget.collectiveModel.dfaAll!;
    pkoAll = widget.collectiveModel.pkoAll!;
    labAll = widget.collectiveModel.labAll!;
    saltAll = widget.collectiveModel.saltAll!;
    svAll = widget.collectiveModel.svAll!;
    turAll = widget.collectiveModel.turAll!;
    fatAll = widget.collectiveModel.fatChange!;

    Future<void> _cupertinoDialog() async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Delete'),
              content: Text("Press Yes If You Want To Delete whole log.."),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // if(widget.collectiveModel.id=='${widget.collectiveModel.id}${widget.machineId}') {
                    //   crudObj.deleteAnalyticalData(
                    //       widget.depId,
                    //       '${widget.collectiveModel.id}${widget.machineId}');
                    //   crudObj.deleteData(
                    //       widget.depId, widget.subId, widget.machineId,
                    //       widget.collectiveModel.id);

                    // }else {
                    crudObj.deleteData(widget.depId, widget.subId,
                        widget.machineId, widget.collectiveModel.id);
                    crudObj.deleteAnalyticalData(widget.depId,
                        '${widget.collectiveModel.id}${widget.machineId}');

                    // }
                  },
                  child: const Text('Yes'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, "No");
                  },
                  child: const Text('No'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'DETAILS',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _cupertinoDialog();
                  });
                },
                icon: Icon(
                  Icons.delete,
                )),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    // height: 750,
                    // width: 1000,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black.withOpacity(0.7)),
                              child: Center(
                                  child: Text(
                                '${widget.collectiveModel.operator}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black.withOpacity(0.7)),
                              child: Center(
                                  child: Text(
                                'Date : $formatedDate',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black.withOpacity(0.7)),
                              child: Center(
                                  child: Text(
                                '${widget.collectiveModel.base}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 0,
                                child: Container(
                                  height: 410,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                'Log Information',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          _updateLogDialog(
                                                              context,
                                                              widget
                                                                  .collectiveModel
                                                                  .id);
                                                        },
                                                        child: Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.blue),
                                                        ))))
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: new Text("Shift",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                        trailing: new Text(
                                            "${widget.collectiveModel.shift}",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: new Text("Boiler No.",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                        trailing: new Text(
                                            "${widget.collectiveModel.boilNo}",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: new Text("Base No.",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                        trailing: new Text(
                                            "${widget.collectiveModel.base}",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: new Text("Sample No",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                        trailing: new Text(
                                            "${widget.collectiveModel.sampleNo}",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: new Text("Fat Charge",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                        trailing: new Text(
                                            "${widget.collectiveModel.fatChange}",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: new Text("Cir. Time",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                        trailing: new Text(
                                            "${widget.collectiveModel.actTimeCir}/120 min",
                                            style:
                                                new TextStyle(fontSize: 17.0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.black45,
                              height: 400,
                              width: 1,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                child: Text(
                                                  'Saponification',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                              Expanded(
                                                  child: Container(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            _updateSapDialog(
                                                                context,
                                                                widget
                                                                    .collectiveModel
                                                                    .id);
                                                          },
                                                          child: Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .blue),
                                                          ))))
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Sap Start Time",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "${widget.collectiveModel.startTimeSoap}",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Sap End Time",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "${widget.collectiveModel.endTimeSoap}",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Sap Std. Time",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "${widget.collectiveModel.stdTimeSoap}",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Sap Time",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "$soapDiff/180 min",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  Card(
                                    elevation: 0,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                child: Text(
                                                  'Circulation',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                              Expanded(
                                                  child: Container(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            _updateCirDialog(
                                                                context,
                                                                widget
                                                                    .collectiveModel
                                                                    .id);
                                                          },
                                                          child: Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .blue),
                                                          ))))
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Cir. Start Time",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "${widget.collectiveModel.startTimeCir}",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Cir. End Time",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "${widget.collectiveModel.endTimeCir}",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Cir Std. Time",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "${widget.collectiveModel.stdTimeCir}",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          title: new Text("Cir. Time Taken",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                          trailing: new Text(
                                              "${widget.collectiveModel.actTimeCir}/90 min",
                                              style: new TextStyle(
                                                  fontSize: 17.0)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Quantity of Ingredients',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Water',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$water1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.water1st,

                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      water1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$water2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.water2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      water2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$water3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.watercir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      water3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$water4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.watercor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      water4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // //validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: waterAll == 0
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $waterAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Caustic',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$costic1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.costic1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      costic1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$costic2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.costic2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      costic2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$costic3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.costiccir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      costic3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$costic4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.costiccor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      costic4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: costicAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $costicAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Palm Oil',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$palm1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.palm1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      palm1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$palm2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.palm2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      palm2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$palm3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.palmcir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      palm3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$palm4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.palmcor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      palm4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: palmAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $palmAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Hard ST',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$hard1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.hard1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      hard1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$hard2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.hard2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      hard2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$hard3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.hardcir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      hard3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$hard4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.hardcor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      hard4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: hardAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $hardAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Lauric/DFA',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$dfa1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.dfa1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      dfa1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$dfa2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.dfa2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      dfa2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$dfa3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.dfacir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      dfa3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$dfa4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.dfacor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      dfa4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: dfaAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $dfaAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'PKO',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$pko1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.pko1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      pko1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$pko2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.pko2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      pko2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$pko3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.pkocir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      pko3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$pko4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.pkocor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      pko4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: pkoAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $pkoAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Labsa',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$lab1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.lab1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      lab1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$lab2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.lab2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      lab2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$lab3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.labcir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      lab3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$lab4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.labcor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      lab4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: labAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $labAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Salt',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$salt1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.salt1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      salt1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$salt2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.salt2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      salt2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$salt3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.saltcir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      salt3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$salt4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.saltcor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      salt4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: saltAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $saltAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Sodium Versence',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$sv1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.sv1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      sv1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$sv2',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.sv2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      sv2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$sv3',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.svcir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      sv3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$sv4',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.svcor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      sv4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: svAll == null
                                                    ? Text('Loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $svAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            //decoration: BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 16, 8),
                                              child: Center(
                                                  //child: difference == null?
                                                  // Text('Loading...')
                                                  //:
                                                  child: Text(
                                                //child text k liye add ki ha variable k liye remove krni ha
                                                'Turpinol',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                        BorderSide(width: 1))),
                                          ),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 1st Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    initialValue: '$tur1',
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    // controller: collectiveController.tur1st,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      tur1 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text('Actual 2nd Phase',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                  ),
                                                  TextFormField(
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    initialValue:
                                                        '$tur2', // controller: collectiveController.tur2nd,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      tur2 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Circulation',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    initialValue: '$tur3',
                                                    // controller: collectiveController.turcir,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      tur3 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
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
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        'Actual Correction',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  TextFormField(
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    initialValue: '$tur4',
                                                    // controller: collectiveController.turcor,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter in Kg',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    onChanged: (value) {
                                                      tur4 =
                                                          int.tryParse(value) ??
                                                              0;
                                                    },

                                                    // : Text(
                                                    //   homeController.dropDownValue.value,
                                                    // style: TextStyle(color: Colors.black),

                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),

                                                    // validator: (value) {
                                                    //return homeController.validateShift(value);
                                                    //},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: turAll == null
                                                    ? Text('loading...')
                                                    : Text(
                                                        //child text k liye add ki ha variable k liye remove krni ha
                                                        'Total Weight : $turAll Kg',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: RaisedButton(
                                          elevation: 10,
                                          child: Text(
                                              "Update Quantity of Ingredients"),
                                          onPressed: () {
                                            print(widget.machineId +
                                                "......" +
                                                widget.subId +
                                                '....' +
                                                widget.depId +
                                                "....." +
                                                widget.collectiveModel.id);
                                            setState(() {
                                              waterAll = water1! +
                                                  water2! +
                                                  water3! +
                                                  water3!;
                                              costicAll = costic1! +
                                                  costic2! +
                                                  costic3! +
                                                  costic4!;
                                              palmAll = palm1! +
                                                  palm2! +
                                                  palm3! +
                                                  palm4!;
                                              hardAll = hard1! +
                                                  hard2! +
                                                  hard3! +
                                                  hard4!;
                                              dfaAll =
                                                  dfa1! + dfa2! + dfa3! + dfa4!;
                                              pkoAll =
                                                  pko1! + pko2! + pko3! + pko4!;
                                              labAll =
                                                  lab1! + lab2! + lab3! + lab4!;
                                              saltAll = salt1! +
                                                  salt2! +
                                                  salt3! +
                                                  salt4!;
                                              svAll = sv1! + sv2! + sv3! + sv4!;
                                              turAll =
                                                  tur1! + tur2! + tur3! + tur4!;
                                              fatAll = ((palmAll! +
                                                      hardAll! +
                                                      dfaAll! +
                                                      pkoAll! +
                                                      labAll!) /
                                                  1000);
                                              print(
                                                  '$waterAll $costicAll $palmAll $hardAll $dfaAll $pkoAll $labAll $saltAll $svAll $turAll  ');
                                              waterAll = water1! +
                                                  water2! +
                                                  water3! +
                                                  water4!;
                                              crudObj.updateData(
                                                  widget.depId,
                                                  widget.subId,
                                                  widget.machineId,
                                                  widget.collectiveModel.id, {
                                                'Water_1st': this.water1,
                                                'Water_2nd': this.water2,
                                                'Water_Cir': this.water3,
                                                'Water_Cor': this.water4,
                                                'Water_All': this.waterAll,
                                                'Caustic_1st': this.costic1,
                                                'Caustic_2nd': this.costic2,
                                                'Caustic_Cir': this.costic3,
                                                'Caustic_Cor': this.costic4,
                                                'Caustic_All': this.costicAll,
                                                'Palm_Oil_1st': this.palm1,
                                                'Palm_Oil_2nd': this.palm2,
                                                'Palm_Oil_Cir': this.palm3,
                                                'Palm_Oil_Cor': this.palm4,
                                                'Palm_Oil_All': this.palmAll,
                                                'Hard_ST_1st': this.hard1,
                                                'Hard_ST_2nd': this.hard2,
                                                'Hard_ST_Cir': this.hard3,
                                                'Hard_ST_Cor': this.hard4,
                                                'Hard_ST_All': this.hardAll,
                                                'Lauric_DFA_1st': this.dfa1,
                                                'Lauric_DFA_2nd': this.dfa2,
                                                'Lauric_DFA_Cir': this.dfa3,
                                                'Lauric_DFA_Cor': this.dfa4,
                                                'Lauric_DFA_All': this.dfaAll,
                                                'PKO_1st': this.pko1,
                                                'PKO_2nd': this.pko2,
                                                'PKO_Cir': this.pko3,
                                                'PKO_Cor': this.pko4,
                                                'PKO_All': this.pkoAll,
                                                'Labsa_1st': this.lab1,
                                                'Labsa_2nd': this.lab2,
                                                'Labsa_Cir': this.lab3,
                                                'Labsa_Cor': this.lab4,
                                                'Labsa_All': this.labAll,
                                                'Salt_1st': this.salt1,
                                                'Salt_2nd': this.salt2,
                                                'Salt_Cir': this.salt3,
                                                'Salt_Cor': this.salt4,
                                                'Salt_All': this.saltAll,
                                                'Sodium_Versence_1st': this.sv1,
                                                'Sodium_Versence_2nd': this.sv2,
                                                'Sodium_Versence_Cir': this.sv3,
                                                'Sodium_Versence_Cor': this.sv4,
                                                'Sodium_Versence_All':
                                                    this.svAll,
                                                'Turpinol_1st': this.tur1,
                                                'Turpinol_2nd': this.tur2,
                                                'Turpinol_Cir': this.tur3,
                                                'Turpinol_Cor': this.tur4,
                                                'Turpinol_All': this.turAll,
                                                'LogFatChange': this.fatAll,
                                              }).catchError((e) {
                                                Get.snackbar('Error',
                                                    e.message.toString());
                                              });
                                              // Navigator.of(context).pop();
                                            });
                                          },
                                        ))
                                      ],
                                    )

                                    // ListTile(
                                    //     visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //     title: new Text("Water",
                                    //         style: new TextStyle(
                                    //
                                    //             fontSize: 17.0)),
                                    //     leading: new Text('$waterAll Kg'),
                                    //     subtitle: new Text('1st $water1 kg/2nd $water2 kg/Circulation $water3 kg/Actual $water4 kg'),
                                    //     trailing: new TextButton(onPressed: (){
                                    //       setState(() {
                                    //         _updateWaterDialog(context, widget.collectiveModel.id);
                                    //       });
                                    //     }
                                    //         , child: Text('Edit')
                                    //     )
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Caustic",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$costicAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.costic1st} kg/2nd ${widget.collectiveModel.costic2nd} kg/Circulation ${widget.collectiveModel.costiccir} kg/Actual ${widget.collectiveModel.costiccor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updateCosticDialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Palm Oil",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$palmAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.palm1st} kg/2nd ${widget.collectiveModel.palm2nd} kg/Circulation ${widget.collectiveModel.palmcir} kg/Actual ${widget.collectiveModel.palmcor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updatePalmDialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Hard ST",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$hardAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.hard1st} kg/2nd ${widget.collectiveModel.hard2nd} kg/Circulation ${widget.collectiveModel.hardcir} kg/Actual ${widget.collectiveModel.hardcor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updateHardDialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Lauric/Dfa",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$dfaAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.dfa1st} kg/2nd ${widget.collectiveModel.dfa2nd} kg/Circulation ${widget.collectiveModel.dfacir} kg/Actual ${widget.collectiveModel.dfacor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updateDFADialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("PKO",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$pkoAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.pko1st} kg/2nd ${widget.collectiveModel.pko2nd} kg/Circulation ${widget.collectiveModel.pkocir} kg/Actual ${widget.collectiveModel.pkocor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updatePKODialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Labsa",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$labAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.lab1st} kg/2nd ${widget.collectiveModel.lab2nd} kg/Circulation ${widget.collectiveModel.labcir} kg/Actual ${widget.collectiveModel.labcor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updateLabDialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Salt",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$saltAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.salt1st} kg/2nd ${widget.collectiveModel.salt2nd} kg/Circulation ${widget.collectiveModel.saltcir} kg/Actual ${widget.collectiveModel.saltcor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updateSaltDialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Sodium Versence",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$svAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.sv1st} kg/2nd ${widget.collectiveModel.sv2nd} kg/Circulation ${widget.collectiveModel.svcir} kg/Actual ${widget.collectiveModel.svcor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updateSvDialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                    // Divider(height: 0),
                                    // ListTile(
                                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                    //   title: new Text("Turpinol",
                                    //       style: new TextStyle(
                                    //
                                    //           fontSize: 17.0)),
                                    //   leading: new Text('$turAll Kg'),
                                    //   subtitle: new Text('1st ${widget.collectiveModel.tur1st} kg/2nd ${widget.collectiveModel.tur2nd} kg/Circulation ${widget.collectiveModel.turcir} kg/Actual ${widget.collectiveModel.turcor} kg'),
                                    //   trailing: new TextButton(onPressed: (){_updateTurDialog(context, widget.collectiveModel.id);}, child: Text('Edit')),
                                    // ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late DateTime logformattedTime;

  logstartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      logstartingDate = logformattedTime;

      log1.text = DateFormat('hh:mm aa').format(logformattedTime);

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  logendTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      logendingDate = logformattedTime;
      log2.text = DateFormat('hh:mm aa').format(logformattedTime);

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  late DateTime sapformattedTime;

  sapstartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      sapformattedTime = parsedTime;
      print(sapformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      sapstartingDate = sapformattedTime;

      sap1.text = DateFormat('hh:mm aa').format(sapformattedTime);

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  sapendTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      sapendingDate = logformattedTime;

      sap2.text = DateFormat('hh:mm aa').format(logformattedTime);

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  late DateTime cirformattedTime;

  cirstartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      cirstartingDate = logformattedTime;

      cir1.text = DateFormat('hh:mm aa').format(logformattedTime);

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  cirendTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      cirendingDate = logformattedTime;

      cir2.text = DateFormat('hh:mm aa').format(logformattedTime);

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
