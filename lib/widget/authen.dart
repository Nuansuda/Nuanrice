import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuanrice/utility/normal_dialog.dart';
import 'package:nuanrice/widget/my_service.dart';
import 'package:nuanrice/widget/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field

  String username, password;

// Method

  Widget singInButton() {
    return RaisedButton(
      color: Colors.brown.shade200,
      child: Text('Sign In'),
      onPressed: () {
        if (username == null ||
            username.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please Your push Data');
        } else {
          checkAuthen();
        }
      },
    );
  }

  Future<Void> checkAuthen() async {
    try {
      String url =
          'https://www.androidthai.in.th/rice/getUserWhereUserNuan.php?isAdd=true&Username=$username';

      var response = await Dio().get(url);
      print('reponse ===>> $response');

      if (response.toString() == 'null') {
        normalDialog(context, 'User False', 'No $username in my database');
      } else {
        var result = json.decode(response.data);
        print('result ===>> $result');

        for (var map in result) {
          String truePassword = map['Password'];
          String nameLogin = map['Name'];

          if (password == truePassword) {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => MyServiceState(
                name: nameLogin,
              ),
            );
            Navigator.of(context).pushAndRemoveUntil(route, (value)=> false);
          } else {
            normalDialog(
                context, 'Password False', 'Please try again password');
          }
        }
      }
    } catch (e) {}
  }

  Widget singUpButton() {
    return OutlineButton(
      child: Text('Sign Up'),
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Register());
        Navigator.of(context).push(route);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        singInButton(),
        mySizeBox(),
        singUpButton(),
      ],
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      height: 26.0,
      width: 8.0,
    );
  }

  Widget userForm() {
    return Container(
      width: 280,
      child: TextField(
        onChanged: (value) => username = value.trim(),
        decoration: InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget passForm() {
    return Container(
      width: 280,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Nuan Rice',
      style: GoogleFonts.liuJianMaoCao(
          textStyle: TextStyle(
        color: Colors.brown.shade900,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: 50.0,
      )),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, Colors.brown],
            radius: 0.7,
            center: Alignment(0, -0.1),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                showAppName(),
                mySizeBox(),
                userForm(),
                mySizeBox(),
                passForm(),
                mySizeBox(),
                showButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
