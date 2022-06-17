import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/home_screen.dart';
import 'package:library_app/intro_slider_screen.dart';
import 'package:library_app/json/plan.dart';
import 'package:library_app/select_plan_screen.dart';
import 'package:library_app/super_base.dart';

import 'json/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xff02A95C),
        fontFamily: 'Mikado'
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends Superbase<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var string = (await prefs).getString(userKey);

      var plan = (await prefs).getString("plan");
      Timer(const Duration(seconds: 2), () {
        if(string != null) {
          User.user = User.fromJson(jsonDecode(string));
          if(plan != null){
            User.user!.plan = Plan.fromJson(jsonDecode(plan));
            push(const HomeScreen(), replace: true);
          }else{
            push(const SelectPlanScreen(), replace: true);
          }
        }else{
          push(const IntroSliderScreen(), replace: true);
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
             Text(
              'ESPACE',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffFED857)
              ),
            ),
            Text(
              'MADIBA',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Color(0xff02A95C)
              ),
            ),
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
