import 'package:flutter/material.dart';

class ButtonNetworkingIndicator extends StatelessWidget {
  final double dimension;
  final Color color;

  const ButtonNetworkingIndicator({
    required this.dimension,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
      child: CircularProgressIndicator(strokeWidth: 4, valueColor: AlwaysStoppedAnimation(color)),
    );
  }
}
