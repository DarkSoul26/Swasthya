import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:swasthyaprofile/pages/Alldone.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  final dateController = TextEditingController();

  String firstName = "";
  String lastName = "";
  String gender = "";
  String bloodgroup = "";

  List<String> bg = [];

  String mobile = "";
  String pin = "";
  final format = DateFormat("dd-MM-yyyy");
  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tell us about yourself',
            style: TextStyle(
                fontSize: 20,
                color: Colors.purple,
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllDone()),
              );
            },
          ),
        ),
        body: Column(
          children: [
            ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: Colors.white,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10),
                                  )
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: new AssetImage(
                                      'assets/images/sanchit2.0.png'),
                                  fit: BoxFit.cover,
                                ))),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.purple,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      'date': DateTime.now(),
                    },
                    autovalidateMode: AutovalidateMode.always,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FormBuilderTextField(
                                name: 'First Name',
                                style: Theme.of(context).textTheme.body1,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                decoration: InputDecoration(labelText: "First Name"),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              width: 150,
                              child: FormBuilderTextField(
                                name: 'Last Name',
                                style: Theme.of(context).textTheme.body1,
                                //no validator req
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FormBuilderDropdown(
                                name: "Gender",
                                style: Theme.of(context).textTheme.body1,
                                decoration:
                                    InputDecoration(labelText: "Gender"),
                                hint: Text('Others'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                items: ['Male', 'Female', 'Others']
                                    .map((gender) => DropdownMenuItem(
                                        value: gender, child: Text("$gender")))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: FormBuilderDateTimePicker(
                                  name: "Date of Birth",
                                  style: Theme.of(context).textTheme.body1,
                                  inputType: InputType.date,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context)
                                  ]),
                                  format: DateFormat("dd-MM-yyyy"),
                                  decoration: InputDecoration(
                                      labelText: "Date of Birth"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormBuilderTextField(
                          name: 'Phone number',
                          decoration:
                              InputDecoration(labelText: 'Phone number'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context,
                                errorText: 'Incorrect Phone Number!'),
                            (val) {
                              if (val!.length != 10)
                                return 'Enter a 10 digit phone number!';
                              return null;
                            }
                          ]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FormBuilderTextField(
                                name: 'Pincode',
                                decoration:
                                    InputDecoration(labelText: 'Pincode'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context,
                                      errorText: 'Incorrect Pincode!'),
                                  (val) {
                                    if (val!.length != 6)
                                      return 'Enter a 6 digit pincode!';
                                    return null;
                                  }
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              width: 150,
                              child: FormBuilderDropdown(
                                name: "BloodGroup",
                                style: Theme.of(context).textTheme.body1,
                                decoration:
                                    InputDecoration(labelText: "Blood Group"),
                                hint: Text('Select one'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                items: [
                                  'A+',
                                  'A-',
                                  'B+',
                                  'B-',
                                  'AB-',
                                  'AB+',
                                  'O+',
                                  'O-'
                                ]
                                    .map((bloodgroup) => DropdownMenuItem(
                                        value: bloodgroup,
                                        child: Text("$bloodgroup")))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormBuilderCheckboxGroup(
                          decoration: InputDecoration(
                            labelText: "Any type of allergies?",
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                          name: "Allergies",
                          initialValue: ["None"],
                          options: [
                            FormBuilderFieldOption(value: 'Cough'),
                            FormBuilderFieldOption(value: 'Headache'),
                            FormBuilderFieldOption(value: 'Sweating'),
                            FormBuilderFieldOption(value: 'Fever'),
                            FormBuilderFieldOption(value: 'Chest Pain'),
                            FormBuilderFieldOption(value: 'Others'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllDone()),
                    );
                  },
                color: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 38),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),

              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  _fbKey.currentState!.save();
                  if (_fbKey.currentState!.validate()) {
                    print(_fbKey.currentState!.value);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllDone()),
                    );
                  }
                },
                color: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "SAVE",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return "";
  }

  String validatePin(String value) {
    String pattern = r'^[1-9][0-9]{5}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length != 6) {
      return 'Please enter valid pincode';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return "";
  }

}

//CLIPPER, DESIGN
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    //path.lineTo(0, size.height - 50);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width + 10, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
