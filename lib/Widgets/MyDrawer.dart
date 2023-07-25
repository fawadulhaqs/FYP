import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Views/Home/Dashboard.dart';
import 'package:project_fyp_impas/Widgets/DrawerController.dart';
class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final drwaerController =Get.put(MyDrawerController());
  late String companyName;
  late String companyEmail;
  late String phone;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FutureBuilder(
                future: _fetchCompanyData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container(
                      height: 230,
                      child: UserAccountsDrawerHeader(
                          accountName: Text('Company Name: Loading....'),
                          accountEmail: Text('E-mail: Loading....')),
                    );
                  } else {
                    return Container(
                      height: 230,
                      child: UserAccountsDrawerHeader(
                          accountName: Text("Company Name: $companyName"),
                          accountEmail: Text("E-mail: $companyEmail")),
                    );
                  }
                },
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  Get.offAll(Dashboard());
                },
              ),
              Divider(),
              ExpansionTile(
                title: Text('Departments'),
                children: [
                  drwaerController.DepStream()
                ],
              ),
              Divider(),
              ListTile(
                title: Text('Sign-out'),
                onTap: () {
                  drwaerController.signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _fetchCompanyData() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      await FirebaseFirestore.instance
          .collection('Companies')
          .doc(auth.currentUser!.uid)
          .get()
          .then((ds) {
        companyName = ds.data()!["name"];
        companyEmail = ds.data()!['email'];
        phone = ds.data()!['phone'];
      });
    }
  }
}
