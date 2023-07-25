import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Logs/LogController.dart';

class Circulation extends StatefulWidget {
  const Circulation({Key? key}) : super(key: key);

  @override
  State<Circulation> createState() => _CirculationState();
}

class _CirculationState extends State<Circulation> {
  final collectiveController = Get.put(LogController());
  @override
  Widget build(BuildContext context) {
    final cirDifference = collectiveController.cirendingDate
        .difference(collectiveController.cirstartingDate)
        .inMinutes;
    // String stdTime2 = '90';
    int cirActual = collectiveController.cirDiff;

    return Card(
      child: Column(children: [
        Container(
          child: Text(
            'CIRCULATION',
            style: TextStyle(color: Colors.brown, fontSize: 25),
          ),
        ),
        SizedBox(
          height: 10,
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
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 22),
                    validator: (value) {
                      return collectiveController.validateStartTime(value!);
                    },
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: collectiveController.cirStartTime,
                    onTap: () {
                      collectiveController.cirstartTime(context);
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
                    style: TextStyle(fontSize: 22),
                    validator: (value) {
                      return collectiveController.validateEndingTime(value!);
                    },
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: collectiveController.cirEndTime,
                    onTap: () async {
                      collectiveController.cirendTime(context);
                    },
                    decoration: InputDecoration(
                        labelText: 'End Time:',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 15),
                        border: UnderlineInputBorder()),
                    onFieldSubmitted: (context) {
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Container(
              height: 70,
              decoration: BoxDecoration(border: Border.all()),
              child: Center(
                  child: Text(
                'Circulation Std Time: 90 min',
                style: TextStyle(fontSize: 18),
              )),
            )),
            Expanded(
              child: Container(
                height: 70,
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                    child: cirDifference == null
                        ? Text('Loading...')
                        : Text(
                            //child text k liye add ki ha variable k liye remove krni ha
                            'Circulation Actual Time: $cirActual min',
                            style: TextStyle(fontSize: 18),
                          )),
              ),
            )
          ],
        ),
        Divider(),
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
                        onTap: () {
                          setState(() {});
                        },
                        hint: Text('Select Losses'),
                        isExpanded: true,
                        iconSize: 20.0,
                        style: TextStyle(color: Colors.black, fontSize: 15),
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
                        validator: (value) => value == null
                            ? 'Please Select none if no loss'
                            : null,
                        onChanged: (val) {
                          collectiveController.cirLossesValue.value =
                              val.toString();
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
                            'Other Losses',
                            style: TextStyle(fontSize: 15),
                          )),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: collectiveController.cirOtherLoss,
                        decoration: InputDecoration(
                          hintText: 'Enter Time In Minutes',
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 15),
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
