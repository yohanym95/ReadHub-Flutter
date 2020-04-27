import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:readhubnew/model/Post.dart';
import 'package:http/http.dart' as http;

List<Post> posts = List();

Future<void> sendEnglishPosts(url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    posts = (json.decode(response.body) as List).map((data) {
      return Post.fromJSON(data);
    }).toList();
    // setState(() {
    //   isLoading = false;
    // });
  }

  for (int i = 0; i < posts.length; i++) {
    Post post = posts[i];
    String title;
    title = post.title.toString().replaceAll('&#8211;', '').replaceAll("&#x200d;", "").replaceAll('&#8230;', "").replaceAll("&amp;", "").replaceAll('&#8220;', '').replaceAll('&#8221;', '').replaceAll('&#8217;', '');

    FirebaseDatabase.instance
        .reference()
        .child('Articles')
        .child('RecentEnglishArticles')
        .child(post.id.toString())
        .set({
      'id': post.id,
      'title': title.toString(),
      'image': post.image,
      'authorname': post.authorname,
      'authorImage': post.authorimage,
      'content': post.content,
      'date': post.date
    }).then((onValue) {
      print('sent to haven');
    }).catchError((onError) {
      print('Error ');
    });
  }
}

Future<void> sendSinhalaPosts(url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    posts = (json.decode(response.body) as List).map((data) {
      return Post.fromJSON(data);
    }).toList();
    // setState(() {
    //   isLoading = false;
    // });
  }

  for (int i = 0; i < posts.length; i++) {
    Post post = posts[i];
    String title;
    title = post.title.toString().replaceAll('&#8211;', '').replaceAll("&#x200d;", "").replaceAll('&#8230;', "").replaceAll("&amp;", "").replaceAll('&#8220;', '').replaceAll('&#8221;', '');

    FirebaseDatabase.instance
        .reference()
        .child('Articles')
        .child('RecentSinhalaArticles')
        .child(post.id.toString())
        .set({
      'id': post.id,
      'title': title.toString(),
      'image': post.image,
      'authorname': post.authorname,
      'authorImage': post.authorimage,
      'content': post.content,
      'date': post.date
    }).then((onValue) {
      print('sent to haven');
    }).catchError((onError) {
      print('Error ');
    });
  }
}


