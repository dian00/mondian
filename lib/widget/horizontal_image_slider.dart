
import 'package:flutter/widgets.dart';

class HorizontalImageSlider extends StatelessWidget {
  final List<Widget> children;

  const HorizontalImageSlider({super.key, required this.children});
  // final List<String> imageUrls = [
  //   'https://your-wedding-image1.jpg',
  //   'https://your-wedding-image2.jpg',
  //   'https://your-wedding-image3.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // 슬라이더의 높이
      child: PageView.builder(
        itemCount: children.length,//imageUrls.length,
        controller: PageController(viewportFraction: 0.8), // 슬라이드 간격 조절
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: children[index],)//Image.network(imageUrls[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}