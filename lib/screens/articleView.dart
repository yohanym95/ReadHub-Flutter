import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ArticleView extends StatefulWidget {
  String authorImage, authorName, image, title, date, content, link;

  ArticleView(this.authorImage, this.authorName, this.image, this.title,
      this.date, this.content, this.link);
  @override
  _ArticleViewState createState() => _ArticleViewState(
      this.authorImage,
      this.authorName,
      this.image,
      this.title,
      this.date,
      this.content,
      this.link);
}

class _ArticleViewState extends State<ArticleView> {
  String authorImage, authorName, image, title, date, content, link;

  _ArticleViewState(this.authorImage, this.authorName, this.image, this.title,
      this.date, this.content, this.link);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                    child: image == null
                        ? Image(
                            image: AssetImage('assets/images/recent.png'),
                          )
                        : Image(
                            image: NetworkImage(image),
                          )),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 30.0, left: 8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30.0, right: 8.0),
                  alignment: Alignment.topRight,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      hoverColor: Colors.blue,
                      onTap: link.isEmpty
                          ? null
                          : () {
                              print(link);
                              RenderBox box = context.findRenderObject();
                              Share.share(link,
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
                              print('share');
                            },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
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
                        defaultTextStyle:
                            TextStyle(fontFamily: 'Poppins', fontSize: 13),
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
