import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellus_mockup/app/home/models/post.dart';

class PostListCard extends StatelessWidget {
  const PostListCard({Key key, @required this.post, this.onTap}) : super(key: key);
  final Post post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      onTap: onTap,
    );
  }
}
