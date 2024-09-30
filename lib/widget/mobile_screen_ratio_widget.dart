import 'package:flutter/widgets.dart';

class MobileScreenRatioWidget extends StatelessWidget {
  final Widget child;
  Color? backgroundColor;
  MobileScreenRatioWidget({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          child: child,
        ),
      ),
    );
  }
}
