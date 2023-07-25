


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  List<_DepData> DepData = <_DepData>[];
  List<double> performance = [];


  Future<void> getFatChargeDataFromFireStore(depId) async {
    print('this isssssss $depId');
    final snapShotsValue = await FirebaseFirestore.instance
        .collection('Departments')
        .doc(depId)
        .collection('Analysis')
        .orderBy('Sent_At', descending: true)
        .limit(60)
        .get();
    List<_DepData> list = snapShotsValue.docs
        .map((e) {

      return _DepData(
          x: DateTime.fromMillisecondsSinceEpoch(
              e.data()['Sent_At'].millisecondsSinceEpoch),
          y: e.data()['Performance']
      );
    }).toList();
    performance.add(list.map((e) => e.y).reduce((a, b) => a + b) / snapShotsValue.docs.length);
    print(performance);

  }


}

class _DepData {
  _DepData({this.x, this.y});
  final x;
  final y;
}