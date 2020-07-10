import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellus_mockup/app/home/jobs/list_items_builder.dart';
import 'package:tellus_mockup/app/home/models/post.dart';
import 'package:tellus_mockup/app/home/posts/post_list_card.dart';
import 'package:tellus_mockup/services/database.dart';

import 'edit_post_page.dart';

class PostsPage extends StatelessWidget {

  Future<void> _delete(BuildContext context, Post post) async {
    // FIXME
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              var show = EditPostPage.show(
                context,
                database: Provider.of<Database>(context, listen: false),
              );
              return show;
            },
          )
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Post>>(
      stream: database.postsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Post>(
          snapshot: snapshot,
          itemBuilder: (context, post) => Dismissible(
            key: Key('post-${post.postId}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, post),
            child: PostListCard(
              post: post,
              onTap: () => EditPostPage.show(
                context,
                database: Provider.of<Database>(context, listen:false),
                post: post,
              ),
            ),
          )
        );
      }
    );
  }

}


