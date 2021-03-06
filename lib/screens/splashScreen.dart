import 'package:flutter/material.dart';
import 'package:readhubnew/logic/callAPI.dart';
import 'package:readhubnew/main.dart';
import 'package:connectivity/connectivity.dart';
import 'package:readhubnew/Components/components.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String englishUrl =
      "https://readhub.lk/wp-json/wp/v2/posts?per_page=15&_embed";
  String sinhalaUrl =
      "https://sinhala.readhub.lk/wp-json/wp/v2/posts?per_page=15&_embed";

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sendEnglishPosts(englishUrl).then((onValue) {
      sendSinhalaPosts(sinhalaUrl).then((onValue) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,
        );
      });
    }).catchError((onError) {
      showColoredToast('Please Check Your Internet Connection & Try again!');
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.white.withOpacity(0.45), BlendMode.dstATop),
          image: new AssetImage("assets/images/huda.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: new Center(
          child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Image.asset('assets/images/readhub.png'),
            height: height / 4,
            width: height / 4,
          )),
          Container(child: CircularProgressIndicator()),
          Container(
            margin: EdgeInsets.all(8),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ReadHub',
              style: TextStyle(
                  letterSpacing: 3,
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ),
        ],
      )),
    ));
  }
}
