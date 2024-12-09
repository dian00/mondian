import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mondian/firebase_options.dart';
import 'package:mondian/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // 5초 후 다음 페이지로 이동
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 배경 이미지
          Image.asset(
            'assets/images/IMG6.webp',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // SVG 이미지 겹치기
          Positioned(
            top: 50,
            child: SvgPicture.asset(
              'assets/images/happy_wedding_day.svg',
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
