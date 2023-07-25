import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project_fyp_impas/Widgets/MyDrawer.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? companyName;
  String? companyEmail;
  String? phone;

  Future<void> _fetchCompanyData() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      await FirebaseFirestore.instance
          .collection('Companies')
          .doc(auth.currentUser!.uid)
          .get()
          .then((ds) {
        setState(() {
          companyName = ds.data()!["name"];
          companyEmail = ds.data()!['email'];
          phone = ds.data()!['phone'];
        });
      });
    }
  }

  @override
  void initState() {
    _fetchCompanyData().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Your Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    companyName ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
              Flexible(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Company Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(companyName ?? 'Loading...',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'E-mail',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(companyEmail ?? 'Loading...',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Phone',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                phone ?? 'Loading...',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
