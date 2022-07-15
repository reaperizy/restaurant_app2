import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder androidbuilder;
  final WidgetBuilder iosbuilder;

  PlatformWidget({required this.androidbuilder, required this.iosbuilder});

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidbuilder(context);
      case TargetPlatform.iOS:
        return iosbuilder(context);
      default:
        return androidbuilder(context);
    }
  }
}
