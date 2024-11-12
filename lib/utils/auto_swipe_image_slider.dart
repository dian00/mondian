import 'dart:async';
import 'package:flutter/material.dart';

class AutoSwipeImageSlider extends StatefulWidget {
  @override
  _AutoSwipeImageSliderState createState() => _AutoSwipeImageSliderState();
}

class _AutoSwipeImageSliderState extends State<AutoSwipeImageSlider> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSwipe() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 19) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 19, // img1부터 img20까지 총 20개의 이미지
        itemBuilder: (context, index) {
          return Image.asset(
            'assets/images/IMG${19 - index}.webp',
            fit: BoxFit.cover,
            width: double.infinity,
          );
        },
      ),
    );
  }
}
