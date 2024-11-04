import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mondian/calendar_widget.dart';
import 'package:mondian/naver_map.dart';
import 'package:mondian/widget/mobile_screen_ratio_widget.dart';

void main() {
  runApp(WeddingInvitationApp());
}

class WeddingInvitationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      home: MobileScreenRatioWidget(child: WeddingInvitationScreen()),
    );
  }
}

class WeddingInvitationScreen extends StatefulWidget {
  @override
  _WeddingInvitationScreenState createState() =>
      _WeddingInvitationScreenState();
}

class _WeddingInvitationScreenState extends State<WeddingInvitationScreen> {
  bool _isExpandedBride = false;
  bool _isExpandedGroom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Initial Full-Screen Image
          SliverAppBar(
            //screen size height
            expandedHeight: 800,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'images/poster_photo.jpeg', // 이미지 경로
                fit: BoxFit.cover,
              ),
            ),
            floating: true,
            snap: true,
          ),
          // 2. Greeting Message Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '저희의 소중한 순간을 함께해 주신다면 더없이 행복하고 감사한 마음으로 기억하겠습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          // 3. Map Section
          SliverToBoxAdapter(
            child: NaverMapWidget(),
          ),
          // 4. Map App Links
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMapButton('네이버 지도'),
                _buildMapButton('카카오 지도'),
                _buildMapButton('티맵'),
              ],
            ),
          ),
          // 5. Directions Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '오시는 길 설명: ...', // 실제 경로 설명 추가
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          // 6. Bank Account Information Section
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildAccountSection('신부 측 계좌', _isExpandedBride, () {
                  setState(() {
                    _isExpandedBride = !_isExpandedBride;
                  });
                }),
                _buildAccountSection('신랑 측 계좌', _isExpandedGroom, () {
                  setState(() {
                    _isExpandedGroom = !_isExpandedGroom;
                  });
                }),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InstagramCalendarWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // 버튼 동작 추가
      },
      child: Text(label),
    );
  }

  Widget _buildAccountSection(String title, bool isExpanded, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(title),
              trailing: IconButton(
                icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: onTap,
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('계좌번호: ...'), // 실제 계좌 번호 추가
              ),
          ],
        ),
      ),
    );
  }
}