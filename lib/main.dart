import 'package:chitra_herbals/home/Home.dart';
import 'package:chitra_herbals/patientForm.dart';
import 'package:chitra_herbals/showPatients.dart';
import 'package:flutter/material.dart';
import 'package:chitra_herbals/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'dart:convert';
import 'dashboard_buttons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Code Land",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(accentColor: Colors.white70),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chitra Herbals", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              // ignore: deprecated_member_use
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover)),
            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text(
                "Add Patient",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PatientForm();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text(
                "Show Patients",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ShowPatients();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                "Log Out",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                sharedPreferences.clear();
                // ignore: deprecated_member_use
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      body: CoverPage(),
      /* new ListView(
        //shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                child: DashboardButton("Form", "assets/images/help.png"),
                height: 200.0,
                width: 200.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              SizedBox(
                child: DashboardButton("Profile", "assets/images/faq.jpeg"),
                height: 200.0,
                width: 200.0,
              )
            ],
          ),
        ],
      ), */
    );
  }
}
