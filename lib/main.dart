import 'package:flutter/material.dart';
import 'package:readhubnew/Components/components.dart';

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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ChoiceChip(
                          label: Text('Sinhala'),
                          elevation: 5,
                          pressElevation: 10.0,
                          selected: isSelected,
                          selectedColor: Colors.green,
                          onSelected: (bool value) {
                            setState(() {
                              isSelected = true;
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
                          elevation: 5,
                          pressElevation: 10.0,
                          selectedColor: Colors.green,
                          onSelected: (bool value) {
                            setState(() {
                              isSelected = false;
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
              getContent(height),
            ],
          ),
        ));
  }

  Widget getContent(height) {
    double containerHeight = height / 9;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: containerHeight - 4,
          ),
          getTopicChip('Recent'),
          Container(
              //color: Colors.white,
              height: height / 3,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  getRecentCardComponent(height),
                  getRecentCardComponent(height),
                  getRecentCardComponent(height),
                  getRecentCardComponent(height),
                  getRecentCardComponent(height)
                ],
              )),
          getTopicChip('Tutorials'),
          Container(
              //color: Colors.white,
              height: height / 6,
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  getCardComponent(height),
                  getCardComponent(height),
                  getCardComponent(height),
                  getCardComponent(height),
                  getCardComponent(height)
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
                  getCardComponent(height),
                  getCardComponent(height),
                  getCardComponent(height),
                  getCardComponent(height),
                  getCardComponent(height)
                ],
              )),
        ],
      ),
    );
  }
}
