import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readhubnew/Components/ovalrightborderclipper.dart';

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

Widget getCardComponent(height) {
  return Card(
      color: Colors.white,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/angular.png'),
              height: height / 9,
              width: height / 9,
            ),
            Container(
              alignment: Alignment.center,
              child: Text('Angular'),
            ),
          ],
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
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[350]),
      ),
      backgroundColor: Colors.yellow[800],
    ),
  );
}

Widget getRecentCardComponent(height) {
  return Container(
    width: height/3,
    child: Card(
        color: Colors.white,
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.only(left:4.0,right: 4.0,top: 4.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Yohan Malshika',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Image(
                image: AssetImage('assets/images/recent.png'),
                height: height / 6,
                width: height / 4,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'ReadHub is moving to flutter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4.0),
               alignment: Alignment.bottomLeft,
                child: Text(
                  'Date-2020.09.30',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )),
  );
}
