import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:project_fyp_impas/Controller/Login_Signup/SigninController.dart';
import 'package:project_fyp_impas/Views/Home/Settings.dart';

import '../../Widgets/DrawerController.dart';
import 'Department.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final signinController = Get.put(SignInController());
  final drwaerController =Get.put(MyDrawerController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: PersistentTabView(
            context,
            screens: [
              Department(),
              Settings()
            ],
            items: [
              PersistentBottomNavBarItem(
                icon: Icon(Icons.home),
                title: ("HOME"),
                activeColorSecondary: Colors.white,
                activeColorPrimary: CupertinoColors.white,
                inactiveColorPrimary: CupertinoColors.white,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                title: ("Profile"),
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
