import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:readhubnew/Components/ovalrightborderclipper.dart';
import 'package:readhubnew/model/Article.dart';
import 'package:readhubnew/screens/articleView.dart';
import 'package:url_launcher/url_launcher.dart';

String url =
    'https://firebasestorage.googleapis.com/v0/b/blogapp-463a6.appspot.com/o/readhublogo.png?alt=media&token=f20f89a5-77fe-432a-84db-a93f5f821411';

buildDrawer(context, height) {
  return ClipPath(
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 40),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.blue[200], Colors.blue]),
            boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                height: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.lightBlueAccent, Colors.lightBlue])),
                child: url == null
                    ? CircleAvatar(
                        child: Icon(
                        Icons.person,
                        color: Colors.blue[100],
                      ))
                    : CircleAvatar(
                        radius: 37,
                        backgroundImage: NetworkImage(url),
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Join With Us',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Material(
                child: InkWell(
                  child: buildRow(Icons.group_work, 'Tech Forum'),
                  onTap: () {
                    _launchUrl('http://forum.readhub.lk/');
                  },
                ),
                color: Colors.transparent,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Like & Follow Us',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Divider(),
              Material(
                child: InkWell(
                  child: buildRow(FontAwesomeIcons.facebook, 'Facebook'),
                  onTap: () async {
                    try {
                      bool launched = await launch('fb://page/2660854717474049',
                          forceSafariVC: false);

                      if (!launched) {
                        await launch('https://www.facebook.com/readhublk',
                            forceSafariVC: false);
                      }
                    } catch (e) {
                      await launch('https://www.facebook.com/readhublk',
                          forceSafariVC: false);
                    }
                  },
                ),
                color: Colors.transparent,
              ),
              Material(
                child: InkWell(
                  child: buildRow(FontAwesomeIcons.linkedin, 'Linkedin'),
                  onTap: () {
                    _launchUrl('https://www.linkedin.com/company/readhub/');
                  },
                ),
                color: Colors.transparent,
              ),
              Material(
                child: InkWell(
                  child: buildRow(FontAwesomeIcons.youtube, 'YouTube'),
                  onTap: () {
                    _launchUrl(
                        'https://www.youtube.com/channel/UCbEkMN8pKtoV24vrhBrChhA');
                  },
                ),
                color: Colors.transparent,
              ),
              Material(
                child: InkWell(
                  child: buildRow(FontAwesomeIcons.twitter, 'Twitter'),
                  onTap: () {
                    _launchUrl('https://twitter.com/readhublk');
                  },
                ),
                color: Colors.transparent,
              ),
              Divider(),
              Material(
                child: InkWell(
                  child: buildRow(Icons.rate_review, 'Rate Us'),
                  onTap: () async {
                    final PackageInfo info = await PackageInfo.fromPlatform();
                    try {
                      bool launched = await launch(
                          'market://details?id=${info.packageName}',
                          forceSafariVC: false);

                      if (!launched) {
                        await launch(
                            'https://play.google.com/store/apps/details?id=${info.packageName}',
                            forceSafariVC: false);
                      }
                    } catch (e) {
                      await launch(
                          'https://play.google.com/store/apps/details?id=${info.packageName}',
                          forceSafariVC: false);
                    }
                  },
                ),
                color: Colors.transparent,
              ),
              Material(
                child: InkWell(
                  child: buildRow(Icons.contacts, 'Contact Us'),
                  onTap: () {
                    _launchUrl('https://readhub.lk/contact-us/');
                  },
                ),
                color: Colors.transparent,
              ),
              Material(
                child: InkWell(
                  child: buildRow(Icons.info, 'About Us'),
                  onTap: () {
                    aboutDialog(context, height);
                  },
                ),
                color: Colors.transparent,
              ),
            ],
          ),
        )),
      ),
    ),
    clipper: OvalRightBorderClipper(),
  );
}

Widget buildRow(IconData icon, String title) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        )
      ],
    ),
  );
}

Widget getCardComponent(height, imagePath, title) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.grey[300],
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: height / 7,
          width: height / 7,
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(imagePath),
                height: height / 11,
                width: height / 11,
              ),
              SizedBox(
                height: 2,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}

Widget getTopicChip(topic) {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Chip(
      elevation: 3,
      label: Text(
        topic,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins'),
      ),
      backgroundColor: Colors.yellow[800],
    ),
  );
}

Widget getRecentCardComponent(height, authorImage, authorName, image, title,
    date, content, context, link) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(authorImage, authorName,
                    image, title, date, content, link)));
      },
      child: Container(
        width: height / 3,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.grey[300],
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(authorImage),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        authorName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 3),
                      child: image == null
                          ? Image(
                              image: AssetImage('assets/images/recent.png'),
                              height: height / 6,
                              width: height / 4,
                            )
                          : Image(
                              image: NetworkImage(image),
                              height: height / 6,
                              width: height / 4,
                            )),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}

Widget loadMainCard(height, title) {
  List<Article> postList = [];

  return FutureBuilder(
    future: FirebaseDatabase.instance
        .reference()
        .child('Articles')
        .child(title)
        .limitToLast(5)
        .orderByChild('id')
        .once(),
    // initialData: InitialData,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/images/readhub.png'),
                height: height / 6,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          ],
        ));
      }

      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          var Data = snapshot.data.value;
          if (Data != null) {
            var keys = snapshot.data.value.keys;
            postList.clear();

            for (var individualKey in keys) {
              Article article = new Article(
                  Data[individualKey]['id'],
                  Data[individualKey]['title'],
                  Data[individualKey]['authorImage'],
                  Data[individualKey]['authorname'],
                  Data[individualKey]['date'],
                  Data[individualKey]['content'],
                  Data[individualKey]['image'],
                  Data[individualKey]['link']);

              postList.add(article);
              // postList.sort();

            }
            return postList.length == 0
                ? Center(
                    child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('assets/images/readhub.png'),
                          height: height / 6,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: postList.length,
                    itemBuilder: (_, index) {
                      return getRecentCardComponent(
                        height,
                        postList[index].authorimage,
                        postList[index].authorname,
                        postList[index].image,
                        postList[index].title,
                        postList[index].date,
                        postList[index].content,
                        context,
                        postList[index].link,
                      );
                    },
                  );
          }
        } else {
          return Center(
              child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/images/readhub.png'),
                  height: height / 6,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            ],
          ));
        }
        return Center(
            child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/images/readhub.png'),
                height: height / 6,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          ],
        ));
      }
    },
  );
}

Widget getPostCardComponent(height, authorImage, authorName, image, title, date,
    content, link, context) {
  return Material(
    color: Colors.transparent,
      child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                    authorImage, authorName, image, title, date, content, link)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            color: Colors.grey[300],
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(authorImage),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        authorName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 3),
                      child: image == null
                          ? Image(
                              image: AssetImage('assets/images/recent.png'),
                              height: height / 6,
                              width: height / 4,
                            )
                          : Image(
                              image: NetworkImage(image),
                              height: height / 6,
                              width: height / 4,
                            )),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            )),
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

void aboutDialog(BuildContext context, height) {
  Dialog dialogWithImage = Dialog(
    child: Card(
      child: Container(
        height: height / 2,
        width: height / 3,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Text(
                "ReadHub",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: height / 6,
              width: height / 6,
              child: Image.asset(
                'assets/images/readhub.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(
                "ReadHub is Online Media Platform for Latest Technology, TV Series, Movies, Games, Web News and Tutorials.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(
                "Readhublk@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(
                "http://readhub.lk",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "Hi,Let's read Articles",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  showDialog(
      context: context, builder: (BuildContext context) => dialogWithImage);
}
