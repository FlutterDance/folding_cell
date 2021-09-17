import 'package:flutter/material.dart';
import 'package:tutorial/folding_cell.dart';

class FoldingDemoPage extends StatefulWidget {
  const FoldingDemoPage({Key? key}) : super(key: key);

  @override
  _FoldingDemoPageState createState() => _FoldingDemoPageState();
}

class _FoldingDemoPageState extends State<FoldingDemoPage>
    with SingleTickerProviderStateMixin {
  /// 动画控制器
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000), /// 调试期间可以先把动画时间调慢，方便观察
    );
  }

  @override
  void dispose() {
    /// 释放动画控制器
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 点击做展开或关闭动画
        if (_controller.value == 1) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            color: Colors.black12,
            padding: EdgeInsets.only(top: 44, left: 20, right: 20),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            centerText('1', Colors.red),
                            FoldingComponent(
                                backChild: Container(
                                  color: Colors.teal,
                                  child: FlutterLogo(),
                                ),
                                animation: generateAnimation(
                                  beginAngle: 90.0,
                                  endAngle: 0.0,
                                  intervalBegin: 0.6,
                                  intervalEnd: 1.0,
                                ))

                            /// 最后的动画，写在最前面
                          ],
                        ),
                      ),
                      Expanded(
                        child: FoldingComponent(
                          frontChild: centerText('2', Colors.green),
                          animation: generateAnimation(
                            beginAngle: 0.0,
                            endAngle: 90.0,
                            intervalBegin: 0.3,
                            intervalEnd: 0.6,
                          ),
                        ),
                      ),
                      Expanded(child: FoldingComponent(
                        frontChild: centerText('3', Colors.lightBlue),
                        animation: generateAnimation(
                          beginAngle: 0.0,
                          endAngle: 180.0,
                          intervalBegin: 0.0,
                          intervalEnd: 0.3,
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Animation<double> generateAnimation({
    beginAngle: double,

    /// 旋转的开始角度
    endAngle: double,

    /// 旋转结束角度
    intervalBegin: double,

    /// 该段动画起点
    intervalEnd: double,

    /// 该段动画结束点
  }) {
    return Tween<double>(begin: beginAngle, end: endAngle).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(intervalBegin, intervalEnd),
      ),
    );
  }

  Widget centerText(String text, Color backgroundColor) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
    );
  }
}
