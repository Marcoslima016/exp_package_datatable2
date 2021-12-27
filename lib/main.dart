import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: DataTable2SimpleDemo(),
      home: Report(), 
    );
  }
}

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  const DataTable2SimpleDemo();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text('Column A'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Column B'),
            ),
            DataColumn(
              label: Text('Column C'),
            ),
            DataColumn(
              label: Text('Column D'),
            ),
            DataColumn(
              label: Text('Column NUMBERS'),
              numeric: true,
            ),
          ],
          rows: List<DataRow>.generate(
            100,
            (index) => DataRow(
              cells: [
                DataCell(Text('A' * (10 - index % 10))),
                DataCell(Text('B' * (10 - (index + 5) % 10))),
                DataCell(Text('C' * (15 - (index + 5) % 10))),
                DataCell(Text('D' * (15 - (index + 10) % 10))),
                DataCell(Text(((index + 0.1) * 25.4).toString())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReportColumns {
  //
}

class ReportValue {
  List<Widget> values;
  ReportValue();
}

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class ReportController {
  //
}

class Report extends StatelessWidget {
  List<DataColumn> columns = [];
  List<List> values = [];
  // List reportCells = [];

  // List<DataColumn> _columns = [];

  List<DataRow> reportRows = [];

  Report({
    @required this.columns, 
    @required this.values,
  })

  Future mountReport() async {
    for (var itemValue in values) {
      DataRow row = DataRow(cells: []);
      for (var itemCell in itemValue) {
        row.cells.add(DataCell(itemCell));
      }
      reportRows.add(row);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mountReport(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Material(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: columns,
                rows: reportRows,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
