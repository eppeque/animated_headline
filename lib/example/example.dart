import 'package:flutter/material.dart';
import 'package:animated_headline/animated_headline.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedHeadline usage example',
      home: Scaffold(
        appBar: AppBar(
          /// Here is the [AnimatedHeadline] widget.
          /// You can use it like this (in an app bar) but you can use it also wherever you want!
          title: AnimatedHeadline(
            texts: ['School', 'Business'],
            colors: [Colors.blue, Colors.red],
            index: _currentIndex,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
          ],
        ),
      ),
    );
  }
}