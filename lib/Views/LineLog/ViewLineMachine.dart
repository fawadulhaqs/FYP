import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'LineAnalysis.dart';
import 'LineLog.dart';
import 'LineLogList.dart';

class ViewLineMachine extends StatefulWidget {
  final depid;
  final subid;
  final machinedata;
  const ViewLineMachine({Key? key, this.depid, this.subid, this.machinedata})
      : super(key: key);

  @override
  State<ViewLineMachine> createState() => _ViewLineMachineState();
}

class _ViewLineMachineState extends State<ViewLineMachine> {
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
          LineAnalysis(
              depId: widget.depid,
              subId: widget.subid,
              machineId: widget.machinedata.id),
          LinrLog(
              depid: widget.depid,
              subid: widget.subid,
              machine: widget.machinedata),
          LineLogList(
            depId: widget.depid,
            subId: widget.subid,
            machineId: widget.machinedata.id,
          )
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
        ],
        backgroundColor: Colors.brown,
      ),
    ));
  }
}
