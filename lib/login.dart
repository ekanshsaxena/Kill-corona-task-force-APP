import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:chitra_herbals/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String error = ' ';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal[100]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                  errorLine(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Image.asset('assets/images/chlogo.png'),
                  )
                ],
              ),
      ),
    );
  }

  signIn(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    print(data);
    // ignore: avoid_init_to_null
    var jsonResponse = null;
    var response = await http.post(
      Uri.encodeFull("http://chkctf.org/api/login"),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      //print(jsonResponse['token']);
      if (jsonResponse['active'] == 0) {
        setState(() {
          _isLoading = false;
          error = "Account suspended, Can't login!";
        });
      } else if (jsonResponse != null && jsonResponse['status'] == true) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString(
            "token", jsonResponse['user_id'].toString());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          error = "Credentials Incorrect";
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container errorLine() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        error,
        style: TextStyle(
          fontSize: 25,
          color: Colors.red,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("KILL CORONA TASK FORCE",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
