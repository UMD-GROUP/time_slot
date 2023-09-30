import 'dart:io';

import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => Platform.isIOS
      ? const CircularProgressIndicator.adaptive()
      : CircularProgressIndicator(
          color: color,
        );
}
