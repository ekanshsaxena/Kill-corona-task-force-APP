import 'package:chitra_herbals/showPatients.dart';
import 'package:chitra_herbals/showPatients_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:chitra_herbals/showPatients_profile/details.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class InfoHolder extends StatelessWidget {
  Map list;
  InfoHolder({this.list});
  // ignore: slash_for_doc_comments
  /*************************************************************************Update Date_of_positive**********************************************/
  /* updateDateofPositive() async {
    var url = "http://chkctf.org/api/update/" + list['id'].toString();
    Map data = {"date_positive": date.text, "remarks": remarks.text};
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      print("alright");
    }
  } */

// ignore: slash_for_doc_comments
  /*************************************************************************Update Date_of_positive**********************************************/
  updateDateofNegative() async {
    var url = "http://chkctf.org/api/update/" + list['id'].toString();
    Map data = {"date_negative": date.text, "remarks": remarks.text};
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      print("alright");
    }
  }

  // ignore: slash_for_doc_comments
  /**************************************************************************alreat fun**********************************************/
  TextEditingController date = new TextEditingController();
  TextEditingController remarks = new TextEditingController();
  _displayDialog(BuildContext context, String type) async {
    date.text = "";
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Mark " + type),
            content: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    //controller: date,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'DDMMYYYY',
                      labelText: 'Date of negative',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length != 8) {
                        return "Incorrect Date";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      date.text = value;
                    },
                  ),
                  TextFormField(
                    //controller: date,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'remarks',
                      labelText: 'Remarks',
                    ),
                    onChanged: (value) {
                      remarks.text = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    /* if (type == "Positive") {
                      updateDateofPositive();
                    } else {
                      updateDateofNegative();
                    } */
                    updateDateofNegative();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
  // ignore: slash_for_doc_comments
  /*********************************************************************************************************************************/

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
            child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(15.0),
                    shadowColor: Color(0x802196F3),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            //print(doc);
                            return Profile(id: list['id']);
                          }));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                    minHeight: 0,
                                    maxHeight: 140,
                                    minWidth: 140,
                                    maxWidth: double.infinity),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 20),
                                  child: MyDetailsContainer(list),
                                ),
                              ),
                              Container(
                                  width: 140,
                                  height: 140,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, right: 16)),
                                      Container(
                                        height: 40,
                                        width: 120,
                                        child: Card(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0)),
                                          color: Colors.pink,
                                          child: Center(
                                            child: Text(
                                              list['date_negative'] == null
                                                  ? 'Positive'
                                                  : 'Negative',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 25)),
                                      Container(
                                        height: 40,
                                        width: 120,
                                        child: RaisedButton(
                                            elevation: 10.0,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        15.0)),
                                            color: Colors.green,
                                            child: Text(
                                              'Mark Negative',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0),
                                            ),
                                            onPressed: () {
                                              return list['date_negative'] ==
                                                      null
                                                  ? _displayDialog(
                                                      context, "Negative")
                                                  : null;
                                            }),
                                      ),
                                    ],
                                  ))
                            ]))))));
  }
}
