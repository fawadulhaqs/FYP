import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class crudeMethods{

  getData() async{
    return await FirebaseFirestore.instance.collection('logSheetInfo').get();
  }

  updateData(depId,subId,machineId,selectedDoc,newValues) async{
    await FirebaseFirestore.instance.collection('prices').doc(depId)
        .collection('Sub-Department')
        .doc(subId)
        .collection('Machines')
        .doc(machineId)
        .collection('Log')
        .doc(selectedDoc)
        .update(newValues).catchError((e) {
      print(e);
    });

  }
  
  AnalyticalUpdate(depId,selectedDoc,newValues)async{
    await FirebaseFirestore.instance.collection('Departments').doc(depId).collection('Analysis').doc(selectedDoc).update(newValues).catchError((e){
      Get.snackbar('Error', e.message.toString());
    });
    
  }
  deleteAnalyticalData(depId, selectedDoc)async{
    try{
      await FirebaseFirestore.instance.collection('Departments').doc(depId).collection('Analysis').doc(selectedDoc).delete();
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }
  
  deleteData(depId,subId,machineId,docId)async {
    try {
      await FirebaseFirestore.instance.collection('Departments').doc(depId)
          .collection('Sub-Department')
          .doc(subId)
          .collection('Machines')
          .doc(machineId)
          .collection('Log')
          .doc(docId).delete().then((value) {
            Get.snackbar('Deleted', 'your document is deleted');
            Get.back();
      });
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }
}