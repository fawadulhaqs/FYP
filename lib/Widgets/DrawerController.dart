import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Views/Home/Dashboard.dart';
import 'package:project_fyp_impas/Views/SubDepartment/Subdepartments.dart';

class MyDrawerController extends GetxController{
  final auth = FirebaseAuth.instance;
  void signOut() async{
    try{auth.signOut();}
    catch(e){
      Get.snackbar('Error', e.toString());
    }
  }
  DepStream(){
    try {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Departments').orderBy(
            'Department_Name').where(
            'Company_Id', isEqualTo: auth.currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(data['Department_Name'] ?? ""),
                  subtitle: Text(data['Department_Type']),
                  onTap: () async {
                    Get.offAll(Dashboard());
                    Get.to(SubDepartments(data: data));
                  },
                );
              }
          );
        },
      );
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

}