import 'package:cloud_firestore/cloud_firestore.dart';

class CollectiveModel {
  String? id;
  Timestamp? sentAt;
  Timestamp? date;
  String? shift;
  String? base;
  String? boilNo;
  String? panlNo;
  double? fatChange;
  String? startTime;
  String? endTime;
  String? operator;
  String? sampleNo;
  int? overall;
  String? startTimeSoap;
  String? endTimeSoap;
  int? saptimeLoss;
  String? stdTimeSoap;
  int? actTimeSoap;
  String? downTimeLossSoap;
  String? downTimeOtherLossSoap;
  String? startTimeCir;
  String? endTimeCir;
  int? cirtimeLoss;
  String? stdTimeCir;
  int? actTimeCir;
  String? downTimeLossCir;
  String? downTimeOtherLossCir;
  int? water1st;
  int? water2nd;
  int? watercir;
  int? watercor;
  int? waterAll;
  int? costic1st;
  int? costic2nd;
  int? costiccir;
  int? costiccor;
  int? costicAll;
  int? palm1st;
  int? palm2nd;
  int? palmcir;
  int? palmcor;
  int? palmAll;
  int? hard1st;
  int? hard2nd;
  int? hardcir;
  int? hardcor;
  int? hardAll;
  int? dfa1st;
  int? dfa2nd;
  int? dfacir;
  int? dfacor;
  int? dfaAll;
  int? pko1st;
  int? pko2nd;
  int? pkocir;
  int? pkocor;
  int? pkoAll;
  int? lab1st;
  int? lab2nd;
  int? labcir;
  int? labcor;
  int? labAll;
  int? salt1st;
  int? salt2nd;
  int? saltcir;
  int? saltcor;
  int? saltAll;
  int? sv1st;
  int? sv2nd;
  int? svcir;
  int? svcor;
  int? svAll;
  int? tur1st;
  int? tur2nd;
  int? turcir;
  int? turcor;
  int? turAll;

  CollectiveModel({
    this.id,
    this.date,
    this.shift,
    this.base,
    this.endTime,
    this.startTime,
    this.boilNo,
    this.fatChange,
    this.operator,
    this.panlNo,
    this.sampleNo,
    this.overall,
    this.sentAt,
    this.actTimeSoap,
    this.downTimeLossSoap,
    this.downTimeOtherLossSoap,
    this.endTimeSoap,
    this.startTimeSoap,
    this.saptimeLoss,
    this.stdTimeSoap,
    this.actTimeCir,
    this.downTimeLossCir,
    this.downTimeOtherLossCir,
    this.endTimeCir,
    this.startTimeCir,
    this.cirtimeLoss,
    this.stdTimeCir,
    this.water1st,
    this.water2nd,
    this.watercir,
    this.watercor,
    this.waterAll,
    this.costic1st,
    this.costic2nd,
    this.costiccir,
    this.costiccor,
    this.costicAll,
    this.palm1st,
    this.palm2nd,
    this.palmcir,
    this.palmcor,
    this.palmAll,
    this.hard1st,
    this.hard2nd,
    this.hardcir,
    this.hardcor,
    this.hardAll,
    this.dfa1st,
    this.dfa2nd,
    this.dfacir,
    this.dfacor,
    this.dfaAll,
    this.pko1st,
    this.pko2nd,
    this.pkocir,
    this.pkocor,
    this.pkoAll,
    this.lab1st,
    this.lab2nd,
    this.labcir,
    this.labcor,
    this.labAll,
    this.salt1st,
    this.salt2nd,
    this.saltcir,
    this.saltcor,
    this.saltAll,
    this.sv1st,
    this.sv2nd,
    this.svcir,
    this.svcor,
    this.svAll,
    this.tur1st,
    this.tur2nd,
    this.turcir,
    this.turcor,
    this.turAll,
  });

  CollectiveModel.fromDocumentSnapShot(DocumentSnapshot<Map<String,dynamic>> snapshot) {
    id = snapshot.id;
    sentAt = Timestamp.now();

    date = snapshot.data()!['LogDate'] ?? "";

    shift = snapshot.data()!['LogShift'] ?? "";
    base = snapshot.data()!['LogBase'] ?? "";
    endTime = snapshot.data()!['LogEndTime'] ?? "";
    startTime = snapshot.data()!['LogStartTime'] ?? "";
    boilNo = snapshot.data()!['LogBoilNo'] ?? "";
    fatChange = snapshot.data()!['LogFatChange'] ?? "";
    operator = snapshot.data()!['LogOperator'] ?? "";
    panlNo = snapshot.data()!['LogPanNo'] ?? "";
    sampleNo = snapshot.data()!['LogsampleNo'] ?? "";
    overall = snapshot.data()!['OverAllTime'] ?? 0;
    startTimeSoap = snapshot.data()!['SapStartTime'] ?? "";
    endTimeSoap = snapshot.data()!['SapEndTime'] ?? "";
    saptimeLoss = snapshot.data()!['SapTimeLoss'] ?? 0;
    stdTimeSoap = snapshot.data()!['SapStdTime'] ?? "";
    actTimeSoap = snapshot.data()!['SapActTime'] ?? 0;
    downTimeLossSoap = snapshot.data()!['SapLosses'] ?? "";
    downTimeOtherLossSoap = snapshot.data()!['SapOtherLosses'] ?? "";
    startTimeCir = snapshot.data()!['CirStartTime'] ?? "";
    endTimeCir = snapshot.data()!['CirEndTime'] ?? "";
    cirtimeLoss = snapshot.data()!['CirTimeLoss'] ?? 0;
    stdTimeCir = snapshot.data()!['CirStdTime'] ?? "";
    actTimeCir = snapshot.data()!['CirActTIme'] ?? 0;
    downTimeLossCir = snapshot.data()!['CirLosses'] ?? "";
    downTimeOtherLossCir = snapshot.data()!['CirOtherLosses'] ?? "";
    water1st = snapshot.data()!['Water_1st'] ?? 0;
    water2nd = snapshot.data()!['Water_2nd'] ?? 0;
    watercir = snapshot.data()!['Water_Cir'] ?? 0;
    watercor = snapshot.data()!['Water_Cor'] ?? 0;
    waterAll = snapshot.data()!['Water_All'] ?? 0;
    costic1st = snapshot.data()!['Caustic_1st'] ?? 0;
    costic2nd = snapshot.data()!['Caustic_2nd'] ?? 0;
    costiccir = snapshot.data()!['Caustic_Cir'] ?? 0;
    costiccor = snapshot.data()!['Caustic_Cor'] ?? 0;
    costicAll = snapshot.data()!['Caustic_All'] ?? 0;
    palm1st = snapshot.data()!['Palm_Oil_1st'] ?? 0;
    palm2nd = snapshot.data()!['Palm_Oil_2nd'] ?? 0;
    palmcir = snapshot.data()!['Palm_Oil_Cir'] ?? 0;
    palmcor = snapshot.data()!['Palm_Oil_Cor'] ?? 0;
    palmAll = snapshot.data()!['Palm_Oil_All'] ?? 0;
    hard1st = snapshot.data()!['Hard_ST_1st'] ?? 0;
    hard2nd = snapshot.data()!['Hard_ST_2nd'] ?? 0;
    hardcir = snapshot.data()!['Hard_ST_Cir'] ?? 0;
    hardcor = snapshot.data()!['Hard_ST_Cor'] ?? 0;
    hardAll = snapshot.data()!['Hard_ST_All'] ?? 0;
    dfa1st = snapshot.data()!['Lauric_DFA_1st'] ?? 0;
    dfa2nd = snapshot.data()!['Lauric_DFA_2nd'] ?? 0;
    dfacir = snapshot.data()!['Lauric_DFA_Cir'] ?? 0;
    dfacor = snapshot.data()!['Lauric_DFA_Cor'] ?? 0;
    dfaAll = snapshot.data()!['Lauric_DFA_All'] ?? 0;
    pko1st = snapshot.data()!['PKO_1st'] ?? 0;
    pko2nd = snapshot.data()!['PKO_2nd'] ?? 0;
    pkocir = snapshot.data()!['PKO_Cir'] ?? 0;
    pkocor = snapshot.data()!['PKO_Cor'] ?? 0;
    pkoAll = snapshot.data()!['PKO_All'] ?? 0;
    lab1st = snapshot.data()!['Labsa_1st'] ?? 0;
    lab2nd = snapshot.data()!['Labsa_2nd'] ?? 0;
    labcir = snapshot.data()!['Labsa_Cir'] ?? 0;
    labcor = snapshot.data()!['Labsa_Cor'] ?? 0;
    labAll = snapshot.data()!['Labsa_All'] ?? 0;
    salt1st = snapshot.data()!['Salt_1st'] ?? 0;
    salt2nd = snapshot.data()!['Salt_2nd'] ?? 0;
    saltcir = snapshot.data()!['Salt_Cir'] ?? 0;
    saltcor = snapshot.data()!['Salt_Cor'] ?? 0;
    saltAll = snapshot.data()!['Salt_All'] ?? 0;
    sv1st = snapshot.data()!['Sodium_Versence_1st'] ?? 0;
    sv2nd = snapshot.data()!['Sodium_Versence_2nd'] ?? 0;
    svcir = snapshot.data()!['Sodium_Versence_Cir'] ?? 0;
    svcor = snapshot.data()!['Sodium_Versence_Cor'] ?? 0;
    svAll = snapshot.data()!['Sodium_Versence_All'] ?? 0;
    tur1st = snapshot.data()!['Turpinol_1st'] ?? 0;
    tur2nd = snapshot.data()!['Turpinol_2nd'] ?? 0;
    turcir = snapshot.data()!['Turpinol_Cir'] ?? 0;
    turcor = snapshot.data()!['Turpinol_Cor'] ?? 0;
    turAll = snapshot.data()!['Turpinol_All'] ?? 0;
  }
}
