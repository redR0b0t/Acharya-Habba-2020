import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habba20/models/user_model.dart';
import 'package:habba20/services/db_services.dart';
import 'package:habba20/utils/date_time_helper.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/failure_card.dart';
import 'package:habba20/widgets/loading.dart';
import 'package:habba20/widgets/success_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:habba20/data/data.dart';
import 'package:xlive_switch/xlive_switch.dart';
import 'package:habba20/widgets/profile_picture.dart';
import 'package:habba20/pages/pdf_save.dart';
import 'package:habba20/pages/apl_pdf.dart';
import 'package:habba20/widgets/generate pdf.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:habba20/services/mysql_service.dart';
import 'package:habba20/services/google_sigin_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AplSignUp extends StatefulWidget {
  @override
  _AplSignUpState createState() => _AplSignUpState();
}

class _AplSignUpState extends State<AplSignUp> {
  var _user = UserModel();
  List<String> collegeBranchList = ['Choose your Branch'];
  AplPdf aplPdf;
  int tym;
  bool _designationBool = true;
  String desig = "Faculty";

  TextEditingController _nameController,
      _whatsappNumberController,
      _auidController,
      _mailController;

  //sql.MySqlConnection _conn;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool checked = false;
  int state = 0;
  File _image;

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
        print("selected date=${selectedDate.toIso8601String()}");
      });

  }

  @override
  void initState() {
    super.initState();
    //_conn = await sql.MySqlConnection.connect(settings);
    _nameController = TextEditingController(text: name);
    _whatsappNumberController = TextEditingController();
    _auidController = TextEditingController();
    _mailController = TextEditingController(text: email);
  }

  Future _registerUser() async {
    _user.Desig = desig;


    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_user.Work == '' ||
          _image == null ||
          _user.College == ''
        //  _user.Branch == '' ||
        //  _user.Year == ''
          ) {
        Fluttertoast.showToast(
            msg: "Fill the complete form",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      setState(() {
        state = 1;
      });


      _user.Date = selectedDate.toIso8601String();
      print(_user.Date);

      if (await Provider.of<DatabaseService>(context)
          .regsiterApl(_user, _image)) {
        post_apl2(_user);
//          await save_mysql(_conn, _user);
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) =>
//                    Pdfsave(user: _user,img: _image))); //AplPdf(user: _user)));
//        aplPdf.save(_user);
        setState(() {
          state = 2;
        });
        //generatePDF(_user, _image);
      } else {
        setState(() {
          state = 3;
        });
      }
    }
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
          return Column(children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                child: Center(
                  child: SuccessCard(
                    title:
                        "The application is mailed to ${_user.Mail} check the spam section",
                  ),
                )),
//              Container(
//                  padding: EdgeInsets.symmetric(horizontal: 56, vertical: 2),
//                child: RaisedButton(
//                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                color: Colors.deepPurple,
//                onPressed: () {
//                  //generatePDF(_user, _image);
//                  post_apl(_user,_image);
//                },
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(30))),
//                child: Center(
//                  child: Text(
//                    'Save PDF',
//                    style: TextStyle(
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//              ))
          ]);
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
    return Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 60),
                Text(
                  "APL 2020",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                _image == null
                    ? RaisedButton(
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        onPressed: showImagePicker,
                        child: Text('Take your photo',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                      )
                    : Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(_image),
                          ),
                          Positioned(
                            height: 40,
                            width: 40,
                            bottom: 1,
                            right: 1,
                            child: FloatingActionButton(
                                child: Icon(Icons.edit),
                                onPressed: getImageFromCamera),
                          )
                        ],
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
                        } else if (value.length != 12 && value.length != 8) {
                          return 'Auid length is invalid';
                        } else if (!((value.contains('ai') ||
                            value.contains("AI")))) {
                          return "Invalid format";
                        } else if (!(value.contains(new RegExp(r'[0-9]'), 5) ||
                            value.contains(new RegExp(r'[0-9]'), 6))) {
                          return "invalid format";
                        }

//                        else if(!(value.replaceAll("\\D", "").length==5 || value.replaceAll("\\D", "").length==6)){
//                          return "Invalid format num ${value.replaceAll("\\D", "").length}";
//                        }
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
                        //enabled: false,
                      ),
                      //enabled: false,
                      //readOnly: true,
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
                          labelText: 'Phone Number',
                          hintText: 'Enter Your Phone Number '),
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
                    Visibility(
                      visible: !_designationBool,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Department",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: !_designationBool,
                      child: departmentSelector(),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Category",
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
        collegeBranchList = mapToList(branchMap(), selectedItem);
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
              setState(() {});
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
      itemsList: collegeBranchList,
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
              setState(() {});
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
//                  FloatingActionButton(
//                    child: Icon(Icons.image),
//                    onPressed: getImageFromGallery,
//                  ),
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
    //Navigator.of(context).pop();
  }

  List<String> mapToList(Map data, String index) {
    return data[index];
  }
}
