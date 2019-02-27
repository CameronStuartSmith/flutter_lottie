import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: LottieView.fromURL(
            url: "https://raw.githubusercontent.com/airbnb/lottie-ios/master/Example/Tests/Watermelon.json",
            autoPlay: true,
            loop: true,
            reverse: true,
            onViewCreated: (LottieController _) {

            },
          )
        ),
      ),
    );
  }
}
