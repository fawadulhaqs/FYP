import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LineLogList extends StatefulWidget {
  final depId;
  final subId;
  final machineId;
  const LineLogList({Key? key, this.depId, this.subId, this.machineId}) : super(key: key);

  @override
  _LineLogListState createState() => _LineLogListState();
}

class _LineLogListState extends State<LineLogList> {
  int limit=10;
  RxString duration=''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: DropdownButtonFormField(
          hint:Text('Select Duration'),

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
              duration.value = val.toString();
              limit=21;
              setState(() {

              });
            }
            else if(val=='Last Month'){
              duration.value = val.toString();
              limit=90;
              setState(() {

              });
            }
            else if(val=='Last 3 Months'){
              duration.value = val.toString();
              limit=270;
              setState(() {

              });
            }
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Departments')
            .doc(widget.depId)
            .collection('Sub-Department')
            .doc(widget.subId)
            .collection('Machines')
            .doc(widget.machineId)
            .collection('Logs')
            .orderBy('LogDate',descending: true).limit(limit)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index];
                  DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
                      data['LogDate'].microsecondsSinceEpoch);
                  var formatedDate = DateFormat.yMMMd().format(dt);
                  double availability = data['Availability'];
                  if (data['Availability'] < 60.0) {
                    
                    return Card(
                      // color: Colors.red,
                      elevation: 5,
                      child: ListTile(
                          trailing: IconButton(
                            onPressed: (){
                              Get.defaultDialog(
                                  title: 'Delete',
                                  content: Text('Are you sure you want to delete?'),
                                  confirm: TextButton(onPressed: ()async{
                                    await FirebaseFirestore.instance
                                        .collection('Departments')
                                        .doc(widget.depId)
                                        .collection('Sub-Department')
                                        .doc(widget.subId)
                                        .collection('Machines')
                                        .doc(widget.machineId)
                                        .collection('Logs').doc(data.id).delete();
                                  },
                                      child: Text('Yes')
                                  ),
                                  cancel: TextButton(onPressed: (){Get.back();}, child: Text('No'))
                              );
                            },
                            icon: Icon(Icons.delete,color: Colors.red,),
                          ),
                          subtitle: (Text('Shift: ${data['Shift']}')),
                          leading: Text(
                            '${availability.toStringAsFixed(1)}%',
                            style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          title: Text('$formatedDate')
                      ),
                    );
                  } else {
                    return Card(
                      // color: Colors.grey,
                      elevation: 5,
                      child: ListTile(
                          trailing: IconButton(
                            onPressed: (){
                              Get.defaultDialog(
                                  title: 'Delete',
                                  content: Text('Are you sure you want to delete?'),
                                  confirm: TextButton(onPressed: ()async{
                                    await FirebaseFirestore.instance
                                        .collection('Departments')
                                        .doc(widget.depId)
                                        .collection('Sub-Department')
                                        .doc(widget.subId)
                                        .collection('Machines')
                                        .doc(widget.machineId)
                                        .collection('Logs').doc(data.id).delete();
                                    await FirebaseFirestore.instance.collection('Departments').doc(widget.depId).collection('Analysis').doc('${data.id}${widget.machineId}').delete().catchError((e){Get.snackbar('Error', e.toString());});
                                  },
                                      child: Text('Yes')
                                  ),
                                cancel: TextButton(onPressed: (){Get.back();}, child: Text('No'))
                              );
                            },
                            icon: Icon(Icons.delete,color: Colors.red,),
                          ),
                          subtitle: (Text('Shift: ${data['Shift']}')),
                          leading: Text(
                            '${availability.toStringAsFixed(1)}%',
                            style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          title: Text('$formatedDate')),
                    );
                  }
                }),
          );
        },
      ),
    );
  }
}
