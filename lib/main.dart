import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import 'game/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Run',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dino Run'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DinoGame game;

  @override
  void initState() {
    super.initState();
    game = DinoGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: game.widget);
  }
}
