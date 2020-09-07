import 'package:chitra_herbals/showPatients_profile/NonCovidProfile.dart';
import 'package:flutter/material.dart';
import 'package:chitra_herbals/showPatients_profile/details.dart';

// ignore: must_be_immutable
class NonCovidInfo extends StatelessWidget {
  Map list;
  NonCovidInfo({this.list});
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
                            return NonCovidProfile(id: list['id']);
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
                              // Container(
                              //     width: 140,
                              //     height: 140,
                              //     child: Column(
                              //       children: <Widget>[
                              //         Padding(
                              //             padding: EdgeInsets.only(
                              //                 top: 10, right: 16)),
                              //         Container(
                              //           height: 40,
                              //           width: 120,
                              //           child: Card(
                              //             shape: new RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     new BorderRadius.circular(
                              //                         15.0)),
                              //             color: Colors.pink,
                              //             child: Center(
                              //               child: Text(
                              //                 list['date_negative'] == null
                              //                     ? 'Positive'
                              //                     : 'Negative',
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 13.0),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         Padding(
                              //             padding: EdgeInsets.only(top: 25)),
                              //         Container(
                              //           height: 40,
                              //           width: 120,
                              //           child: RaisedButton(
                              //               elevation: 10.0,
                              //               shape: new RoundedRectangleBorder(
                              //                   borderRadius:
                              //                       new BorderRadius.circular(
                              //                           15.0)),
                              //               color: Colors.green,
                              //               child: Text(
                              //                 'Mark Negative',
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 13.0),
                              //               ),
                              //               onPressed: () {
                              //                 return list['date_negative'] ==
                              //                         null
                              //                     ? _displayDialog(
                              //                         context, "Negative")
                              //                     : null;
                              //               }),
                              //         ),
                              //       ],
                              //     ))
                            ]))))));
  }
}
