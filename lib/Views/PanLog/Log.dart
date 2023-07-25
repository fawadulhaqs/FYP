import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/Logs/LogController.dart';

import 'Circulation.dart';
import 'Ingrediaents.dart';
import 'LogScreen.dart';
import 'Saponification.dart';

// import '../Widgets/CostomDropdown.dart';

class Log extends StatefulWidget {
  final machine;
  final subid;
  final depid;
  const Log({Key? key, this.machine, this.subid, this.depid}) : super(key: key);

  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  void initState() {
    // logController.getIssues();
    super.initState();
  }

  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final collectiveController = Get.put(LogController());
    // final collectiveController = Get.put(CollectiveController());
    print(collectiveController.sapstartingDate);
    print(collectiveController.sapendingDate);

    print(collectiveController.cirstartingDate);
    print(collectiveController.cirendingDate);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
            key: _myKey,
            child: Column(children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                        alignment: Alignment(-1, 0),
                        onPressed: () {
                          collectiveController.clearfield();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.cleaning_services_rounded,
                          color: Colors.red,
                        )),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "LOG's",
                        style: TextStyle(color:Colors.brown,fontSize: 25),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        alignment: Alignment(1, 0),
                        onPressed: () {
                          final isValid = _myKey.currentState!.validate();
                          if (isValid) {
                            collectiveController.onContinue(
                                widget.depid, widget.subid, widget.machine.id);
                            print(collectiveController.waterAll);
                          }
                        },
                        icon: Icon(
                          Icons.save, color: Colors.brown,
                        )),
                  ),
                ],
              ),
              LogScreen(),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Saponifiaction(),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Circulation(),
              SizedBox(height: 10),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Ingredients()
            ]),
          ),
        ]),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
