import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:habba20/models/user_model.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:habba20/pages/home.dart';

class VolunteerSignUp extends StatefulWidget {
  @override
  _VolunteerSignUpState createState() => _VolunteerSignUpState();
}

class _VolunteerSignUpState extends State<VolunteerSignUp> {
  var _user=UserModel();

  TextEditingController _nameController,
      _phoneNumberController,
      _whatsappNumberController,
      _auidController,
      _mailController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool checked = false;

  List<String> collegeList = ["graduat", "AIt"];
  List<String> departmentList = ["Ise", "Cse"];
  List<String> yearList = ["1", "2"];
  List<String> workList = [
    "Organizing and coordination",
        "Digital design(animation,poster making,etc)",
        "Design and decoration",
        "Marketing and Sponsorship",
        "Production Team ( Photography, Videography, editing, content creation and content writing)"
  ];

  String college, department, year, work;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _whatsappNumberController = TextEditingController();
    _auidController = TextEditingController();
    _mailController = TextEditingController();
  }
  Future _registerUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _user.Type = 0;
     // print('Name : ${this._user.Name} Phone : ${_user.PhoneNumber}');
      var documentReference = Firestore.instance
          .collection('users')
          .document(this._user.Id);


      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,

          this._user.getMap()

          ,
        );
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title:'Welcome')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: notWhite,
        //backgroundColor: Colors.deepPurple,
        // backgroundColor: Colors.white30,
        //backgroundColor: Colors.grey[50],
        //backgroundColor: Color(0xFF8185E2).withOpacity(50),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AvatarGlow(
                          endRadius: 90,
                          duration: Duration(seconds: 2),
                          glowColor: Colors.white24,
                          repeat: true,
                          repeatPauseDuration: Duration(seconds: 2),
                          startDelay: Duration(seconds: 1),
                          child: Material(
                              elevation: 8.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: Image.asset("assets/xpaw.png"),
                                radius: 50.0,
                              )),
                        ),
                        Text(
                          "Habba 2020",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Name',
                                hintText: 'Enter Your Name',
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter Your Name';
                                } else if (value.length > 16) {
                                  return 'Name should be less than 15 words';
                                }

                                return null;
                              },
                              onSaved: (val) {
                                this._user.Name = val.toUpperCase();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _auidController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                prefixIcon: Icon(Icons.security),
                                labelText: 'Auid',
                                hintText: 'AIT18BEIS109',
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter Your Auid';
                                } else if (value.length != 12) {
                                  return 'Auid should be  of 12 words';
                                }

                                return null;
                              },
                              onSaved: (val) {
                                this._user.Id = val.toUpperCase();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _mailController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Email',
                                hintText: 'Enter Your Email',
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter Your Email';
                                }
                                else{}

                                return null;
                              },
                              onSaved: (val) {
                                this._user.Mail = val;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _whatsappNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Icon(Icons.phone),
                                  labelText: 'Whatsapp Number',
                                  hintText: 'Enter Your Phone Number'),
                              validator: (val) {
                                if (_phoneNumberController.text.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                this._user.WhatsApp = val.toUpperCase();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Icon(Icons.phone),
                                  labelText: 'Alternate Number',
                                  hintText: 'Enter Your Phone Number'),
                              validator: (val) {
                                if (_phoneNumberController.text.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                this._user.PhoneNumber = val.toUpperCase();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            collegeSelector(),
                            departmentSelector(),
                            yearSelector(),
                            volunteerWorkSelector(),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 12),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              //color: AppTheme.primaryBtnColor,
                              color: Colors.deepPurple,
                              onPressed: () {
                                // continueTap();
                                _registerUser();
                              },
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]),
                        )
                      ]),
                ))));
  }

  Widget collegeSelector() {
    return SelectionMenu<String>(
      menuSizeConfiguration: MenuSizeConfiguration(
        maxHeightFraction: 0.75,
        // maxWidthFraction, minWidthFraction, minHeightFraction are similar.
        maxWidthFraction: 0.8,
        minWidthFraction: 0.8,
        minHeightFraction: 0.45,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
      ),
      showSelectedItemAsTrigger: true,
      initiallySelectedItemIndex: 0,
      itemsList: collegeList,
      onItemSelected: (String selectedItem) {
        college = selectedItem;
        //widget.user.Institution = selectedItem;
      },
      itemBuilder:
          (BuildContext context, String item, OnItemTapped onItemTapped) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          //color: AppTheme.primaryBtnColor,
          color: Colors.deepOrange,
          onPressed: () {
            onItemTapped();
            //_registerUser();
          },
          child: Text(
            '${item}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget departmentSelector() {
    return SelectionMenu<String>(
      menuSizeConfiguration: MenuSizeConfiguration(
        maxHeightFraction: 0.75,
        // maxWidthFraction, minWidthFraction, minHeightFraction are similar.
        maxWidthFraction: 0.8,
        minWidthFraction: 0.8,
        minHeightFraction: 0.45,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
      ),
      showSelectedItemAsTrigger: true,
      initiallySelectedItemIndex: 0,
      itemsList: departmentList,
      onItemSelected: (String selectedItem) {
        department = selectedItem;
      },
      itemBuilder:
          (BuildContext context, String item, OnItemTapped onItemTapped) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          //color: AppTheme.primaryBtnColor,
          color: Colors.deepOrange,
          onPressed: () {
            onItemTapped();
            //_registerUser();
          },
          child: Text(
            '${item}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget yearSelector() {
    return SelectionMenu<String>(
      menuSizeConfiguration: MenuSizeConfiguration(
        maxHeightFraction: 0.75,
        // maxWidthFraction, minWidthFraction, minHeightFraction are similar.
        maxWidthFraction: 0.8,
        minWidthFraction: 0.8,
        minHeightFraction: 0.45,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
      ),
      showSelectedItemAsTrigger: true,
      initiallySelectedItemIndex: 0,
      itemsList: yearList,
      onItemSelected: (String selectedItem) {
        year = selectedItem;
      },
      itemBuilder:
          (BuildContext context, String item, OnItemTapped onItemTapped) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          //color: AppTheme.primaryBtnColor,
          color: Colors.deepOrange,
          onPressed: () {
            onItemTapped();
            //_registerUser();
          },
          child: Text(
            '${item}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget volunteerWorkSelector() {
    return SelectionMenu<String>(
      menuSizeConfiguration: MenuSizeConfiguration(
        maxHeightFraction: 0.75,
        // maxWidthFraction, minWidthFraction, minHeightFraction are similar.
        maxWidthFraction: 0.8,
        minWidthFraction: 0.8,
        minHeightFraction: 0.45,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
      ),
      showSelectedItemAsTrigger: true,
      initiallySelectedItemIndex: 0,
      itemsList: workList,
      onItemSelected: (String selectedItem) {
        work = selectedItem;
      },
      itemBuilder:
          (BuildContext context, String item, OnItemTapped onItemTapped) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          //color: AppTheme.primaryBtnColor,
          color: Colors.deepOrange,
          onPressed: () {
            onItemTapped();
            //_registerUser();
          },
          child: Text(
            '${item}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
