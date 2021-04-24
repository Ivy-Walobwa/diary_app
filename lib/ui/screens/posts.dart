import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/shared_prefs_settings.dart';
import '../../data/moor_db.dart';
import 'post_detail.dart';
import 'package:intl/intl.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;
  List<BlogPostData> posts;
  @override
  void initState() {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MoorDb moorDb = Provider.of<MoorDb>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
        backgroundColor: Color(settingColor),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(settingColor),
          onPressed: () {
            BlogPostData post = BlogPostData(
                id: 0, name: '', content: '', date: null);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetailScreen(post, true)));
          }),
      body: FutureBuilder(
        future: moorDb.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            posts = snapshot.data;
          } else {
            posts = [];
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              DateFormat formatter = DateFormat('dd/MM/yyyy');
              String postDate = (posts[index].date != null) ? formatter.format(posts[index].date): '';
              return Dismissible(
                key: Key(posts[index].id.toString()),
                onDismissed: (direction) {
                  moorDb.deletePost(posts[index]);
                },
                child: ListTile(
                  title: Text(posts[index].name),
                  subtitle: Text(postDate),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostDetailScreen(posts[index], false)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}