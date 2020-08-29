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
        title: Text("Patient Detail"),
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
    return new ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 10, right: 10, top: 40),
      children: <Widget>[
        Container(
          //padding: EdgeInsets.only(left: 20, right: 20),
          color: Colors.blue,
          child: Card(
            elevation: 15.0,
            child: Column(
              children: <Widget>[
                //----------------------------------------------------HEADER-----------------------------------------------------
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Patient Details",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 22,
                        color: Color.fromRGBO(57, 80, 118, 1),
                        fontWeight: FontWeight.w700),
                  ),
                ),
                //----------------------------------------------------PATIENT NAME----------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Patient Name: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(
                            mp['patient']['fname'] +
                                " " +
                                mp['patient']['lname'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //-----------------------------------------------------GENDER----------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Gender: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['gender'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //-------------------------------------------------------AGE-----------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Age: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['age'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //------------------------------------------------------PHONE----------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Phone: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['phone'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //------------------------------------------------------DATE OF POSITIVE------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Date of Positive: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['date_positive'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //-----------------------------------------------------QUARANTINE PLACE-----------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Quarantine Place: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['quarantine_place'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //------------------------------------------------------ADDRESS--------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Address: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['address'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //------------------------------------------------------REMARKS--------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Remarks: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(
                            mp['patient']['remarks'] == null
                                ? "none"
                                : mp['patient']['remarks'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //---------------------------------------------------------SUPER SANJEEVNI----------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Super Sanjeevini Given: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['given'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //-----------------------------------------------------QUANTITY---------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Quantity of Super Sanjeevini: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['quantity'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //------------------------------------------------------DYNAMITE--------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Dynamite Oil Given: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Flexible(
                        child: Text(mp['patient']['dynamiteoil'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(57, 80, 118, 1),
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                //----------------------------------------------------Buttons---------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 40),
                          child: RaisedButton(
                            elevation: 8.0,
                            color: Color.fromRGBO(217, 37, 80, 1),
                            child: Text(
                              "Aadhar",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => AadharImageDialog(
                                        mp: mp,
                                      ));
                            },
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 40),
                          child: RaisedButton(
                            elevation: 8.0,
                            color: Color.fromRGBO(217, 37, 80, 1),
                            child: Text(
                              "Report",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => ReportImageDialog(
                                        mp: mp,
                                      ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //--------------------------------------------------------------------------------------------------------
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AadharImageDialog extends StatelessWidget {
  Map mp;
  AadharImageDialog({this.mp});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: mp['patient']['adhar'] == null
                    ? AssetImage('assets/images/no_img.jpg')
                    : NetworkImage("http://chkctf.org/asset/documents/adhar/" +
                        mp['patient']['adhar']),
                fit: BoxFit.contain)),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReportImageDialog extends StatelessWidget {
  Map mp;
  ReportImageDialog({this.mp});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: mp['patient']['report'] == null
                    ? AssetImage('assets/images/no_img.jpg')
                    : NetworkImage("http://chkctf.org/asset/report/" +
                        mp['patient']['report']),
                fit: BoxFit.contain)),
      ),
    );
  }
}
