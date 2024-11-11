import 'package:flutter/material.dart';
import '../utils/screen_util.dart';
import '../values/assets.dart';

Widget buildLoading() {
  return const LoadingWidget();
  // return const Center(child: CircularProgressIndicator());
}

extension WidgetShowLoading on Widget {
  Widget showLoading(bool loading) {
    return Stack(children: [this, loading ? buildLoading() : Container()]);
  }
}

class LoadingWidget extends StatefulWidget {

  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  // ignore: must_call_super
  void initState() {
    _controller = (_controller ??
        AnimationController(vsync: this, duration: Duration(milliseconds: 800)))
      ..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: RotationTransition(
          //设置动画的旋转中心
          alignment: Alignment.center,
          //动画控制器
          turns: _controller!,
          //将要执行动画的子view
          child: Image.asset(
            AssetsImages.iconLoading(),
            width: 45.w,
            height: 45.w,
          ),
        ),
      ),
    );
  }
}