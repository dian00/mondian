import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html';

class NaverMapWidget extends StatefulWidget {
  const NaverMapWidget({super.key});

  @override
  State<NaverMapWidget> createState() => _NaverMapWidgetState();
}

class _NaverMapWidgetState extends State<NaverMapWidget> {

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'naver-map',
          (int viewId) => IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = 'assets/html/map.html'
        ..style.border = 'none',
    );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        width: double.infinity,
        // 등록된 IFrameElement Widget들 중
        //'naver-map'라는 이름을 가진 개체를 Widget으로 임베딩
        child: const HtmlElementView(viewType: 'naver-map'));
  }
}
