import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tellus_mockup/app/home/models/post.dart';
import 'dart:io';

class PostListCard extends StatelessWidget {
  const PostListCard({Key key, @required this.post, this.onTap})
      : super(key: key);
  final Post post;
  final VoidCallback onTap;

  String _getImagePath(String imgName) {
    String path = 'images/$imgName.jpg';
    return path;

  }

  @override
  Widget build(BuildContext context) {
    String path = _getImagePath(post.img);
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(path, fit: BoxFit.fitWidth),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              SizedBox(width: 15.0),
              Column(
                  children: <Widget>[
                    Image.asset(_getImagePath('avatar'), width: 50),
                    Text(post.speaker, style: TextStyle(fontSize: 15))
                  ]
              ),
              SizedBox(width: 20.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.title, style: TextStyle(fontSize: 30)),
                      SizedBox(height: 10.0),
                      Text(post.description,
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,),
                      SizedBox(height: 10.0),
                      Text('Fee: ${post.fee} yen', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10.0),
                      RaisedButton(
                        child: Text('Apply now'),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: onTap,
                      ),
                      SizedBox(height: 10.0),
                    ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
