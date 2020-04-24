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
  @override
  Widget build(BuildContext context) {
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
                  letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 20),
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
      body: Center(),
    );
  }
}
