import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDetailsContainer extends StatelessWidget {
  Map list;
  MyDetailsContainer(this.list);
  double fontsize = 20;
  @override
  Widget build(BuildContext context) {
    if (list['fname'].length > 20) {
      fontsize = 17;
    }
    double c_width = MediaQuery.of(context).size.width * 0.5;
    return Container(
      width: c_width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Container(
                  child: Text(
                "#" + list['patient_id'],
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 5),
              child: Container(
                  child: Text(
                list['fname'] + " ." + list['lname'][0],
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: fontsize,
                  fontWeight: FontWeight.normal,
                ),
              )),
            ),
          ]),
    );
  }
}
