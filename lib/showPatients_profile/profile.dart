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
    // print(mp['patient']['fname']);
    // print(mp['patient']['lname']);
    // print(mp['patient']['gender']);
    // print(mp['patient']['age']);
    // print(mp['patient']['phone']);
    // print(mp['patient']['date_positive']);
    // print(mp['patient']['address']);
    // print(mp['patient']['quarantine_place']);
    // print(mp['patient']['remarks']);
    // print(mp['patient']['given']);
    // print(mp['patient']['quantity'].toString());
    // print(mp['patient']['dynamiteoil']);
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
                        fontSize: 25,
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
                      Text("Patient Name: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                          mp['patient']['fname'] + " " + mp['patient']['lname'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //-----------------------------------------------------GENDER----------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Gender: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['gender'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //-------------------------------------------------------AGE-----------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Age: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['age'].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //------------------------------------------------------PHONE----------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Phone: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['phone'].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //------------------------------------------------------DATE OF POSITIVE------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Date of Positive: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['date_positive'].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //------------------------------------------------------QUARANTINE PLACE-----------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Quarantine Place: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['quarantine_place'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //------------------------------------------------------ADDRESS--------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Address: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['address'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //------------------------------------------------------REMARKS--------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Remarks: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                          mp['patient']['remarks'] == null
                              ? "none"
                              : mp['patient']['remarks'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //---------------------------------------------------------SUPER SANJEEVNI----------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Super Sanjeevini Given: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['given'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //-----------------------------------------------------QUANTITY---------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Quantity of Super Sanjeevini: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['quantity'].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //------------------------------------------------------DYNAMITE--------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Dynamite Oil Given: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.w600,
                          )),
                      Text(mp['patient']['dynamiteoil'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(57, 80, 118, 1),
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                //----------------------------------------------------Buttons---------------------------------------------
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       ListTile(
                //         //color: Color.fromRGBO(217, 37, 80, 1),
                //         title: Text(
                //           "View Aadhar Card",
                //           style: TextStyle(
                //               fontSize: 25,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w300),
                //         ),
                //         onTap: () {},
                //       ),
                //       ListTile(
                //         //color: Color.fromRGBO(217, 37, 80, 1),
                //         title: Text(
                //           "View Aadhar Card",
                //           style: TextStyle(
                //               fontSize: 25,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w300),
                //         ),
                //         onTap: () {},
                //       ),
                //     ],
                //   ),
                // ),
                //--------------------------------------------------------------------------------------------------------
              ],
            ),
          ),
        ),
      ],
    );
  }
}
