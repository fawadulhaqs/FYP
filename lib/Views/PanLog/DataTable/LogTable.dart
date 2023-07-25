import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/Logs/LogController.dart';
import 'package:project_fyp_impas/Views/PanLog/DataTable/LogTableWidget.dart';

class LogTable extends StatefulWidget {
  final depId;
  final subId;
  final machineId;
  const LogTable({Key? key, this.depId, this.subId, this.machineId}) : super(key: key);

  @override
  _LogTableState createState() => _LogTableState();
}

class _LogTableState extends State<LogTable> {
  final collectiveController = Get.put(LogController());

  int limit=10;
  RxString Limit= ''.obs;
  @override
  void initState() {
    collectiveController.getlist(widget.depId,widget.subId,widget.machineId,limit);
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: DropdownButtonFormField(
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
                collectiveController.getlist(widget.depId,widget.subId,widget.machineId,limit);
                setState(() {

                });
              }
              else if(val=='Last Month'){
                Limit.value = val.toString();
                limit=90;
                collectiveController.getlist(widget.depId,widget.subId,widget.machineId,limit);
                setState(() {

                });
              }
              else if(val=='Last 3 Months'){
                Limit.value = val.toString();
                limit=270;
                collectiveController.getlist(widget.depId,widget.subId,widget.machineId,limit);
                setState(() {

                });
                }
            },
          ),
        ),
        body: GetX<LogController>(
          init: Get.put<LogController>(LogController()),
          builder: (LogController collectiveController)
          {
            if (collectiveController != null &&
                collectiveController.log != null) {
              return Container(
                height: MediaQuery.of(context).size.height / 1.1,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      collectiveController.delay=0;
                      collectiveController.noDelay=0;
                      collectiveController.per=0.0;
                      print('percentage issssssssss ${collectiveController.per}');

                      return LogTableWidget(
                          model: collectiveController.log![index]);

                    }),
              );

            } else {
              return Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
