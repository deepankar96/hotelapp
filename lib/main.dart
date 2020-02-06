import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "air-bnb",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        accentColor: Colors.orangeAccent,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  
  SharedPreferences sharedPreferences;
  String username = "";
  File imageFile;

  _getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('token')??'');
    });
  }



  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _getUserName();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text("air-bnb", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orangeAccent,
      ),
      body:new Container(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            FlatButton(
              onPressed: () {
                
              },
              child: Text("Username: "+username),
              ),
            FlatButton(
              onPressed: () {
                _googleSignIn.signOut();
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
              },
              child: Text("Log Out",),
          ),
          ],
        ),
      ),
    );
  }
}
