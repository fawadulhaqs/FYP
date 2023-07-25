
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SubDepartmentController extends GetxController{
  TextEditingController subname= TextEditingController();
  TextEditingController subhead= TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  String? validateName(String value) {
    if (value == '') {
      return "Enter the name of sub-department";
    } else {
      return null;
    }
  }

  String? validateHead(String value) {
    if (value == '') {
      return "Enter the name of sub-department head";
    } else {
      return null;
    }
  }


  Create( id) async{


    try{
      await firestore.collection('Departments').doc(id).collection('Sub-Department').add({
        'Sub-Department_Name': subname.text,
        'Head_of_Sub-Department': subhead.text,
        // 'Department_Type': type,
      }).then((value) => Get.snackbar('Created', 'Su-Department Created Successfully',colorText: Colors.white));

    }catch(e){
      Get.snackbar('Error', e.toString(), colorText: Colors.white);
    }




  }


  createDialog(context,id){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Create Sub-Departments'),
            content: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height,
              child: Form(
                key: _globalKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        controller: subname,
                        decoration: InputDecoration(
                            hintText: 'Name of Sub-Department',
                            labelText: 'Sub-Department Name'
                        ),
                        validator: (String? value){
                          return validateName(value!);
                        },
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: subhead,
                        decoration: InputDecoration(
                            hintText: 'Name of the Head of Sub-department',
                            labelText: 'Head of Sub-Department'
                        ),
                        validator: (String? value){
                          return validateHead(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    final isvalid=_globalKey.currentState!.validate();
                    if(!isvalid){
                      Get.snackbar('Incomplete', 'Form is incomplete',colorText: Colors.white);
                    }
                    else{
                      Create(id);
                      subname.clear();
                      subhead.clear();
                      Get.back();
                    }
                    _globalKey.currentState!.validate();

                  },
                  child: Text('Create')
              ),
              TextButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: Text('Cancel')
              )
            ],
          );
        }
    );
  }


}