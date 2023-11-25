import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  const LoadingWidget({super.key, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    const Color color = Colors.lightBlueAccent;
    return Center(
      child: isImage ? const SpinKitRipple(color: color) : const SpinKitWave(color: color),
    );
  }
}
