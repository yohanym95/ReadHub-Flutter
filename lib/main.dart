import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:readhubnew/Components/components.dart';
import 'package:readhubnew/screens/postView.dart';
import 'package:readhubnew/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReadHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = ['Sinhala', 'English'];
  bool isSelected = false;
  bool isSubscribe = false;

  PageController _pageController;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setValue() async {
    final SharedPreferences prefs = await _prefs;

    if (prefs.getString("newOne") == null) {
      prefs.setString("newOne", "new");
      prefs.setString("subscribe", "subscribe");
      firebaseMessaging.subscribeToTopic('ReadHub');
      isSubscribe = true;
    } else {
      if (prefs.getString("subscribe") == "subscribe") {
        isSubscribe = true;
      } else if (prefs.getString("subscribe") == "subscribe") {
        isSubscribe = false;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    setValue();
    super.initState();
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("onLaunch called");
      },
      onResume: (Map<String, dynamic> msg) {
        print("onResume called");
      },
      onMessage: (Map<String, dynamic> msg) {
        print("pnMessage called");
      },
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    firebaseMessaging.onIosSettingsRegistered.listen((onData) {
      print('IOS Setting registered : ');
    });

    firebaseMessaging.getToken().then((token) {
      print('tokenhOMEpAGE: $token');
      // textValue = token;
      DatabaseReference databaseReference = new FirebaseDatabase().reference();
      databaseReference.child('fcm-token/${token}').set({'token': token});
      setState(() {});
    });

    super.initState();
  }

  Widget mainContent;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    mainContent = getEnglishContent(height);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/logo.png'),
                width: 50,
                height: 50,
              ),
              Text(
                'ReadHub',
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins'),
              )
            ],
          ),
          backgroundColor: Colors.blue,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blue[200], Colors.blue])),
          ),
          actions: <Widget>[
            isSubscribe
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Material(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        child: Icon(Icons.notifications_active),
                        onTap: () {
                          setState(() {
                            firebaseMessaging.unsubscribeFromTopic('ReadHub');
                            isSubscribe = false;
                            showColoredToast(
                                'Unsubscribe the Notifications of Application');
                            print('unsubscribe');
                          });
                        },
                      ),
                      color: Colors.transparent,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Material(
                      child: InkWell(
                        child: Icon(Icons.notifications_off),
                        onTap: () {
                          setState(() {
                            firebaseMessaging.subscribeToTopic('ReadHub');
                            isSubscribe = true;
                            showColoredToast(
                                'Subscribe the Notifications of Application');
                            print('subscribe');
                          });
                        },
                      ),
                      color: Colors.transparent,
                    ),
                  )
          ],
        ),
        drawer: buildDrawer(context, height),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.maxFinite,
                height: height / 9,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.blue[200], Colors.blue]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80.0),
                      bottomRight: Radius.circular(80.0)),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: height / 48,
                    ),
                    Center(
                        child: Row(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ChoiceChip(
                          label: Text(
                            'English',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          selected: !isSelected,
                          elevation: 10,
                          pressElevation: 10.0,
                          selectedColor: Colors.deepPurple[400],
                          onSelected: (bool value) {
                            setState(() {
                              isSelected = false;
                              //  mainContent = getEnglishContent(height);
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.bounceInOut,
                                );
                              }
                            });
                          },
                          backgroundColor: Colors.blue,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100]),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        ChoiceChip(
                          label: Text(
                            'Sinhala',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          elevation: 10,
                          pressElevation: 20.0,
                          selected: isSelected,
                          selectedColor: Colors.deepPurple[400],
                          onSelected: (bool value) {
                            setState(() {
                              isSelected = true;
                              //  mainContent = getSinhalaContent(height);
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.bounceInOut,
                                );
                              }
                            });
                          },
                          backgroundColor: Colors.blue,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100]),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              // mainContent,
              Container(
                margin: EdgeInsets.only(top: height / 9),
                height: height + 20,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  children: <Widget>[
                    Card(
                      color: Colors.grey[200],
                      child: getEnglishContent(height),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    Card(
                      color: Colors.grey[200],
                      child: getSinhalaContent(height),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget getEnglishContent(height) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getTopicChip('Recent'),
          Container(
            //color: Colors.white,
            height: height / 3,
            width: double.maxFinite,
            child: loadMainCard(height, 'RecentEnglishArticles'),
          ),
          getTopicChip('Tutorials'),
          Container(
              //color: Colors.white,
              height: height / 5,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/kotlin.png',
                                  'Kotlin',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=102&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/kotlin.png', 'Kotlin'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/cloud.png',
                                  'Cloud Computing',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=5&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/cloud.png', 'Cloud Computing'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/network.png',
                                  'Computer Networking',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=17&per_page=15&_embed')));
                    },
                    child: getCardComponent(height, 'assets/images/network.png',
                        'Computer Networking'),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostView(
                                    'assets/images/git.png',
                                    'GIT',
                                    'https://readhub.lk/wp-json/wp/v2/posts?categories=10&per_page=15&_embed')));
                      },
                      child: getCardComponent(
                          height, 'assets/images/git.png', 'GIT')),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/python.png',
                                  'Python',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=39&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/python.png', 'Python'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/js.png',
                                  'JavaScript',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=129&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/js.png', 'JavaScript'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/flutter.png',
                                  'Flutter',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=248&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/flutter.png', 'Flutter'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/ml.png',
                                  'Machine Learing',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=268&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/ml.png', 'Machine Learning'),
                  )
                ],
              )),
          getTopicChip('Other'),
          Container(
              //color: Colors.white,
              height: height / 5,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/law.png',
                                  'Law Basics',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=148&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/law.png', 'Law Basics'),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostView(
                                    'assets/images/tech.png',
                                    'Devices',
                                    'https://readhub.lk/wp-json/wp/v2/posts?categories=33&per_page=15&_embed')));
                      },
                      child: getCardComponent(
                          height, 'assets/images/tech.png', 'Devices')),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/devices.png',
                                  'Tech News',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=3&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/devices.png', 'Tech News'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/english.png',
                                  'English For Life',
                                  'https://readhub.lk/wp-json/wp/v2/posts?categories=287&per_page=15&_embed')));
                    },
                    child: getCardComponent(height, 'assets/images/english.png',
                        'English For Life'),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget getSinhalaContent(height) {
    double containerHeight = height / 9;
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getTopicChip('Recent'),
          Container(
            //color: Colors.white,
            height: height / 3,
            width: double.maxFinite,
            child: loadMainCard(height, 'RecentSinhalaArticles'),
          ),
          getTopicChip('Tutorials සිංහලෙන්'),
          Container(
              //color: Colors.white,
              height: height / 6,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/java.png',
                                  'JAVA',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=766&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/java.png', 'JAVA'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/angular.png',
                                  'Angular',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=757&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/angular.png', 'Angular'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/arduino.png',
                                  'Arduino',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=1106&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/arduino.png', 'Arduino'),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostView(
                                    'assets/images/php.png',
                                    'PHP',
                                    'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=917&per_page=15&_embed')));
                      },
                      child: getCardComponent(
                          height, 'assets/images/php.png', 'PHP')),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/html.png',
                                  'HTML',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=930&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/html.png', 'HTML'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/unity.png',
                                  'Unity',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=753&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/unity.png', 'Unity'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/git.png',
                                  'GIT',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=185&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/git.png', 'GIT'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/android.png',
                                  'Android',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=952&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/android.png', 'Android'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/fiverr.png',
                                  'Fiverr',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=273&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/fiverr.png', 'Fiverr'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/sql.png',
                                  'SQL',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=943&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/sql.png', 'SQL'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/react.png',
                                  'React Native',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=975&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/react.png', 'React Native'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/laravel.png',
                                  'Laravel',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=1366&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/laravel.png', 'Laravel'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/xml.png',
                                  'XML',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=1310&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/xml.png', 'XML'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/python.png',
                                  'Python',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=1395&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/python.png', 'Python'),
                  )
                ],
              )),
          getTopicChip('Other'),
          Container(
              //color: Colors.white,
              height: height / 6,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/movies.png',
                                  'Movies',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=35&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/movies.png', 'Movies'),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostView(
                                    'assets/images/games.png',
                                    'Games',
                                    'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=64&per_page=15&_embed')));
                      },
                      child: getCardComponent(
                          height, 'assets/images/games.png', 'Games')),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/sport.png',
                                  'Sport',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=57&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/sport.png', 'Sport'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/animation.png',
                                  'Animation',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=807&per_page=15&_embed')));
                    },
                    child: getCardComponent(height,
                        'assets/images/animation.png', 'Animation සිංහලෙන්'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/tech.png',
                                  'Devices',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=195&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/tech.png', 'Devices'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/devices.png',
                                  'Tech News සිංහලෙන්',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=38&per_page=15&_embed')));
                    },
                    child: getCardComponent(height, 'assets/images/devices.png',
                        'Tech News සිංහලෙන්'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/devices.png',
                                  'Tech News Tamil',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=218&per_page=15&_embed')));
                    },
                    child: getCardComponent(
                        height, 'assets/images/devices.png', 'Tech News Tamil'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                  'assets/images/entertainment.png',
                                  'Entertainment',
                                  'https://sinhala.readhub.lk/wp-json/wp/v2/posts?categories=376&per_page=15&_embed')));
                    },
                    child: getCardComponent(height,
                        'assets/images/entertainment.png', 'Entertainment'),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  
}
