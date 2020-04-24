import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readhubnew/Components/ovalrightborderclipper.dart';

String url =
    'https://firebasestorage.googleapis.com/v0/b/blogapp-463a6.appspot.com/o/1.png?alt=media&token=a0593d88-611d-4ad7-8a0d-0db6ffac61c8';

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
