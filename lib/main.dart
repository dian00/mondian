import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mondian/calendar_widget.dart';
import 'package:mondian/naver_map.dart';
import 'dart:html' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const WelcomeWidget(),
            CalendarWidget(dDay: DateTime.utc(2025, 2, 8)),
            const SizedBox(height: 20),
            const CongratulationGift(),
            const MapWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Image.asset(
            'assets/images/main_photo.jpeg',
            fit: BoxFit.fitHeight,
            width: double.infinity,
          ),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "MOONSHIK", style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "EUN-AE", style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.75,
        //   padding: EdgeInsets.only(top: 100),
        //   child: Center(
        //     child: Image.asset(
        //       'assets/images/happily-ever-after.png',
        //       fit: BoxFit.fitHeight,
        //       width: double.infinity,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("오시는 길"),
        Text("더링크호텔 서울 3F 플라자홀"),
        Text("서울 구로구 경인로 610 (신도림동 413-9)"),
        NaverMapWidget(),
      ],
    );
  }
}


class InvitationWidget extends StatelessWidget {
  const InvitationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CongratulationGift extends StatelessWidget {
  const CongratulationGift({super.key});

  void onPressed(BuildContext context, String accountNumber) {
    Clipboard.setData(new ClipboardData(text: accountNumber)).then((value) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("계좌번호가 복사되었습니다"))));
  }

  void onPayPressed(BuildContext context, String receiver) {
    // PC 여부 확인 할건지
    if( receiver.contains('신랑') ) {

    } else if( receiver.contains('신부') ) {
      html.window.open('https://qr.kakaopay.com/Ej7uy8Oad', 'new tab');
    }
  }

  Widget _buildButton(BuildContext context, String receiver, accountNumber) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            receiver,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(width: 20),
          TextButton(
              onPressed: () => onPressed(context, accountNumber),
              child: Text(
                accountNumber,
                maxLines: 2,
              )),
          IconButton(icon: const Icon(Icons.copy), onPressed: () => onPressed(context, accountNumber)),
          IconButton(icon: const Icon(Icons.payment), onPressed: () => onPayPressed(context, receiver)),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.all(20.0),
        child: Column(
          children: [
            Text('신랑 신부에게 마음 전하기',
                style: TextStyle(
                    // color: const Color.fromRGBO(41, 82, 56, 100),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(height: 50),
            _buildButton(context, '신랑 최문식', '카카오뱅크 3333-04-6486265'),
            SizedBox(height: 20),
            _buildButton(context, '신부 홍은애', '카카오뱅크 3333-08-2397114'),
          ],
        ));
  }
}


