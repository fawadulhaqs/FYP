import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardModel{
  String? id;
  String? name;
  String? head;
  String? type;

  DashboardModel({
    this.id,
    this.name,
    this.head,
    this.type
  });

  DashboardModel.fromDocumentSnapShot(DocumentSnapshot<Map<String,dynamic>> snapshot){
    id = snapshot.id;
    name= snapshot.data()!['Department_Name'] ?? "";
    head= snapshot.data()!['Head_of_Department'] ?? "";
    type= snapshot.data()!['Department_Type'] ?? "";
  }
}