import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LineLogController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  TextEditingController numProduct = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController logdate = TextEditingController();
  TextEditingController stdTime = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController idleTime = TextEditingController();
  TextEditingController idleRsn = TextEditingController();
  TextEditingController idleStartTime = TextEditingController();
  TextEditingController idleEndTime = TextEditingController();
  TextEditingController idleTimeTaken = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime logstartingDate = DateTime.now();
  DateTime logendingDate = DateTime.now();

  DateTime idlestartingDate = DateTime.now();
  DateTime idleendingDate = DateTime.now();
  int idleDiff = 0;

  RxString logShift = ''.obs;

  List<int> numberList = [];
  List<String> rsnList = [];
  int idleTimeMin = 0;
//Availability
  int overallTime = 0;
  double availabilityPercentage = 0.0;

  String? validateDate(String value) {
    if (value.length == 0) {
      return "Date can't be Empty";
    } else {
      return null;
    }
  }

  String? validateStartTime(String value) {
    if (value.length == 0) {
      return "Please select Starting Time";
    } else {
      return null;
    }
  }

  String? validateEndingTime(String value) {
    if (value.length == 0) {
      return "Please select Ending Time";
    } else {
      return null;
    }
  }

  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      logdate
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: logdate.text.length, affinity: TextAffinity.upstream));
    }
  }

  late DateTime logformattedTime;

  logstartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      logstartingDate = logformattedTime;

      startTime.text = DateFormat('hh:mm aa').format(logformattedTime);
      if (logendingDate.difference(logstartingDate).inMinutes < 0.0) {
        overallTime =
            logendingDate.difference(logstartingDate).inMinutes + 1440;
        print('Overall when negative $overallTime');
      } else {
        overallTime = logendingDate.difference(logstartingDate).inMinutes;
        print('Overall when positive $overallTime');
      }

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  logendTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      overallTime = 0;
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      logendingDate = logformattedTime;

      endTime.text = DateFormat('hh:mm aa').format(logformattedTime);
      if (logendingDate.difference(logstartingDate).inMinutes < 0.0) {
        overallTime =
            logendingDate.difference(logstartingDate).inMinutes + 1440;
        print('Overall when negative $overallTime');
      } else {
        overallTime = logendingDate.difference(logstartingDate).inMinutes;
        print('Overall when positive $overallTime');
      }

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  late DateTime sapformattedTime;

  idlestartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      idlestartingDate = logformattedTime;

      idleStartTime.text = DateFormat('hh:mm aa').format(logformattedTime);
      if (idleendingDate.difference(idlestartingDate).inMinutes < 0.0) {
        idleDiff = idleendingDate.difference(idlestartingDate).inMinutes + 1440;
        print('Overall when negative $idleDiff');
      } else {
        idleDiff = idleendingDate.difference(idlestartingDate).inMinutes;
        print('Overall when positive $idleDiff');
      }

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  idleendTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      // sDiff = 0;
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      idleendingDate = logformattedTime;

      idleEndTime.text = DateFormat('hh:mm aa').format(logformattedTime);
      if (idleendingDate.difference(idlestartingDate).inMinutes < 0.0) {
        idleDiff = idleendingDate.difference(idlestartingDate).inMinutes + 1440;
        idleTimeTaken.text =
            idleendingDate.difference(idlestartingDate).inMinutes.toString();
        print('Overall when negative $idleDiff');
      } else {
        idleDiff = idleendingDate.difference(idlestartingDate).inMinutes;
        idleTimeTaken.text =
            idleendingDate.difference(idlestartingDate).inMinutes.toString();
        print('Overall when positive $idleDiff');
      }

      print('Text Editing Controller   ${idleTimeTaken.text}');

      print(" difference is  $idleDiff");

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  OnContinue(depId, subId, machineId) async {
    try {
      await firestore
          .collection('Departments')
          .doc(depId)
          .collection('Sub-Department')
          .doc(subId)
          .collection('Machines')
          .doc(machineId)
          .collection('Logs')
          .add({
        'SentAt': DateTime.now(),
        'LogDate': _selectedDate,
        'LogStartTime': startTime.text,
        'LogEndingTime': endTime.text,
        'Total_Ideal_Time': overallTime,
        'IdleTime': idleTimeMin,
        'Shift': logShift.value,
        'Issues_List': rsnList,
        'Min_Loss_List': numberList,
        'Availability': availabilityPercentage
      }).then((value) {
        Get.snackbar('Saved', '', colorText: Colors.white);
        firestore
            .collection('Departments')
            .doc(depId)
            .collection('Analysis')
            .doc('${value.id}${machineId}')
            .set({
          'Sent_At': _selectedDate,
          'Performance': availabilityPercentage
        });
      });
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
