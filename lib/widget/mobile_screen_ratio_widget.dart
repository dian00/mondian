import 'package:flutter/widgets.dart';

class MobileScreenRatioWidget extends StatelessWidget {
  final Widget child;
  MobileScreenRatioWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {

        return SizedBox(
          width: 600,// constraint.maxWidth,
          height: constraint.maxHeight,
          child: child,
        );
      }
    );
  }
}
