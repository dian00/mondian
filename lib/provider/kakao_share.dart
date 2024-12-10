import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

class KakaoShare {
  static FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: '문식\u2665은애 결혼합니다',
      description: '2월 8일 오후 5:40\n'
          '더링크 호텔 4층 플라자홀\n',
      imageUrl: Uri.parse(
        'https://drive.google.com/uc?export=view&id=1OiF0eNpCDhZZxX1paQM3-YMXi3KzvNb3'),
      link: Link(
          webUrl: Uri.parse('https://love.mondian.store'),
          mobileWebUrl: Uri.parse('https://love.mondian.store')),
    ),
    social: Social(likeCount: 2025, commentCount: 02, sharedCount: 08),
  );

  static Future<void> shareInvitation() async {
    bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();
    if( isKakaoTalkSharingAvailable ) {
      try {
        await ShareClient.instance.shareDefault(template: KakaoShare.defaultFeed);
      } catch (e) {
        print(e);
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance.makeDefaultUrl(template: KakaoShare.defaultFeed);
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (e) {
        print(e);
      }
    }
  }
}