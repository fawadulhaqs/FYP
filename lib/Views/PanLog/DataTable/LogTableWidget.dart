import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_fyp_impas/Controller/Logs/LogController.dart';
import 'package:project_fyp_impas/Models/PanLogModel.dart';

import 'ScrolableWidget.dart';

class LogTableWidget extends StatefulWidget {
  final data;
  final CollectiveModel model;
  const LogTableWidget({Key? key, this.data, required this.model}) : super(key: key);

  @override
  _LogTableWidgetState createState() => _LogTableWidgetState();
}

class _LogTableWidgetState extends State<LogTableWidget> {
  final collectiveController = Get.put(LogController());
  @override
  Widget build(BuildContext context) {
    return ScrolableWidget(child: buildDataTable());
  }

  Widget buildDataTable() {
    final columns = [
      'Delay',
      'Date',
      'Shift',
      'Base',
      'Boiler',
      'Operator',
      'Sample',
      'Saponification Losses',
      'Sap Loss Time',
      'Circulation Losses',
      'Circulation Loss Time',
      'OverAll Time'
    ];

    return DataTable(
      columns: getColumns(
        columns,
      ),
      rows: getRows(collectiveController.log!),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(
          column,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<CollectiveModel> log) =>
      log.map((CollectiveModel user) {

        String indicator;


        if (user.overall! <= 330) {
          indicator = 'No Delay';
          collectiveController.noDelay++;
        } else {
          indicator = 'Delayed ${user.overall! - 330} min';
          collectiveController.delay++;
        }
        print(' NO DELAY ${collectiveController.noDelay}');
        print(' DELAY ${collectiveController.delay}');
        collectiveController.per =
        ((collectiveController.noDelay / collectiveController.totalLength) *
            100.0);
        print('percentage ${collectiveController.per}');
        DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
            user.date!.microsecondsSinceEpoch);
        var formatedDate = DateFormat.yMMMd().format(dt);
        final cells = [
          indicator,
          formatedDate,
          user.shift,
          user.base,
          user.boilNo,
          user.operator,
          user.sampleNo,
          user.downTimeLossSoap,
          '${user.saptimeLoss} min',
          user.downTimeLossCir,
          '${user.cirtimeLoss} min',
          '${user.overall} min/330 min',
        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(
              Text(
                '$cell ',
                style: TextStyle(fontSize: 16,color: Colors.black),
              ), onTap: () {
              // Get.snackbar('Tap', 'You tapped on $cell $cells');
            },
            );

          }),
        );
      }
      ).toList();

}

class Utils {
  static List<T> modelBuilder<M, T>(
      List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}