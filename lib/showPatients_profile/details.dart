import 'package:flutter/material.dart';

class MyDetailsContainer extends StatelessWidget {
  Map list;
  MyDetailsContainer(this.list);
  double fontsize = 25;
  @override
  Widget build(BuildContext context) {
    if (list['fname'].length > 20) {
      fontsize = 20;
    }
    return Container(
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
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Container(
                  child: Text(
                list['fname'],
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: fontsize,
                    fontWeight: FontWeight.normal),
              )),
            ),
          ]),
    );
  }
}
