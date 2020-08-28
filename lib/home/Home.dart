import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: missing_return
Future<Map> getInfo() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user = sharedPreferences.get('token');
  final response = await http.get("http://chkctf.org/api/user/" + user);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
}

class CoverPage extends StatefulWidget {
  @override
  _CoverPageState createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> {
  Future<Map> futuregetInfo;
  @override
  void initState() {
    super.initState();
    futuregetInfo = getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: futuregetInfo,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error");
          }
          if (snapshot.hasData || snapshot.data != null) {
            //print("enter");
            return DetailPage(list: snapshot.data);
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  Map list;
  DetailPage({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 60)),
        Container(
          height: 100,
          width: 250,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Color.fromRGBO(57, 80, 118, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Total Patients you Created",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    list['total'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //----------------------------------------------------------
        Padding(padding: EdgeInsets.only(top: 40)),
        Container(
          height: 100,
          width: 250,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Color.fromRGBO(45, 179, 130, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Cured Patients",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    list['cured'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //---------------------------------------------------------------
        Padding(padding: EdgeInsets.only(top: 40)),
        Container(
          height: 100,
          width: 250,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Color.fromRGBO(217, 37, 80, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Active Patients",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    list['active'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
