import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentController extends GetxController{

  final TextEditingController departmentName = TextEditingController();
  final TextEditingController headName = TextEditingController();
  RxString departmentType = ''.obs;
  final firestore= FirebaseFirestore.instance;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List<String> category = [
    'Production House',
    'Laboratory',
    'Others'
  ];

  final auth = FirebaseAuth.instance;



  String? validateType(String value) {
    if (value == '') {
      return "Please select type";
    } else {
      return null;
    }
  }
  String? validateName(String value) {
   if (value == '') {
      return "Please enter the name of department";
    } else {
      return null;
    }
  }

  String? validateHead(String value) {
    if (value == '') {
      return "please enter the name of department head";
    } else {
      return null;
    }
  }

  Create(name, head, type) async{


      try{
         await firestore.collection('Departments').add({
          'Created_At': DateTime.now(),
          'Company_Id': auth.currentUser!.uid,
          'Department_Name': name,
          'Head_of_Department': head,
          'Department_Type': type,
        }).then((value) => Get.snackbar('Created', 'Department Created Successfully',colorText: Colors.white));

        print(DocumentSnapshot);
      }catch(e){
        Get.snackbar('Error', e.toString(), colorText: Colors.white);
        print(e);
      }


  }


  createDialog(BuildContext context ) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Create Departments'),
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
                        controller: departmentName,
                        decoration: InputDecoration(
                            hintText: 'Name of Department',
                            labelText: 'Department Name'
                        ),
                        validator: (String? value){
                          return validateName(value!);
                        },
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: headName,
                        decoration: InputDecoration(
                            hintText: 'Name of the Head of department',
                            labelText: 'Head of Department'
                        ),
                        validator: (String? value){
                          return validateHead(value!);
                        },
                      ),
                      DropdownButtonFormField(
                        hint: departmentType ==
                            ''
                            ? Text('Select Department type')
                            : Text(
                          departmentType.value,
                          style:
                          TextStyle(color: Colors.black),
                        ),
                        isExpanded: true,
                        iconSize: 20.0,
                        style: TextStyle(
                            color: Colors.black, fontSize: 15),
                        items: category.map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        validator: (String? value)=> value==null? 'please select type': null,
                        onChanged: (val) {
                          departmentType.value = val.toString();
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
                      Create(departmentName.text ,headName.text, departmentType.value);
                      departmentName.clear();
                      headName.clear();
                      departmentType=''.obs;
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