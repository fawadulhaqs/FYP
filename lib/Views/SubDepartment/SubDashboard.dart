import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:project_fyp_impas/Controller/Login_Signup/SigninController.dart';
import 'package:project_fyp_impas/Views/SubDepartment/DepAnalysis.dart';
import 'package:project_fyp_impas/Views/SubDepartment/Subdepartments.dart';
import 'package:project_fyp_impas/Widgets/MyDrawer.dart';

class SubDashboard extends StatefulWidget {
  final data;
  const SubDashboard({Key? key, this.data}) : super(key: key);

  @override
  _SubDashboardState createState() => _SubDashboardState();
}

class _SubDashboardState extends State<SubDashboard> {
  final signinController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('${widget.data['Department_Name']}'),
        centerTitle: true,
      ),
      body: PersistentTabView(
        context,
        screens: [
          DepAnalysis(depId: widget.data),
          SubDepartments(data: widget.data),
          // Settings()
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(Icons.show_chart),
            title: ("Analysis"),
            activeColorSecondary: Colors.white,
            activeColorPrimary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.white,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.square_list),
            title: ("Sub-Departments"),
            textStyle: TextStyle(fontSize: 20),
            activeColorSecondary: Colors.white,
            activeColorPrimary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.white,
          ),
        ],
        backgroundColor: Colors.brown,
      ),
    ));
  }
}
