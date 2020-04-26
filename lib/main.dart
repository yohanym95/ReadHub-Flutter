import 'package:flutter/material.dart';
import 'package:readhubnew/Components/components.dart';
import 'package:readhubnew/logic/callAPI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReadHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
  String englishUrl =
      "https://readhub.lk/wp-json/wp/v2/posts?per_page=15&_embed";
  String sinhalaUrl =
      "https://sinhala.readhub.lk/wp-json/wp/v2/posts?per_page=15&_embed";

  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    sendEnglishPosts(englishUrl);
    sendSinhalaPosts(sinhalaUrl);
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
                image: NetworkImage(url),
                width: 50,
                height: 50,
              ),
              Text(
                'ReadHub',
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
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
        ),
        drawer: buildDrawer(),
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
                          label: Text('Sinhala'),
                          elevation: 10,
                          pressElevation: 20.0,
                          selected: isSelected,
                          selectedColor: Colors.orange,
                          onSelected: (bool value) {
                            setState(() {
                              isSelected = true;
                              //  mainContent = getSinhalaContent(height);
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeOutCirc,
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
                            'English',
                          ),
                          selected: !isSelected,
                          elevation: 10,
                          pressElevation: 10.0,
                          selectedColor: Colors.orange,
                          onSelected: (bool value) {
                            setState(() {
                              isSelected = false;
                              //  mainContent = getEnglishContent(height);
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeOutCirc,
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
                height: height,
                child: PageView(
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
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
              height: height / 6,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/kotlin.png', 'Kotlin'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/cloud.png', 'Cloud Computing'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(height, 'assets/images/network.png',
                        'Computer Nteworking'),
                  ),
                  InkWell(
                      onTap: () {},
                      child: getCardComponent(
                          height, 'assets/images/git.png', 'GIT')),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/python.png', 'Python'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/js.png', 'JavaScript'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/flutter.png', 'Flutter'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/ml.png', 'Machine Learning'),
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
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/law.png', 'Law Basics'),
                  ),
                  InkWell(
                      onTap: () {},
                      child: getCardComponent(
                          height, 'assets/images/tech.png', 'Devices')),
                  InkWell(
                    child: getCardComponent(
                        height, 'assets/images/devices.png', 'Tech News'),
                  ),
                  InkWell(
                    onTap: () {},
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
          getTopicChip('Tutorials Sinhala'),
          Container(
              //color: Colors.white,
              height: height / 6,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/kotlin.png', 'Kotlin'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/cloud.png', 'Cloud Computing'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(height, 'assets/images/network.png',
                        'Computer Nteworking'),
                  ),
                  InkWell(
                      onTap: () {},
                      child: getCardComponent(
                          height, 'assets/images/git.png', 'GIT')),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/python.png', 'Python'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/js.png', 'JavaScript'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/flutter.png', 'Flutter'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/ml.png', 'Machine Learning'),
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
                    onTap: () {},
                    child: getCardComponent(
                        height, 'assets/images/law.png', 'Law Basics'),
                  ),
                  InkWell(
                      onTap: () {},
                      child: getCardComponent(
                          height, 'assets/images/tech.png', 'Devices')),
                  InkWell(
                    child: getCardComponent(
                        height, 'assets/images/devices.png', 'Tech News'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: getCardComponent(height, 'assets/images/english.png',
                        'English For Life'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
