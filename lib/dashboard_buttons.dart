import 'package:chitra_herbals/main.dart';
import 'package:chitra_herbals/patientForm.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class DashboardButton extends StatelessWidget {
  String _name;
  String _img;
  DashboardButton(this._name, this._img);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
            //color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: InkWell(
                onTap: () {
                  Toast.show(_name + " Tapped", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  // ignore: missing_return
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (_name == "Form") {
                      return PatientForm();
                    } else if (_name == "Profile") {
                      return MainPage();
                    }
                  }));
                },
                borderRadius: BorderRadius.circular(24.0),
                //child:Center(
                child: FittedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Image.asset(
                          _img,
                          fit: BoxFit.scaleDown,
                        )),
                    Container(
                        child: Text(
                      _name.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 60),
                    )),
                  ],
                  //),
                )))));
  }
}
