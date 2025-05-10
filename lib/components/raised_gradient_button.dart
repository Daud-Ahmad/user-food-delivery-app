import 'package:flutter/material.dart';

import '../../styles.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final bool isBusy;

  const RaisedGradientButton({
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 40.0,
    required this.onPressed,
    required this.isBusy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500]!,
          offset: const Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child:isBusy ? const CircularProgressIndicator(color: Colors.white,) : child,
            )),
      ),
    );
  }
}