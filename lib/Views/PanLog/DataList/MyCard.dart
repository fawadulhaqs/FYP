import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_fyp_impas/Models/PanLogModel.dart';

import 'SingleItem.dart';

class MyCard extends StatefulWidget {
  final CollectiveModel collectiveModel;
  final depId;
  final subId;
  final machineId;
  const MyCard({Key? key, required this.collectiveModel, this.depId, this.subId, this.machineId}) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  navigateToDetails(CollectiveModel collectiveModel){

    Get.to(()=>SingleCard(depId: widget.depId,
        subId: widget.subId,
        machineId: widget.machineId,collectiveModel: collectiveModel));
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
        widget.collectiveModel.date!.microsecondsSinceEpoch);
    var formatedDate = DateFormat.yMMMd().format(dt);
    return Card(
      elevation: 10,
      child: ListTile(
          title: new Text('$formatedDate'),
          subtitle: new Text('${widget.collectiveModel.operator}'),
          leading: new Text('${widget.collectiveModel.shift}'),
          trailing: new Text('${widget.collectiveModel.base}'),
          onTap: (){
            setState(() {
              navigateToDetails(widget.collectiveModel);
            });
          }
      ),

    );
  }
}
