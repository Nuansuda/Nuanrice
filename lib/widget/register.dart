
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuanrice/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field

  File file;
  String name, username, password, urlPath;

  // Method

  Widget nameForm() {
    Color color = Colors.grey.shade600;
    String title = 'Name :';
    String help = 'Type Your Name In Blank';
    return TextField(
      onChanged: (value) => name = value.trim(),
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: color)),
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
      onChanged: (value) => username = value.trim(),
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: color)),
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
      onChanged: (value) => password = value.trim(),
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: color)),
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
    return GestureDetector(
      onTap: () {
        print('You Click Images');
        cameraThread();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child:
            file == null ? Image.asset('images/avartar.png') : Image.file(file),
      ),
    );
  }

  Future<void> cameraThread() async {
    try {
      var object = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(
        Icons.description,
        size: 40.0,
      ),
      onPressed: () {
        if (file == null) {
          normalDialog(context, 'Non Choose Avartar',
              'Please Click Images for Open Camera');
        } else if (name == null ||
            name.isEmpty ||
            username == null ||
            username.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please Your push Data');
        } else {
          uploadImageToServer();

        }
        {}
      },
    );
  }

// นี่คือตัวอย่างการอัพโหลดรูปไป server

  Future<void>uploadImageToServer()async{

    try {
      String url = 'https://www.androidthai.in.th/rice/saveFileNuan.php';
      Map<String, dynamic> map = Map();

      Random random = Random();
      int i = random.nextInt(100000);

      map['file'] = UploadFileInfo(file, 'username$i.jpg');
      FormData formData = FormData.from(map);


      var response = await Dio().post(url, data: formData);
      print('response = ${response.toString()}');
      urlPath = 'https://www.androidthai.in.th/rice/Nuan/username$i.jpg';
      inserDataToMySQL();
  
    } catch (e) {
      print('error ==> ${e.toString()}');
    }
  }

  Future<void>inserDataToMySQL()async{

    try {
      String url = 'https://www.androidthai.in.th/rice/addUserNuan.php?isAdd=true&Name=$name&Username=$username&Password=$password&Avartar=$urlPath';
      var response = await Dio().get(url);
      if (response.toString()== 'true') {
        Navigator.of(context).pop();
        
        
      } else {
        normalDialog(context, 'Cannot Register','Please Try Again');
      }
    } catch (e) {
    }
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
