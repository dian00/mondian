import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html';

class NaverMapWidget extends StatefulWidget {
  const NaverMapWidget({super.key});

  @override
  State<NaverMapWidget> createState() => _NaverMapWidgetState();
}

class _NaverMapWidgetState extends State<NaverMapWidget> {
  bool _iframeActive = false;

  @override
  void initState() {
    super.initState();

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'naver-map',
      (int viewId) {
        final iframe = IFrameElement()
          ..style.width = '100%'
          ..style.height = '100%'
          ..src = '/map.html'
          ..style.border = 'none'
          ..style.pointerEvents = 'none'; // 초기에는 이벤트 비활성화

        iframe.onClick.listen((event) {
          setState(() {
            _iframeActive = !_iframeActive;
          });
          // 이벤트를 다시 활성화 또는 비활성화
          iframe.style.pointerEvents = _iframeActive ? 'auto' : 'none';
        });

        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _iframeActive = !_iframeActive;
        });
      },
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: HtmlElementView(viewType: 'naver-map'),
      ),
    );
  }
}
