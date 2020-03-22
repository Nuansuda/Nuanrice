import 'package:flutter/material.dart';

class MyServiceState extends StatefulWidget {
  final String name;
  MyServiceState({Key key, this.name}) : super(key: key);
  // รูปแบบการโยนค่าระหว่าง state

  @override
  _MyServiceStateState createState() => _MyServiceStateState();
}

class _MyServiceStateState extends State<MyServiceState> {
  // Field
  String nameLogin;

  // method
  @override
  void initState(){
    super.initState();
    nameLogin = widget.name;
  }


  Widget showNameLogin() {
    return Column(
      children: <Widget>[
        Text('Login by'),
        Text(nameLogin),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[showNameLogin()],
        title: Text('My Service'),
        backgroundColor: Colors.orange.shade300,
      ),
    );
  }
}
