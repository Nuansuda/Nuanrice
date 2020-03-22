import 'package:flutter/material.dart';


class MyServiceState extends StatefulWidget {

  final String name;
  MyServiceState({Key key, this.name} ) : super(key: key);
  // รูปแบบการโยนค่าระหว่าง state

  @override
  _MyServiceStateState createState() => _MyServiceStateState();
}

class _MyServiceStateState extends State<MyServiceState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Service')),
    );
  }
}