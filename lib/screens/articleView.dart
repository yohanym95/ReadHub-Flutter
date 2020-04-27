import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:readhubnew/model/Post.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatefulWidget {
  String authorImage, authorName, image, title, date, content;

  ArticleView(this.authorImage, this.authorName, this.image, this.title,
      this.date, this.content);
  @override
  _ArticleViewState createState() => _ArticleViewState(this.authorImage,
      this.authorName, this.image, this.title, this.date, this.content);
}

class _ArticleViewState extends State<ArticleView> {
  String authorImage, authorName, image, title, date, content;

  _ArticleViewState(this.authorImage, this.authorName, this.image, this.title,
      this.date, this.content);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(),
                  child: Image(
                    image: NetworkImage(image),
                  )),

              // Icon(
              //   Icons.arrow_back,
              // )
              Container(
                margin: EdgeInsets.only(top: height / 4),
                // height: height,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(authorImage),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                fontSize: 17),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            authorName,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Poppins',
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              date,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Html(
                      defaultTextStyle: TextStyle(fontFamily: 'Poppins',fontSize: 13),
                      data: content,
                      onLinkTap: (String link) {
                        _launchUrl(link);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  _launchUrl(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Cannot launch $link';
    }
  }
}
