import 'package:flutter/material.dart';
import 'package:tutorial/folding_cell.dart';

class FoldingCellListPage extends StatefulWidget {
  const FoldingCellListPage({Key? key}) : super(key: key);

  @override
  _FoldingCellListPageState createState() => _FoldingCellListPageState();
}

class _FoldingCellListPageState extends State<FoldingCellListPage> {
  /// 记录哪些索引是打开了的
  /// 这里用 Set 是因为我们并不关心它们打开的顺序
  late Set<int> openedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return FoldingCell(
                  key: ValueKey(index),
                  foldingState: openedIndices.contains(index) ? FoldingState
                      .open : FoldingState.close,
                  onChanged: (foldState) {
                    if (foldState == FoldingState.open) {
                      print('打开了 cell -- $index');
                      openedIndices.add(index);
                    } else {
                      print('关闭了 cell -- $index');
                      openedIndices.remove(index);
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
