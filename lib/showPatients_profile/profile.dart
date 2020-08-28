import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: missing_return
Future<Map> getPatientData(int id) async {
  final response =
      await http.get("http://chkctf.org/api/patient/" + id.toString());
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
}

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  int id;
  Profile({this.id});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Map> futuregetPatientData;
  @override
  void initState() {
    super.initState();
    futuregetPatientData = getPatientData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Patients List"),
      ),
      body: FutureBuilder<Map>(
          future: futuregetPatientData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("error");
            }
            if (snapshot.hasData || snapshot.data != null) {
              //print("enter");
              return CardSection(mp: snapshot.data);
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
class CardSection extends StatelessWidget {
  Map mp;
  CardSection({this.mp});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
