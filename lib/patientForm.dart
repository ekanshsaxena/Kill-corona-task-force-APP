/*Image*/
import 'dart:convert';
import 'dart:io';
import 'package:chitra_herbals/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientForm extends StatefulWidget {
  @override
  PatientFormState createState() {
    return PatientFormState();
  }
}

class PatientFormState extends State<PatientForm> {
  // ignore: slash_for_doc_comments
  /*********************************************************SET CONTROLLERS*********************************************************/
  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController gender = new TextEditingController(text: "Male");
  TextEditingController mobile = new TextEditingController(text: "");
  TextEditingController age = new TextEditingController(text: "");
  TextEditingController date = new TextEditingController();
  TextEditingController given = new TextEditingController(text: "Yes");
  TextEditingController quantity = new TextEditingController();
  TextEditingController dynamite = new TextEditingController(text: "Yes");
  TextEditingController place =
      new TextEditingController(text: "Home Quarantine");
  TextEditingController address = new TextEditingController();
  TextEditingController other = new TextEditingController();
  // ignore: slash_for_doc_comments
  /*********************************************************ADD DATA FUNCTION*********************************************************/
  addData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    var user_id = sharedPreferences.get('token');
    var url = "http://chkctf.org/api/create/patient";
    Dio dio = new Dio();
    String filename1 = _aadhar == null ? " " : _aadhar.path.split('/').last;
    String filename2 = _report == null ? " " : _report.path.split('/').last;
    FormData formData = new FormData.fromMap({
      "user_id": user_id,
      "fname": fname.text,
      "lname": lname.text,
      "gender": gender.text,
      "mobile": mobile.text,
      "adhar": _aadhar == null
          ? ""
          : await MultipartFile.fromFile(_aadhar.path,
              filename: filename1,
              contentType: MediaType('image', "png/jpeg/jpg")),
      "report": _report == null
          ? ""
          : await MultipartFile.fromFile(_report.path,
              filename: filename2,
              contentType: MediaType('image', "png/jpeg/jpg")),
      "date_positive": date.text,
      "quarantine_place": place.text,
      "age": age.text,
      "given": given.text,
      "quantity": quantity.text,
      "address": address.text,
      "other": other.text,
      "dynamiteoil": dynamite.text,
    });
    // ignore: avoid_init_to_null
    var jsonResponse = null;
    Response response = await dio.post(url, data: formData);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.toString());
      if (jsonResponse != null && jsonResponse['status'] == true) {
        setState(() {
          error = jsonResponse['message'];
          _isLoading = false;
        });
        //Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        setState(() {
          error = "Error Occured";
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.toString());
    }
  }

  // ignore: slash_for_doc_comments
  /*********************************************************DECLARE VARIABLES*********************************************************/
  final _formKey = GlobalKey<FormState>();
  //text field state
  String error = '';
  String first = '';
  String last = '';
  String add = '';
  bool _isLoading = false;
  //options
  String _valueGender = "Male";
  Map genderOptions = {1: "Male", 2: "Female", 3: "Other"};
  String _valueGiven = "Yes";
  String _valueDynamite = "Yes";
  String _valuePlace = "Home Quarantine";
  Map placeOptions = {
    1: "Home Quarantine",
    2: "Hospital Quarantine",
    3: "Government Place Quarantine",
    4: "Other"
  };
  String statusAadhar = "No file Choosen";
  String statusReport = "No file Choosen";
  // ignore: unused_field
  File _aadhar;
  // ignore: unused_field
  File _report;
  //String base64Aadhar = "";
  //String base64Report = "";
  // ignore: slash_for_doc_comments
  /*********************************************************WIDGET STARTS*********************************************************/
  @override
  Widget build(BuildContext context) {
    Future chooseAadhar() async {
      // ignore: deprecated_member_use
      var img = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _aadhar = img;
        statusAadhar = "File Choosen";
      });
    }

    Future chooseReport() async {
      // ignore: deprecated_member_use
      var img = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _report = img;
        statusReport = "File Choosen";
      });
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Form"),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: <Widget>[
                  SizedBox(height: 30.0),
                  //----------------------------First Name-----------------------
                  TextFormField(
                    initialValue: first,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length > 20) {
                        return 'Cross maximum character limit';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        first = value;
                      });
                    },
                  ),
                  //----------------------------Last Name-----------------------
                  TextFormField(
                    //controller: lname,
                    initialValue: last,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length > 20) {
                        return 'Cross maximum character limit';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        last = value;
                      });
                    },
                  ),
                  //-------------------------------Gender-----------------------
                  DropDownFormField(
                    titleText: "Gender",
                    hintText: "Gender",
                    value: _valueGender,
                    onSaved: (value) {
                      setState(() {
                        _valueGender = value;
                        gender.text = _valueGender;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _valueGender = value;
                        gender.text = _valueGender;
                      });
                    },
                    dataSource: [
                      {
                        "display": genderOptions[1],
                        "value": genderOptions[1],
                      },
                      {
                        "display": genderOptions[2],
                        "value": genderOptions[2],
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value != "Male" && value != "Female") {
                        return 'Please select your Gender';
                      }
                      return null;
                    },
                  ),
                  //-------------------------------Phone------------------------
                  TextFormField(
                    //controller: mobile,
                    initialValue: mobile.text,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                      labelText: 'Phone',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid phone number';
                      }
                      if (value.length != 10) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        mobile.text = value;
                      });
                    },
                  ),
                  //--------------------------------Age--------------------------
                  TextFormField(
                    //controller: age,
                    initialValue: age.text,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                      labelText: 'Age',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid age';
                      }
                      if (value.length < 1 || value.length > 150) {
                        return 'Please enter valid age';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        age.text = value;
                      });
                    },
                  ),
                  //---------------------Date of corona positive-------------------
                  TextFormField(
                    //controller: date,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'DDMMYYYY',
                      labelText: 'Date of corona positive',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length != 8) {
                        return 'Please enter valid Date';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        date.text = value;
                      });
                    },
                  ),
                  //----------------------------given------------------------------
                  Padding(padding: EdgeInsets.only(top: 5)),
                  DropDownFormField(
                    titleText: "Super Sanjeevni Given",
                    hintText: "Super Sanjeevni Given",
                    value: _valueGiven,
                    onSaved: (value) {
                      setState(() {
                        _valueGiven = value;
                        given.text = _valueGiven;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _valueGiven = value;
                        given.text = _valueGiven;
                      });
                    },
                    dataSource: [
                      {
                        "display": "Yes",
                        "value": "Yes",
                      },
                      {
                        "display": "No",
                        "value": "No",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select any Option';
                      }
                      return null;
                    },
                  ),
                  //----------------------------quantity---------------------------
                  TextFormField(
                    //controller: quantity,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Super Sanjeevni Quantity',
                      labelText: 'Super Sanjeevni Quantity',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Quantity';
                      }
                      if (value.length < 0) {
                        return 'Please enter valid Quantity';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        quantity.text = value;
                      });
                    },
                  ),
                  //----------------------------dynamite---------------------------
                  Padding(padding: EdgeInsets.only(top: 5)),
                  DropDownFormField(
                    titleText: "Dynamite Oil Given",
                    hintText: "Dynamite Oil Given",
                    value: _valueDynamite,
                    onSaved: (value) {
                      setState(() {
                        _valueDynamite = value;
                        dynamite.text = _valueDynamite;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _valueDynamite = value;
                        dynamite.text = _valueDynamite;
                      });
                    },
                    dataSource: [
                      {
                        "display": "Yes",
                        "value": "Yes",
                      },
                      {
                        "display": "No",
                        "value": "No",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select an Option';
                      }
                      return null;
                    },
                  ),
                  //----------------------------Place of Quarantine----------------
                  Padding(padding: EdgeInsets.only(top: 5)),
                  DropDownFormField(
                    titleText: "Place of Quarantine",
                    hintText: "Place of Quarantine",
                    value: _valuePlace,
                    onSaved: (value) {
                      setState(() {
                        _valuePlace = value;
                        place.text = _valuePlace;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _valuePlace = value;
                        place.text = _valuePlace;
                      });
                    },
                    dataSource: [
                      {
                        "display": placeOptions[1],
                        "value": placeOptions[1],
                      },
                      {
                        "display": placeOptions[2],
                        "value": placeOptions[2],
                      },
                      {
                        "display": placeOptions[3],
                        "value": placeOptions[3],
                      },
                      {
                        "display": placeOptions[4],
                        "value": placeOptions[4],
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select an Option';
                      }
                      return null;
                    },
                  ),
                  //----------------------------Address----------------------------
                  TextFormField(
                    //controller: address,
                    initialValue: add,
                    decoration: const InputDecoration(
                      hintText: 'Address',
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length > 2000) {
                        return 'Please enter valid address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        add = value;
                      });
                    },
                  ),
                  //----------------------------Other------------------------------
                  TextFormField(
                    //controller: other,
                    initialValue: other.text,
                    decoration: const InputDecoration(
                      hintText: 'Other',
                      labelText: 'Other',
                    ),
                    validator: (value) {
                      if (value.length > 5000) {
                        return 'Please enter valid address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        other.text = value;
                      });
                    },
                  ),
                  //------------------------Aadhar---------------------------------
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    statusAadhar,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  OutlineButton(
                    onPressed: () {
                      chooseAadhar();
                    },
                    child: Text("Upload Aadhar"),
                  ),
                  //------------------------Report---------------------------------
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    statusReport,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  OutlineButton(
                    onPressed: () {
                      chooseReport();
                    },
                    child: Text("Upload Report"),
                  ),
                  //************************Submit Button**************************
                  new Container(
                      padding: const EdgeInsets.only(
                          left: 110.0, right: 130.0, top: 10.0),
                      child: new RaisedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            fname.text = first;
                            lname.text = last;
                            address.text = add;
                            if (other.text == null) {
                              other.text = "none";
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            addData();
                          }
                        },
                      )),
                  SizedBox(height: 12.0),
                  Center(
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.green, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
