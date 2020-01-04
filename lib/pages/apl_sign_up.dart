import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:habba20/models/user_model.dart';
import 'package:habba20/utils/date_time_helper.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/failure_card.dart';
import 'package:habba20/widgets/loading.dart';
import 'package:habba20/widgets/success_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/pages/home.dart';
import 'package:xlive_switch/xlive_switch.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/widgets/profile_picture.dart';
import 'package:habba20/widgets/dp_edit.dart';

class AplSignUp extends StatefulWidget {
  @override
  _AplSignUpState createState() => _AplSignUpState();
}

class _AplSignUpState extends State<AplSignUp> {
  var _user = UserModel();
  int tym;
  bool _sexBool = true;
  bool _designationBool = true;
  String sex = "Male", desig = "Faculty";

  TextEditingController _nameController,
      _phoneNumberController,
      _whatsappNumberController,
      _auidController,
      _mailController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool checked = false;
  int state = 0;
  File _image;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  DatetimeHelper datetimeHelper;

  String date = "";

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 80),
        lastDate: DateTime(DateTime.now().year + 1));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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

    int tym = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      state =1;
    });
    try {
      if (_image != null) {

        StorageTaskSnapshot task = await _storage
            .ref()
            .child(_user.WhatsApp.toString() + '.jpg')
            .putFile(_image)
            .onComplete;
        _user.img = await task.ref.getDownloadURL();
        print("Iimage >>> >${_user.img}");
      }
      await Firestore.instance
          .collection('apl')
          .document(_user.Id)
          .setData(_user.getMap());
      setState(() {
        state = 2;
      });
    } catch (err) {
      print("Errrrr ${err}");
      setState(() {
        state = 3;
      });
    }

/*



    this._user.img = imgURL;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _user.Type = 0;
      setState(() {
        state = 1;
      });
      var documentReference =
          Firestore.instance.collection('apl').document(this._user.Id);

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          this._user.getMap(),
        );
      });

      setState(() {
        state = 2;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    tym = selectedDate.millisecondsSinceEpoch;
    datetimeHelper = DatetimeHelper(timestamp: tym);
    date = datetimeHelper.getDate();

    return Scaffold(
        backgroundColor: notWhite,
        body: SingleChildScrollView(child: getView()));
  }

  Widget getView() {
    switch (state) {
      case 0:
        {
          return form();
        }
      case 1:
        {
          return Container(
            height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
              child: Center(
                child: Loading(),
              ));
        }
      case 2:
        {
          return Container(
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
              child: Center(
                child: SuccessCard(),
              ));
        }
      case 3:
        {
          return Container(
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
              child: Center(
                child: FailureCard(),
              ));
        }
    }
  }

  Widget form() {
    DpEdit dp = DpEdit();
    return Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Stack(
                  children: <Widget>[
                    _image == null
                        ? ProfilePicture(
                      name: "Acharya",
                      imagePath: "",
                      size: 70,
                    )
                        : CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(_image),
                    ),
                    Positioned(
                      height: 40,
                      width: 40,
                      bottom: 1,
                      right: 1,
                      child: FloatingActionButton(
                          child: Icon(Icons.edit), onPressed: showImagePicker),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  "APL 2020",
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
                        } else if (value.length > 31) {
                          return 'Name should be less than 30 words';
                        }

                        return null;
                      },
                      onSaved: (val) {
                        this._user.Name = val.toUpperCase().trim();
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
                        labelText: 'Auid / Eid',
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
                        this._user.Id = val.toUpperCase().trim();
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
                        } else if (value.contains("@acharya.ac.in")) {
                          //this._user.Type=1;

                        } else {
                          //this._user.Type=2;
                          return "Only @acharya ID are allowed";
                        }

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Whatsapp Number',
                          hintText: 'Enter Your Phone Number'),
                      validator: (val) {
                        if (_whatsappNumberController.text.isEmpty) {
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
                    /*TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
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
                    ),*/

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () => _selectDate(context),
                      child: Text('${date}',
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Designation",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        XlivSwitch(
                          /// designation
                          value: _designationBool,
                          onChanged: _changeDesignation,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${desig}",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sex",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        XlivSwitch(
                          /// sex
                          value: _sexBool,
                          onChanged: _changeSex,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${sex}",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "College",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    collegeSelector(),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Department",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    departmentSelector(),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Catagory",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    catagorySelector(),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      elevation: 25,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      //color: AppTheme.primaryBtnColor,
                      color: Colors.deepPurple,
                      onPressed: () {
                        // continueTap();
                        _registerUser();
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                )
              ]),
        ));
  }




  void _changeDesignation(bool value) {
    setState(() {
      _designationBool = value;
      if (value == true) {
        desig = "Faculty";
      } else {
        desig = "Student";
      }
    });
  }

  void _changeSex(bool value) {
    setState(() {
      _sexBool = value;
      if (value == true) {
        sex = "Male";
      } else {
        sex = "Female";
      }
    });
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
        this._user.College = selectedItem;
        //widget.user.Institution = selectedItem;
      },
      itemBuilder:
          (BuildContext context, String item, OnItemTapped onItemTapped) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.5),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            //color: AppTheme.primaryBtnColor,
            color: Colors.deepOrange,
            onPressed: () {
              onItemTapped();
              //_registerUser();
            },
            child: Text(
              '${item}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
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
        minHeightFraction: 0.65,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
      ),
      showSelectedItemAsTrigger: true,
      initiallySelectedItemIndex: 0,
      itemsList: departmentList,
      onItemSelected: (String selectedItem) {
        this._user.Branch = selectedItem;
      },
      itemBuilder:
          (BuildContext context, String item, OnItemTapped onItemTapped) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.5),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            //color: AppTheme.primaryBtnColor,
            color: Colors.deepOrange,
            onPressed: () {
              onItemTapped();
              //_registerUser();
            },
            child: Text(
              '${item}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget catagorySelector() {
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
      itemsList: aplCatagoryList,
      onItemSelected: (String selectedItem) {
        this._user.Work = selectedItem;
      },
      itemBuilder:
          (BuildContext context, String item, OnItemTapped onItemTapped) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.5),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            //color: AppTheme.primaryBtnColor,
            color: Colors.deepOrange,
            onPressed: () {
              onItemTapped();
              //_registerUser();
            },
            child: Text(
              '${item}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }


  /// IMage picker >>>>>>

  void showImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.image),
                    onPressed: getImageFromGallery,
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.camera), onPressed: getImageFromCamera)
                ],
              ),
            ),
          );
        });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 60);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future<bool> updateProfileImage(File _img) async {
    String ts=DateTime.now().millisecondsSinceEpoch.toString();
    String dURL;
    StorageTaskSnapshot task = await _storage
        .ref()
        .child(ts + '.jpg')
        .putFile(_img)
        .onComplete;
    dURL= await task.ref.getDownloadURL();
    imgURL=dURL;

    return true;
  }


}
