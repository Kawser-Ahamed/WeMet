import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color color;
  final double size;
  const Loading({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color,
      size: size,
    );
  }
}