import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readhubnew/Components/ovalrightborderclipper.dart';
import 'package:readhubnew/model/Article.dart';

String url =
    'https://firebasestorage.googleapis.com/v0/b/blogapp-463a6.appspot.com/o/readhublogo.png?alt=media&token=f20f89a5-77fe-432a-84db-a93f5f821411';

buildDrawer() {
  return ClipPath(
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 40),
        decoration: BoxDecoration(
            color: Colors.blue, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
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
                        radius: 40,
                        backgroundImage: NetworkImage(url),
                      ),
              ),
              SizedBox(
                height: 35,
              ),
              GestureDetector(
                child: buildRow(FontAwesomeIcons.facebook, 'Facebook'),
                onTap: () {
                  //
                },
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
  final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16);
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: textStyle,
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
          width: height / 8,
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

Widget getRecentCardComponent(
    height, authorImage, authorName, image, title, date) {
  return Container(
    width: height / 3,
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
                child: Image(
                  image: NetworkImage(image),
                  height: height / 6,
                  width: height / 4,
                ),
              ),
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
                Data[individualKey]['image']);

            postList.add(article);
            // postList.sort();

          }
          return postList.length == 0
              ? SizedBox(
                  height: 10,
                  width: 10,
                  child: Text('No Data'),
                )
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
                        postList[index].date);
                  },
                );
        }
      } else {
        return Text('No data');
      }
    },
  );
}
