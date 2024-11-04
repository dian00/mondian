import 'package:flutter/material.dart';

class InstagramWidget extends StatelessWidget {
  final String profileImageUrl = 'https://your-profile-image-url.jpg';
  final String weddingImageUrl = 'https://your-wedding-image-url.jpg';
  final int likesCount = 102;
  final int commentsCount = 5;

  final String username;
  final Widget content;
  final String descriptionText;

  const InstagramWidget({super.key, required this.username, required this.content, required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section with profile image and follow button
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profileImageUrl),
                radius: 20,
              ),
              SizedBox(width: 10),
              Text(
                "@" + username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  '팔로우',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        // Wedding image
        content,
        // Image.network(
        //   weddingImageUrl,
        //   fit: BoxFit.cover,
        //   width: double.infinity,
        //   height: 200,
        // ),
        // Description section
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: username + ' ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: descriptionText,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                )
              ],
            ),
          ),
        ),
        // Likes and comments section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            children: [
              Icon(Icons.favorite_border, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text('$likesCount개', style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(width: 20),
              Icon(Icons.comment_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text('$commentsCount개', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
