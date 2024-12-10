import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mondian/calendar_widget.dart';
import 'package:mondian/naver_map.dart';
import 'package:mondian/provider/kakao_share.dart';
import 'package:mondian/utils/url_constant.dart';
import 'package:mondian/widget/custom_widget.dart';
import 'package:mondian/widget/gestbook_screen.dart';
import 'package:mondian/widget/gestbook_widget.dart';
import 'package:mondian/widget/horizontal_image_slider.dart';
import 'package:mondian/widget/instagram_widget.dart';
import 'package:mondian/widget/mobile_screen_ratio_widget.dart';
import 'package:mondian/widget/wedding_invitation.dart';
import 'dart:html' as html;

import 'package:mondian/utils/auto_swipe_image_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatelessWidget {

  const Homepage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '문식\u2665은애 우리 결혼해요',
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
      home: const MyHomePage(title: '문식\u2665은애 우리 결혼해요'),
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
  final ScrollController _scrollController = ScrollController();
  bool _showTooltip = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // 스크롤이 80% 이상인 경우
    if (currentScroll > maxScroll * 0.8 && !_showTooltip) {
      print("Show Tooltip");
      setState(() {
        _showTooltip = true;
      });
    } else if (currentScroll <= maxScroll * 0.8 && _showTooltip) {
      print("hide Tooltip");
      setState(() {
        _showTooltip = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: MobileScreenRatioWidget(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InstagramWidget(
                  username: "문식\u2665은애",
                  content: AutoSwipeImageSlider(),
                  descriptionText:'서로의 코드를 이해하고, \n인생의 코드를 함께 짜기 시작한 두 사람이 \n마침내 결혼이라는 큰 프로젝트를 시작하려 합니다.\n\n2025년 2월 8일, \n저희의 소중한 순간을 함께해 주신다면 \n더없이 행복하고 감사한 마음으로 기억하겠습니다.'
                ),
                SizedBox(height: 20),
                InstagramWidget(
                    username: "D-day",
                    content: Container(
                      color: Colors.pink[50],
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: Center(child: DateDifferenceCardWidget(targetDate: DateTime.utc(2025, 2, 8))),
                    ),
                    descriptionText:'우리의 소중한 날까지 ${DateTime.utc(2025, 2, 8).difference(DateTime.now()).inDays + 1}일 남았습니다 :)'
                ),
                SizedBox(height: 20),
                // DateDifferenceCardWidget(targetDate: DateTime.utc(2025, 2, 8)),//dDay: DateTime.utc(2025, 2, 8)),
                // InstagramCalendarWidget(),
                const SizedBox(height: 20),
                InstagramWidget(username: "gift", content: Container( color: Colors.pink[50], width: double.infinity, child: CongratulationGift()), descriptionText: '마음 전하실 곳 \n 따듯한 마음 감사드립니다.'),
                // const CongratulationGift(),
                SizedBox(height: 30),
                InstagramWidget(username: "map", content: MapWidget(), descriptionText: '오시는 길 안내 \n 더링크 호텔 서울 플라자홀 (4F)\n 서울 구로구 경인로 610 (신도림동 413-9)'),
                const SizedBox(height: 30,),
                const SizedBox(height: 30,),
                InstagramWidget(
                  username: "photo",
                  content: HorizontalImageSlider(
                    children: List.generate(
                      20,
                          (index) => Image.asset(
                        'assets/images/IMG${index + 1}.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  descriptionText: "웨딩 사진 모음",
                ),
                InstagramWidget(username: "photo", content: HorizontalImageSlider(children: [
                  Image.asset('assets/images/main_photo.jpeg', fit: BoxFit.cover),
                  Image.asset('assets/images/main_photo.jpeg', fit: BoxFit.cover),
                  Image.asset('assets/images/main_photo.jpeg', fit: BoxFit.cover),
                  Image.asset('assets/images/main_photo.jpeg', fit: BoxFit.cover),
                ],
                ), descriptionText: "웨딩 사진"),
                GuestbookScreen(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () async {
                        await KakaoShare.shareInvitation();
                      },
                      child: Text(
                        "카카오톡으로 공유하기",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 툴팁 영역
          AnimatedOpacity(
            opacity: _showTooltip ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "따듯한 마음 남기기",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FloatingActionButton(
              onPressed: () {
                CustomWidget().showFloatingModal(context, Column(
                  children: [
                    InkWell(onTap: () {}, child: Text("방명록 작성하기")),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Divider(),
                    ),
                    InkWell(onTap: () {}, child: Text("참석의사 전달하기")),
                  ],
                ));
              },
              child: Icon(Icons.schedule_send),
            ),
          ),
        ],
      ),
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
              "MOON-SHIK", style: TextStyle(color: Colors.white),
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

enum Maps { naver, kakao, tmap }
class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NaverMapWidget(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Maps.values.map( (e) => getMapSchemeButton(e)).toList())
      ],
    );
  }

  Future<void> launchPlatformSchemeUrl({
    // required String androidUrl,
    // required String iOSUrl,
    required String webUrl,
  }) async {
    String url = webUrl;
    // defaultTargetPlatform == TargetPlatform.android
    //     ? androidUrl
    //     : defaultTargetPlatform == TargetPlatform.iOS
    //     ? iOSUrl
    //     : webUrl;

    final parseUrl = Uri.parse(url);
    if (await canLaunchUrl(parseUrl)) {
      launchUrl(parseUrl);
    } else {
      html.window.open(webUrl, "callback");
    }
  }

  Widget getMapSchemeButton(Maps map) {
    return InkWell(
      onTap: () async {
        if( map == Maps.naver ) {
          launchPlatformSchemeUrl(
            // androidUrl: UrlConstant.naverAndroidScheme,
            // iOSUrl: UrlConstant.naveriOSScheme,
              webUrl: UrlConstant.naverWebUrl);
        } else if (map == Maps.kakao) {
          launchPlatformSchemeUrl(
            // androidUrl: UrlConstant.naverAndroidScheme,
            // iOSUrl: UrlConstant.naveriOSScheme,
              webUrl: UrlConstant.kakaoUrl);
        } else if (map == Maps.tmap) {
          launchPlatformSchemeUrl(webUrl: UrlConstant.tmapUrl);
        }

      },
      child: Row(
        children: [
          Icon(Icons.map),
          Text(map == Maps.naver ? "네이버지도" : map == Maps.kakao ? "카카오지도" : "T티맵")
        ],
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            receiver,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(width: 5),
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
        color: Colors.pink[50],
        margin: EdgeInsetsDirectional.all(20.0),
        child: Column(
          children: [
            Text('마음 전하실 곳',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
            SizedBox(height: 5),
            Text('신랑 측'),
            _buildButton(context, '신랑 최문식', '카카오뱅크 3333-01-0931666'),
            SizedBox(height: 10),
            Text('신부 측'),
            _buildButton(context, '신부 홍은애', '카카오뱅크 3333-25-0188258'),
          ],
        ));
  }
}


