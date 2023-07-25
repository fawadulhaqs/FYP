import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/HomeController.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController= Get.put(HomeController());
  List<_DepData> DepData = <_DepData>[];
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  double averageTime=0.0;
  List<int> docId = [];
  List<double> performance = [];




  // @override
  // void initState(depId) {
  //   getFatChargeDataFromFireStore(depId).then((results) {
  //     SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
  //       setState(() {});
  //     });
  //   });
  //   super.initState();
  //   print('initState called');
  // }


  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _getDepartment= firestore
        .collection('Departments')
        .orderBy('Department_Name')
        .where('Company_Id', isEqualTo: auth.currentUser!.uid)
        .snapshots();
    // Future<int> length= _getDepartment.then((value) => value.docs.length);


    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: _getDepartment,
                builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: 3,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8,10,0,10),
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  // color: Colors.blue,
                                  child: Container(
                                    child: Center(child: Text('No Data Found', style: TextStyle(color: Colors.brown, fontSize: 20.0),)),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  }

                    return Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            final data= snapshot.data!.docs[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8,10,0,10),
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  // color: Colors.blue,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        TextButton(onPressed: (){
                                          homeController.getFatChargeDataFromFireStore(data.id);
                                          setState(() {

                                          });
                                        }, child: Text('refrsh')),
                                        Text(data['Department_Name'], style: TextStyle(color: Colors.brown, fontSize: 20.0),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    );
                }
            ),
            StreamBuilder(
                stream: _getDepartment,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Container(
                    // height: MediaQuery.of(context).size.height/1.65,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          homeController.getFatChargeDataFromFireStore(data.id);
                          return Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(onPressed: (){
                                        homeController.getFatChargeDataFromFireStore(data.id);
                                      }, child: Text('refrsh')),
                                      Text(data['Department_Name']),
                                      Text('${homeController.performance[index]}')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}



class _DepData {
  _DepData({this.x, this.y});
  final x;
  final y;
}