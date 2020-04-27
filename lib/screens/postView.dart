import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readhubnew/Components/components.dart';
import 'package:readhubnew/logic/callAPI.dart';
import 'package:readhubnew/model/Post.dart';
import 'package:http/http.dart' as http;

class PostView extends StatefulWidget {
  String imageUrl, topicTitle, url;

  PostView(this.imageUrl, this.topicTitle, this.url);
  @override
  _PostViewState createState() =>
      _PostViewState(this.imageUrl, this.topicTitle, this.url);
}

class _PostViewState extends State<PostView> {
  String imageUrl, topicTitle, url;

  _PostViewState(this.imageUrl, this.topicTitle, this.url);

  List<Post> postlist = List();
  bool isLoading = false;

  @override
  void initState() {
    getPosts(url);
    super.initState();
  }

  Future<void> getPosts(url) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      postlist = (json.decode(response.body) as List).map((data) {
        return Post.fromJSON(data);
      }).toList();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blue[200], Colors.blue[800]]),
              ),
              height: height / 2.5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage(imageUrl),
                          height: height / 3,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 8.0),
                  child: Text(
                    topicTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: height / 3),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Container(
                  child: this.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 8),
                          child: ListView.builder(
                            itemCount: postlist.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return getPostCardComponent(
                                  height,
                                  postlist[index].authorimage,
                                  postlist[index].authorname,
                                  postlist[index].image,
                                  postlist[index]
                                      .title
                                      .toString()
                                      .replaceAll('&#8211;', '')
                                      .replaceAll("&#x200d;", "")
                                      .replaceAll('&#8230;', "")
                                      .replaceAll("&amp;", "")
                                      .replaceAll('&#8220;', '')
                                      .replaceAll('&#8221;', ''),
                                  postlist[index].date,
                                  postlist[index].content,
                                  context);
                            },
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
