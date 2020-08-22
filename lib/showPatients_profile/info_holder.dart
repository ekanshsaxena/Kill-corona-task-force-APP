import 'package:chitra_herbals/showPatients.dart';
import 'package:flutter/material.dart';
import 'package:chitra_herbals/showPatients_profile/details.dart';

// ignore: must_be_immutable
class InfoHolder extends StatelessWidget {
  Map list;

  InfoHolder({this.list});

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
                            return ShowPatients();
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
                                    maxWidth: 220),
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
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0)),
                                          color: Colors.pink,
                                          child: Text(
                                            'Positive',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.0),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 25)),
                                      Container(
                                        height: 40,
                                        width: 120,
                                        child: RaisedButton(
                                          elevation: 5.0,
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
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ))
                            ]))))));
  }
}
