/*Image*/
import 'dart:convert';
import 'dart:io';
import 'package:chitra_herbals/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PatientForm extends StatefulWidget {
  @override
  PatientFormState createState() {
    return PatientFormState();
  }
}

class PatientFormState extends State<PatientForm> {
  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController gender = new TextEditingController(text: "Male");
  TextEditingController mobile = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController given = new TextEditingController(text: "Yes");
  TextEditingController quantity = new TextEditingController();
  TextEditingController dynamite = new TextEditingController(text: "Yes");
  TextEditingController place =
      new TextEditingController(text: "Home Quarantine");
  TextEditingController address = new TextEditingController();
  TextEditingController other = new TextEditingController(text: "none");

  addData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_id = sharedPreferences.get('token');
    print(user_id);
    var url = "http://chitraherbals.in/api/create/patient";
    Map data = {
      "user_id": user_id,
      "fname": fname.text,
      "lname": lname.text,
      "gender": gender.text,
      "phone": mobile.text,
      "date_positive": date.text,
      "quarantine_place": place.text,
      "age": age.text,
      "given": given.text,
      "quantity": quantity.text,
      "address": address.text,
      "other": other.text,
      "dynamiteoil": dynamite.text,
    };
    //print(data);
    var jsonResponse = null;
    var response = await http.post(
      Uri.encodeFull(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      //print(jsonResponse['token']);
      if (jsonResponse != null && jsonResponse['status'] == true) {
        setState(() {
          error = jsonResponse['message'];
          _isLoading = false;
        });
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
      print(response.body);
    }
  }

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
  //image portion
  File _image;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        //print('Image Path $_image');
      });
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Form"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 30.0)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.black87,
                          child: ClipOval(
                            child: new SizedBox(
                                width: 155.0,
                                height: 155.0,
                                child: (_image != null)
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        "assets/images/unpic.png",
                                        fit: BoxFit.fill,
                                      )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.camera,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ),
                    ],
                  ),
                  //----------------------------image-------------------------
                  /* Container(
              width: 50,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ), */
                  //----------------------------First Name-----------------------
                  TextFormField(
                    //controller: fname,
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
                      if (value.length > 100) {
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
                      if (value.length > 100) {
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
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      hintText: 'Date of corona positive',
                      labelText: 'Date of corona positive',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
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

                  //************************Submit Button**************************
                  new Container(
                      padding: const EdgeInsets.only(
                          left: 110.0, right: 130.0, top: 40.0),
                      child: new RaisedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          // if (_formKey.currentState.validate() && _image != null) {
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (context) => MainPage()));
                          // }
                          if (_formKey.currentState.validate()) {
                            fname.text = first;
                            lname.text = last;
                            address.text = add;
                            // print(fname.text);
                            // print(lname.text);
                            // print(gender.text);
                            // print(mobile.text);
                            // print(age.text);
                            // print(date.text);
                            // print(given.text);
                            // print(quantity.text);
                            // print(dynamite.text);
                            // print(place.text);
                            // print(address.text);
                            // print(other.text);
                            setState(() {
                              _isLoading = true;
                            });
                            addData();
                          }
                        },
                      )),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
    );
  }
}
