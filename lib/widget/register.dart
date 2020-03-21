import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field

  // Method

  Widget nameForm() {
    Color color = Colors.grey.shade600;
    String title = 'Name :';
    String help = 'Type Your Name In Blank';
    return TextField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
        helperStyle: TextStyle(color: color),
        helperText: help,
        labelStyle: TextStyle(color: Colors.brown),
        labelText: title,
        icon: Icon(
          Icons.account_box,
          size: 36.0,
          color: color,
        ),
      ),
    );
  }

  Widget userForm() {
    Color color = Colors.grey.shade800;
    String title = 'Username :';
    String help = 'Type Your User In Blank';
    return TextField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
        helperStyle: TextStyle(color: color),
        helperText: help,
        labelStyle: TextStyle(color: Colors.brown),
        labelText: title,
        icon: Icon(
          Icons.supervised_user_circle,
          size: 36.0,
          color: color,
        ),
      ),
    );
  }

  Widget passForm() {
    Color color = Colors.grey.shade900;
    String title = 'Password :';
    String help = 'Type Your Password In Blank';
    return TextField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
        helperStyle: TextStyle(color: color),
        helperText: help,
        labelStyle: TextStyle(color: Colors.brown),
        labelText: title,
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: color,
        ),
      ),
    );
  }

  Widget showAvartar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Image.asset('images/avartar.png'),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(
        Icons.description,
        size: 40.0,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[showAvartar(), nameForm(), userForm(), passForm()],
      ),
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        title: Text('Register'),
        backgroundColor: Colors.brown.shade300,
      ),
    );
  }
}
