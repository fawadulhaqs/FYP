import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:project_fyp_impas/Views/PanLog/Log.dart';
import 'package:project_fyp_impas/Views/PanLog/DataList/LogList.dart';

import 'Analysis.dart';
import 'DataTable/LogTable.dart';

class VIewMachine extends StatefulWidget {
  final depid;
  final subid;
  final machinedata;
  const VIewMachine({Key? key, this.depid, this.subid, this.machinedata})
      : super(key: key);

  @override
  _VIewMachineState createState() => _VIewMachineState();
}

class _VIewMachineState extends State<VIewMachine> {
  // final logController = Get.put(LogController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(widget.machinedata['Machine_Name']),
        centerTitle: true,
      ),
      body: PersistentTabView(
        context,
        screens: [
          Analysis(
              depId: widget.depid,
              subId: widget.subid,
              machineId: widget.machinedata.id),
          Log(
              depid: widget.depid,
              subid: widget.subid,
              machine: widget.machinedata),
          LogList(
            depId: widget.depid,
            subId: widget.subid,
            machineId: widget.machinedata.id,
          ),
          LogTable(depId: widget.depid,
            subId: widget.subid,
            machineId: widget.machinedata.id,)
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.chart_bar_circle),
            title: ("Analysis"),
            activeColorSecondary: Colors.white,
            activeColorPrimary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.white,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            title: ("Create Log"),
            activeColorSecondary: Colors.white,
            activeColorPrimary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.white,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            title: ("Records"),
            activeColorSecondary: Colors.white,
            activeColorPrimary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.white,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.table),
            title: ("Table Records"),
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
