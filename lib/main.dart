import 'package:flutter/material.dart';
import 'package:tutorial/cell_content.dart';
import 'package:tutorial/folding_cell_list_page.dart';

import 'folding_demo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: FoldingDemoPage(),
      home: FoldingCellListPage(),
    );
  }
}



