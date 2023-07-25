import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Models/PanLogModel.dart';

class LogController extends GetxController {
  TextEditingController logDate = TextEditingController();
  TextEditingController logStartTime = TextEditingController();
  TextEditingController logEndTime = TextEditingController();
  TextEditingController logBoiler = TextEditingController();
  TextEditingController logFatCharge = TextEditingController();
  TextEditingController logSample = TextEditingController();
  TextEditingController sapStartTime = TextEditingController();
  TextEditingController sapEndTime = TextEditingController();
  TextEditingController sapTimeLoss = TextEditingController();
  TextEditingController sapOtherLoss = TextEditingController();
  TextEditingController cirStartTime = TextEditingController();
  TextEditingController cirEndTime = TextEditingController();
  // TextEditingController cirTimeLoss = TextEditingController();
  TextEditingController cirOtherLoss = TextEditingController();
  TextEditingController water1st = TextEditingController();
  TextEditingController water2nd = TextEditingController();
  TextEditingController watercir = TextEditingController();
  TextEditingController watercor = TextEditingController();
  TextEditingController costic1st = TextEditingController();
  TextEditingController costic2nd = TextEditingController();
  TextEditingController costiccir = TextEditingController();
  TextEditingController costiccor = TextEditingController();
  TextEditingController palm1st = TextEditingController();
  TextEditingController palm2nd = TextEditingController();
  TextEditingController palmcir = TextEditingController();
  TextEditingController palmcor = TextEditingController();
  TextEditingController hard1st = TextEditingController();
  TextEditingController hard2nd = TextEditingController();
  TextEditingController hardcir = TextEditingController();
  TextEditingController hardcor = TextEditingController();
  TextEditingController dfa1st = TextEditingController();
  TextEditingController dfa2nd = TextEditingController();
  TextEditingController dfacir = TextEditingController();
  TextEditingController dfacor = TextEditingController();
  TextEditingController pko1st = TextEditingController();
  TextEditingController pko2nd = TextEditingController();
  TextEditingController pkocir = TextEditingController();
  TextEditingController pkocor = TextEditingController();
  TextEditingController lab1st = TextEditingController();
  TextEditingController lab2nd = TextEditingController();
  TextEditingController labcir = TextEditingController();
  TextEditingController labcor = TextEditingController();
  TextEditingController salt1st = TextEditingController();
  TextEditingController salt2nd = TextEditingController();
  TextEditingController saltcir = TextEditingController();
  TextEditingController saltcor = TextEditingController();
  TextEditingController sv1st = TextEditingController();
  TextEditingController sv2nd = TextEditingController();
  TextEditingController svcir = TextEditingController();
  TextEditingController svcor = TextEditingController();
  TextEditingController tur1st = TextEditingController();
  TextEditingController tur2nd = TextEditingController();
  TextEditingController turcir = TextEditingController();
  TextEditingController turcor = TextEditingController();

  String setterId = '';
  double? analysis;

  DateTime sapstartingDate = DateTime.now();
  DateTime sapendingDate = DateTime.now();
  DateTime cirstartingDate = DateTime.now();
  DateTime cirendingDate = DateTime.now();

  DateTime logstartingDate = DateTime.now();
  DateTime logendingDate = DateTime.now();

  late int overallTime;

  int noDelay = 0;
  int delay = 0;

  double per = 0.00;

  late int totalLength;

  int cirDiff = 0;
  int sapDiff = 0;

  int cirloss = 0;
  int saploss = 0;

  int water2 = 0;
  int water1 = 0;
  int water3 = 0;
  int water4 = 0;
  int costic2 = 0;
  int costic1 = 0;
  int costic3 = 0;
  int costic4 = 0;
  int palm2 = 0;
  int palm1 = 0;
  int palm3 = 0;
  int palm4 = 0;
  int hard1 = 0;
  int hard2 = 0;
  int hard3 = 0;
  int hard4 = 0;
  int dfa2 = 0;
  int dfa1 = 0;
  int dfa3 = 0;
  int dfa4 = 0;
  int pko2 = 0;
  int pko1 = 0;
  int pko3 = 0;
  int pko4 = 0;
  int lab2 = 0;
  int lab1 = 0;
  int lab3 = 0;
  int lab4 = 0;
  int salt2 = 0;
  int salt1 = 0;
  int salt3 = 0;
  int salt4 = 0;
  int sv2 = 0;
  int sv1 = 0;
  int sv3 = 0;
  int sv4 = 0;
  int tur2 = 0;
  int tur1 = 0;
  int tur3 = 0;
  int tur4 = 0;

  int waterAll = 0;
  int costicAll = 0;
  int palmAll = 0;
  int hardAll = 0;
  int dfaAll = 0;
  int pkoAll = 0;
  int labAll = 0;
  int saltAll = 0;
  int svAll = 0;
  int turAll = 0;
  double fatAll = 0;

  DateTime _selectedDate = DateTime.now();
  RxString shiftValue = ''.obs;
  RxString baseValue = ''.obs;
  RxString panValue = ''.obs;
  RxString operatorValue = ''.obs;
  RxString sapLossesValue = ''.obs;
  RxString sapOtherLossesValue = ''.obs;
  RxString cirLossesValue = ''.obs;
  RxString cirOtherLossesValue = ''.obs;

  String sapStdTime = '180';
  String cirStdTime = '90';
  final firebaseFirestore = FirebaseFirestore.instance;

  Rxn<List<CollectiveModel>> collectiveList = Rxn<List<CollectiveModel>>();

  List<CollectiveModel>? get log => collectiveList.value;

  void getlist(depId, subId, machineId, limit) {
    collectiveList.bindStream(commonStream(depId, subId, machineId, limit));
  }

  Stream<List<CollectiveModel>> commonStream(depId, subId, machineId, limit) {
    print("enter in add function");
    return firebaseFirestore
        .collection('Departments')
        .doc(depId)
        .collection('Sub-Department')
        .doc(subId)
        .collection('Machines')
        .doc(machineId)
        .collection('Log')
        .orderBy('LogDate', descending: true)
        .limit(limit)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<CollectiveModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(CollectiveModel.fromDocumentSnapShot(element));
      });

      print('length is ${retVal.length}');
      totalLength = retVal.length;
      return retVal;
    });
  }

  // getSearch(String querry) async{
  //   FirebaseFirestore.instance.collection('logSheetInfo').where('logShift', isEqualTo: querry).get().then((value) => =value.docs);
  // }

  Future<void> addCollectiveData(
      String depId,
      String subId,
      String machineId,
      DateTime date,
      String shift,
      String base,
      String boilNo,
      String panNo,
      double fatChange,
      String startTime,
      String endTime,
      String operator,
      String sampleNo,
      int overallTime,
      String sapStartTime,
      String sapEndTime,
      int sapTimeLoss,
      String sapStdTime,
      int sapDiff,
      String saplosses,
      String sapOtherLosses,
      String cirStartTime,
      String cirEndTime,
      int cirTimeLoss,
      String cirStdTime,
      int cirDiff,
      String cirLosses,
      String cirOtherLosses,
      int water1st,
      int water2nd,
      int watercir,
      int watercor,
      int waterall,
      int costic1st,
      int costic2nd,
      int costiccir,
      int costiccor,
      int costicall,
      int palm1st,
      int palm2nd,
      int palmcir,
      int palmcor,
      int palmall,
      int hard1st,
      int hard2nd,
      int hardcir,
      int hardcor,
      int hardall,
      int dfa1st,
      int dfa2nd,
      int dfacir,
      int dfacor,
      int dfaall,
      int pko1st,
      int pko2nd,
      int pkocir,
      int pkocor,
      int pkoall,
      int lab1st,
      int lab2nd,
      int labcir,
      int labcor,
      int laball,
      int salt1st,
      int salt2nd,
      int saltcir,
      int saltcor,
      int saltall,
      int sv1st,
      int sv2nd,
      int svcir,
      int svcor,
      int svall,
      int tur1st,
      int tur2nd,
      int turcir,
      int turcor,
      int turall) async {
    try {
      double analyticPer = 0;
      if (overallTime > 330) {
        analyticPer = (330 / overallTime) * 100;
        analysis = analyticPer;
      } else {
        analyticPer = 100.0;
        analysis = analyticPer;
      }

      await firebaseFirestore
          .collection('Departments')
          .doc(depId)
          .collection('Sub-Department')
          .doc(subId)
          .collection('Machines')
          .doc(machineId)
          .collection('Log')
          .add({
        'LogDate': date,
        'LogSentAt': Timestamp.now(),
        'LogShift': shift,
        'LogBase': base,
        'LogBoilNo': boilNo,
        'LogPanNo': panNo,
        'LogFatChange': fatChange,
        'LogStartTime': startTime,
        'LogEndTime': endTime,
        'LogOperator': operator,
        'LogsampleNo': sampleNo,
        'Analytical_Percentage': analysis,
        'OverAllTime': overallTime,
        'SapStartTime': sapStartTime,
        'SapEndTime': sapEndTime,
        'SapTimeLoss': sapTimeLoss,
        'SapStdTime': '180',
        'SapActTime': sapDiff,
        'SapLosses': saplosses,
        'SapOtherLosses': sapOtherLosses,
        'CirStartTime': cirStartTime,
        'CirEndTime': cirEndTime,
        'CirTimeLoss': cirTimeLoss,
        'CirStdTime': '90',
        'CirActTIme': cirDiff,
        'CirLosses': cirLosses,
        'CirOtherLosses': cirOtherLosses,
        'Water_1st': water1st,
        'Water_2nd': water2nd,
        'Water_Cir': watercir,
        'Water_Cor': watercor,
        'Water_All': waterall,
        'Caustic_1st': costic1st,
        'Caustic_2nd': costic2nd,
        'Caustic_Cir': costiccir,
        'Caustic_Cor': costiccor,
        'Caustic_All': costicall,
        'Palm_Oil_1st': palm1st,
        'Palm_Oil_2nd': palm2nd,
        'Palm_Oil_Cir': palmcir,
        'Palm_Oil_Cor': palmcor,
        'Palm_Oil_All': palmall,
        'Hard_ST_1st': hard1st,
        'Hard_ST_2nd': hard2nd,
        'Hard_ST_Cir': hardcir,
        'Hard_ST_Cor': hardcor,
        'Hard_ST_All': hardall,
        'Lauric_DFA_1st': dfa1st,
        'Lauric_DFA_2nd': dfa2nd,
        'Lauric_DFA_Cir': dfacir,
        'Lauric_DFA_Cor': dfacor,
        'Lauric_DFA_All': dfaall,
        'PKO_1st': pko1st,
        'PKO_2nd': pko2nd,
        'PKO_Cir': pkocir,
        'PKO_Cor': pkocor,
        'PKO_All': pkoall,
        'Labsa_1st': lab1st,
        'Labsa_2nd': lab2nd,
        'Labsa_Cir': labcir,
        'Labsa_Cor': labcor,
        'Labsa_All': laball,
        'Salt_1st': salt1st,
        'Salt_2nd': salt2nd,
        'Salt_Cir': saltcir,
        'Salt_Cor': saltcor,
        'Salt_All': saltall,
        'Sodium_Versence_1st': sv1st,
        'Sodium_Versence_2nd': sv2nd,
        'Sodium_Versence_Cir': svcir,
        'Sodium_Versence_Cor': svcor,
        'Sodium_Versence_All': svall,
        'Turpinol_1st': tur1st,
        'Turpinol_2nd': tur2nd,
        'Turpinol_Cir': turcir,
        'Turpinol_Cor': turcor,
        'Turpinol_All': turall
      }).then((value) {
        print(value.id);
        setterId = value.id;
        Get.snackbar('Success', 'Information Saved!');

        firebaseFirestore
            .collection('Departments')
            .doc(depId)
            .collection('Analysis')
            .doc("${value.id}${machineId}")
            .set({'Sent_At': _selectedDate, 'Performance': analysis});
      });
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  void onContinue(depId, subId, machineId) {
    // assign();
    addCollectiveData(
      depId,
      subId,
      machineId,
      _selectedDate,
      shiftValue.value,
      baseValue.value,
      logBoiler.text,
      panValue.value,
      fatAll,
      logStartTime.text,
      logEndTime.text,
      operatorValue.value,
      logSample.text,
      overallTime,
      sapStartTime.text,
      sapEndTime.text,
      saploss,
      sapStdTime,
      sapDiff,
      sapLossesValue.value,
      sapOtherLossesValue.value,
      cirStartTime.text,
      cirEndTime.text,
      cirloss,
      cirStdTime,
      cirDiff,
      cirLossesValue.value,
      cirOtherLossesValue.value,
      water1,
      water2,
      water3,
      water4,
      waterAll,
      costic1,
      costic2,
      costic3,
      costic4,
      costicAll,
      palm1,
      palm2,
      palm3,
      palm4,
      palmAll,
      hard1,
      hard2,
      hard3,
      hard4,
      hardAll,
      dfa1,
      dfa2,
      dfa3,
      dfa4,
      dfaAll,
      pko1,
      pko2,
      pko3,
      pko4,
      pkoAll,
      lab1,
      lab2,
      lab3,
      lab4,
      labAll,
      salt1,
      salt2,
      salt3,
      salt4,
      saltAll,
      sv1,
      sv2,
      sv3,
      sv4,
      svAll,
      tur1,
      tur2,
      tur3,
      tur4,
      turAll,
    );
    double analyticPer = 0;
    if (overallTime > 330) {
      analyticPer = (330 / overallTime) * 100;
    } else {
      analyticPer = 100.0;
    }

    firebaseFirestore
        .collection('Departments')
        .doc(depId)
        .collection('Analysis')
        .add({'Sent_At': _selectedDate, 'Performance': analyticPer});
    print('Date is : $_selectedDate');
  }

  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      logDate
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: logDate.text.length, affinity: TextAffinity.upstream));
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
      // print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      logstartingDate = logformattedTime;
      print(logendingDate.hour);

      logStartTime.text = DateFormat('hh:mm aa').format(logformattedTime);
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
      // print(pickedTime.minute);

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
      logEndTime.text = DateFormat('hh:mm aa').format(logformattedTime);
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

  sapstartTime(BuildContext context) async {
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
      sapstartingDate = logformattedTime;

      sapStartTime.text = DateFormat('hh:mm aa').format(logformattedTime);
      if (sapendingDate.difference(sapstartingDate).inMinutes < 0.0) {
        sapDiff = sapendingDate.difference(sapstartingDate).inMinutes + 1440;
        // sapTimeTaken.text =
        //     sapendingDate.difference(sapstartingDate).inMinutes.toString();
        print('Overall sap when negative $sapDiff');
      } else {
        sapDiff = sapendingDate.difference(sapstartingDate).inMinutes;
        // sapTimeTaken.text =
        //     sapendingDate.difference(sapstartingDate).inMinutes.toString();
        print('Overall sap when positive $sapDiff');
      }

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  Future<void> sapendTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      sapDiff = 0;
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      sapendingDate = logformattedTime;

      sapEndTime.text = DateFormat('hh:mm aa').format(logformattedTime);
      if (sapendingDate.difference(sapstartingDate).inMinutes < 0.0) {
        sapDiff = sapendingDate.difference(sapstartingDate).inMinutes + 1440;
        // sapTimeTaken.text =
        //     sapendingDate.difference(sapstartingDate).inMinutes.toString();
        print('Overall sap when negative $sapDiff');
      } else {
        sapDiff = sapendingDate.difference(sapstartingDate).inMinutes;
        // sapTimeTaken.text =
        //     sapendingDate.difference(sapstartingDate).inMinutes.toString();
        print('Overall sap when positive $sapDiff');
      }
      if (sapDiff > 180) {
        saploss = sapDiff - 180;
      }
      // print('Text Editing Controller   ${sapTimeTaken.text}');

      print(" difference is  $sapDiff");

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  late DateTime cirformattedTime;

  cirstartTime(BuildContext context) async {
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
      cirstartingDate = logformattedTime;

      cirStartTime.text = DateFormat('hh:mm aa').format(logformattedTime);

      if (cirendingDate.difference(cirstartingDate).inMinutes < 0.0) {
        cirDiff = cirendingDate.difference(cirstartingDate).inMinutes + 1440;
        print('Overall cir when negative $cirDiff');
      } else {
        cirDiff = cirendingDate.difference(cirstartingDate).inMinutes;
        print('Overall cir when positive $cirDiff');
      }

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  cirendTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      cirDiff = 0;
      print(pickedTime.format(context)); //output 10:51 PM
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime); //output 1970-01-01 22:53:00.000
      logformattedTime = parsedTime;
      print(logformattedTime); //output 14:59:00
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      cirendingDate = logformattedTime;

      cirEndTime.text = DateFormat('hh:mm aa').format(logformattedTime);
      if (cirendingDate.difference(cirstartingDate).inMinutes < 0.0) {
        cirDiff = cirendingDate.difference(cirstartingDate).inMinutes + 1440;
        print('Overall cir when negative $cirDiff');
      } else {
        cirDiff = cirendingDate.difference(cirstartingDate).inMinutes;
        print('Overall cir when positive $cirDiff');
      }

      if (cirDiff > 90) {
        cirloss = cirDiff - 90;
      }

      //  startingDate=formattedTime;
    } else {
      print("Time is not selected");
    }
  }

  String? validateLosses(value) {
    if (value == null) {
      return "Please select None if no losses";
    } else {
      return null;
    }
  }

  String? validateDate(String value) {
    if (value.length == 0) {
      return "Date can't be Empty";
    } else {
      return null;
    }
  }

  String? validateShift(String value) {
    if (value == null) {
      return "Please select any shift";
    } else {
      return null;
    }
  }

  String? validateBase(String value) {
    if (value == null) {
      return "Base can't be Empty";
    } else {
      return null;
    }
  }

  String? validateBiloNo(String value) {
    if (value.length == 0) {
      return "Please Enter Boil number";
    } else {
      return null;
    }
  }

  String? validatePanlNo(String value) {
    if (value == null) {
      return "Please Enter pan number";
    } else {
      return null;
    }
  }

  String? validateFatChange(String value) {
    if (value.length == 0) {
      return "This field can't be empty";
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

  String? validateOperator(String value) {
    if (value == null) {
      return "Operator name is required";
    } else {
      return null;
    }
  }

  String? validateSampleNo(String value) {
    if (value.length == 0) {
      return "SampleNo name is required";
    } else {
      return null;
    }
  }

  void clearfield() {
    logDate.clear();

    logBoiler.clear();

    logFatCharge.clear();
    logStartTime.clear();
    logEndTime.clear();
    logSample.clear();
    overallTime = 0;
    sapStartTime.clear();
    sapEndTime.clear();
    sapTimeLoss.clear();
    sapOtherLoss.clear();
    //sapStdTime,
    sapDiff = 0;
    cirStartTime.clear();
    cirEndTime.clear();
    cirOtherLoss.clear();
    //cirStdTime,
    cirDiff = 0;
    water1st.clear();
    water2nd.clear();
    watercir.clear();
    watercor.clear();
    costic1st.clear();
    costic2nd.clear();
    costiccir.clear();
    costiccor.clear();
    palm1st.clear();
    palm2nd.clear();
    palmcir.clear();
    palmcor.clear();
    hard1st.clear();
    hard2nd.clear();
    hardcir.clear();
    hardcor.clear();
    dfa1st.clear();
    dfa2nd.clear();
    dfacir.clear();
    dfacor.clear();
    pko1st.clear();
    pko2nd.clear();
    pkocir.clear();
    pkocor.clear();
    lab1st.clear();
    lab2nd.clear();
    labcir.clear();
    labcor.clear();
    salt1st.clear();
    salt2nd.clear();
    saltcir.clear();
    saltcor.clear();
    sv1st.clear();
    sv2nd.clear();
    svcir.clear();
    svcor.clear();
    tur1st.clear();
    tur2nd.clear();
    turcir.clear();
    turcor.clear();

    water2 = 0;
    water1 = 0;
    water3 = 0;
    water4 = 0;
    costic2 = 0;
    costic1 = 0;
    costic3 = 0;
    costic4 = 0;
    palm2 = 0;
    palm1 = 0;
    palm3 = 0;
    palm4 = 0;
    hard1 = 0;
    hard2 = 0;
    hard3 = 0;
    hard4 = 0;
    dfa2 = 0;
    dfa1 = 0;
    dfa3 = 0;
    dfa4 = 0;
    pko2 = 0;
    pko1 = 0;
    pko3 = 0;
    pko4 = 0;
    lab2 = 0;
    lab1 = 0;
    lab3 = 0;
    lab4 = 0;
    salt2 = 0;
    salt1 = 0;
    salt3 = 0;
    salt4 = 0;
    sv2 = 0;
    sv1 = 0;
    sv3 = 0;
    sv4 = 0;
    tur2 = 0;
    tur1 = 0;
    tur3 = 0;
    tur4 = 0;

    waterAll = 0;
    costicAll = 0;
    palmAll = 0;
    hardAll = 0;
    dfaAll = 0;
    pkoAll = 0;
    labAll = 0;
    saltAll = 0;
    svAll = 0;
    turAll = 0;
    fatAll = 0.0;
  }
}



//   final firestore =FirebaseFirestore.instance;
//
//   late String issueDropdown;
//
//   late DateTime _selectedDate;
//   RxString shiftValue = ''.obs;
//   RxString baseValue = ''.obs;
//   RxString panValue = ''.obs;
//   RxString selectedValue = ''.obs;
//   RxString operatorValue = ''.obs;
//
//
//   OnContinue(depid,subid,machineId)async{
//     await firestore.collection('Departments').doc(depid).collection('Sub-Department').doc(subid).collection('Machines').doc(machineId).collection('Log').add({
//       'Selected_Date': logDate.text,
//       'Log_Start_Time':logStartTime.text,
//       'Log_End_Time': logEndTime.text,
//       'Issues': issues.text,
//       'Shift': shiftValue.value
//     }).then((value) => Get.snackbar('Success', 'Saved')).catchError((e){Get.snackbar('Error', e.toString());});
//   }
//
//
//   Rxn<List<IssuesModel>> issueList = Rxn<List<IssuesModel>>();
//   List<IssuesModel>? get issue => issueList.value;
//   RxList list=[].obs;
//   getIssues(){
//     issueList.bindStream(allIssue());
//   }
//   Stream<List<IssuesModel>> allIssue() {
//     print("enter in all category stream funtion");
//     return firestore
//         .collection('ISSUES')
//         // .doc(auth.firebaseAuth.currentUser.uid)
//         // .collection('category')
//         .snapshots()
//         .map((QuerySnapshot query) {
//       List<IssuesModel> retVal = [];
//       query.docs.forEach((element) {
//         print('issues :${element['Issues']}');
//         list.value.add(element['Issues']);
//         selectedValue.value = list.value.first;
//
//         // retVal.add(IssuesModel.fromDocumentSnapshot(element));
//       });
//       print('list : $list');
//       print('category lenght is ${retVal.length}');
//       return retVal;
//     });
//   }
//
//
// }
//
//
// class IssuesModel{
//   String? id;
//   String? issueName;
//   IssuesModel({
//     required this.id,
//     required this.issueName
// });
//
//   IssuesModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc){
//     id = doc.id;
//     issueName = doc.data()!["name"];
//   }
//
// }


