import 'package:flutter/material.dart';

class LikeWidget extends StatefulWidget {
  // final int id;

  @override
  _LikeWidgetState createState() => _LikeWidgetState();
  const LikeWidget({super.key});
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isLiked = false;
  int likeCount = 0;

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount -= 1;
      } else {
        likeCount += 1;
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : null,
          ),
          onPressed: _toggleLike,
        ),
        Text('$likeCount Likes'),
      ],
    );
  }
}
