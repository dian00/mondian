import 'package:flutter/material.dart';

class PostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5, // 게시물 개수
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'), // 프로필 이미지 경로
              ),
              title: Text("User ${index + 1}"),
              subtitle: Text("Location ${index + 1}"),
              trailing: Icon(Icons.more_vert),
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/post${index + 1}.jpg'), // 게시물 이미지 경로
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.favorite_border),
                      Icon(Icons.send),
                    ],
                  ),
                  Icon(Icons.bookmark_border),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Liked by User1 and others", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text("View all comments", style: TextStyle(color: Colors.grey)),
            ),
            Divider(height: 20, color: Colors.grey[300]),
          ],
        );
      },
    );
  }
}

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
                username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 8),
                  Icon(Icons.favorite_border),
                  Icon(Icons.send),
                ],
              ),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
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
