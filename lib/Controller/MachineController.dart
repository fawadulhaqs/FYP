

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MachineController extends GetxController{
  TextEditingController machhineName =TextEditingController();
  TextEditingController addIssues =TextEditingController();
  RxString machineType =''.obs;
  TextEditingController stdTime =TextEditingController();
  final firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  String? validateName(String value) {
    if (value == '') {
      return "Enter the name";
    } else {
      return null;
    }
  }
  String? validateType(String value) {
    if (value == '') {
      return "Please select type";
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


  Create( depid, subid) async{


    try{
      await firestore.collection('Departments').doc(depid).collection('Sub-Department').doc(subid).collection('Machines').add({
        'SentAt': DateTime.now(),
        'Machine_Name': machhineName.text,
        'Machine_Type':machineType.value,
        'Machine_STD_Time': int.parse(stdTime.text),
        'Idle_Time': 0,
        'Total_Logs': 0,
        'On_time_Logs': 0
      }).then((value) => Get.snackbar('Added', 'Machine added Successfully',colorText: Colors.white));

    }catch(e){
      Get.snackbar('Error', e.toString(), colorText: Colors.white);
    }




  }


  createDialog(context,depId, subId){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Add Machines'),
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
                        controller: machhineName,
                        decoration: InputDecoration(
                            hintText: 'Eg: Machine Line 1',
                            labelText: 'Machine Name and Number*'
                        ),
                        validator: (String? value){
                          return validateName(value!);
                        },
                      ),
                      DropdownButtonFormField(
                        hint: machineType ==
                            ''
                            ? Text('Select Machine type')
                            : Text(
                          machineType.value,
                          style:
                          TextStyle(color: Colors.black),
                        ),
                        isExpanded: true,
                        iconSize: 20.0,
                        style: TextStyle(
                            color: Colors.black, fontSize: 15),
                        items: [
                          'Baser or Pan, for base making',
                          'Mixer',
                          'Continues Machines/Non-stop Machines',
                        ].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        validator: (String? value) => value == null ? 'please select type':null,
                        onChanged: (val) {
                          machineType.value = val.toString();
                        },
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.phone,
                        controller: stdTime,
                        decoration: InputDecoration(
                            hintText: 'Standard Time in minutes. Eg: 300(5 hours)',
                            labelText: 'Standard Time'
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
                      Create(depId, subId);
                      Get.back();
                      machhineName.clear();
                      stdTime.clear();
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