import 'dart:convert';

import 'package:chitra_herbals/main.dart';
import 'package:chitra_herbals/showPatients_profile/info_holder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: missing_return
Future<List> getData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user = sharedPreferences.get('token');
  final response = await http.get("http://chkctf.org/api/patients/" + user);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
}

class ShowPatients extends StatefulWidget {
  @override
  _ShowPatientsState createState() => _ShowPatientsState();
}

class _ShowPatientsState extends State<ShowPatients> {
  Future<List> futuregetData;
  @override
  void initState() {
    super.initState();
    futuregetData = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Patients List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            return Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return MainPage();
            }), (route) => false);
          },
        ),
      ),
      body: FutureBuilder<List>(
          future: futuregetData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("error");
            }
            if (snapshot.hasData || snapshot.data != null) {
              //print("enter");
              return Items(list: snapshot.data);
            } else {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ));
            }
          }),
    );
  }
}

// ignore: must_be_immutable
class Items extends StatelessWidget {
  List list;
  Items({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        Map listData = list[index];
        return InfoHolder(list: listData);
      },
    );
  }
}
