import 'package:flutter/material.dart';
import 'editViews.dart';

enum userField { NAME, PHONE, EMAIL, ABOUT }

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _userName = "";
  String _userPhone = "";
  String _userEmail = "";
  String _userAbout = "";

  void setUserName(String validName) {
    setState(() {
      _userName = validName;
    });
  }

  String nameValidator(String value) {
    RegExp nameREGEX = RegExp(r"[a-zA-Z]+\s[a-zA-Z]+");

    if (value == null || nameREGEX.allMatches(value).length != 1) {
      return "Please enter your first and last name";
    }
    return null;
  }

  void setUserPhone(String validPhone) {
    setState(() {
      _userPhone = validPhone;
    });
  }

  String phoneValidator(String value) {
    RegExp phoneREGEX = RegExp(r"\([0-9]{3}\)[0-9]{3}-[0-9]{4}");
    if (value == null ||
        phoneREGEX.allMatches(value).length != 1 ||
        value.split(" ").length > 1) {
      return "Please enter a valid phone number following (XXX)XXX-XXXX";
    }
    return null;
  }

  void setUserEmail(String validEmail) {
    setState(() {
      _userEmail = validEmail;
    });
  }

  String emailValidator(String value) {
    RegExp emailREGEX = RegExp(r"[\w.]+@[a-z]+.[a-z]{3}");

    if (value == null ||
        emailREGEX.allMatches(value).length != 1 ||
        value.split(" ").length > 1) {
      return "Please enter a valid email address";
    }
    return null;
  }

  void setUserAbout(String validAbout) {
    setState(() {
      _userAbout = validAbout;
    });
  }

  String aboutValidator(String value) {
    if (value == null) {
      return "Please enter some text";
    }
    return null;
  }

  Widget profileField(String fieldName, String fieldValue, int lines,
      userField fieldVal, BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fieldName,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: RichText(
                        maxLines: lines,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: fieldValue,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )))
              ],
            )),
            IconButton(
              icon: const Icon(
                Icons.edit,
              ),
              onPressed: () {
                switch (fieldVal) {
                  case userField.ABOUT:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserFieldEditView(
                                setField: setUserAbout,
                                fieldHint: "Tell us about you!",
                                title: "Write a little bit about yourself",
                                fieldValidator: aboutValidator,
                                lines: 5)));

                    break;
                  case userField.EMAIL:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserFieldEditView(
                                setField: setUserEmail,
                                fieldHint: "ex: bob@gmail.com",
                                title: "Enter your email address",
                                fieldValidator: emailValidator,
                                lines: 1)));
                    break;
                  case userField.NAME:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserFieldEditView(
                                setField: setUserName,
                                fieldHint: "ex: John Doe",
                                title: "Enter your name",
                                fieldValidator: nameValidator,
                                lines: 1)));
                    break;
                  case userField.PHONE:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserFieldEditView(
                                setField: setUserPhone,
                                fieldHint: "(XXX)XXX-XXXX",
                                title: "Enter your phone number",
                                fieldValidator: phoneValidator,
                                lines: 1)));

                    break;
                }
              },
              color: Colors.blue,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
          child: Column(
        children: <Widget>[
          applicationTitle(),
          profilePictureContainer(),
          profileField("Name", _userName, 1, userField.NAME, context),
          Divider(
            thickness: 2,
            indent: 30,
            endIndent: 35,
          ),
          profileField("Phone", _userPhone, 1, userField.PHONE, context),
          Divider(
            thickness: 2,
            indent: 30,
            endIndent: 35,
          ),
          profileField("Email", _userEmail, 1, userField.EMAIL, context),
          Divider(
            thickness: 2,
            indent: 30,
            endIndent: 35,
          ),
          profileField("About", _userAbout, 3, userField.ABOUT, context)
        ],
      )),
    );
  }
}

Widget applicationTitle() {
  return Container(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: RichText(
          text: TextSpan(
        text: "Profile",
        style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0),
      )));
}

Widget profilePictureContainer() {
  return Center(
    child: Container(
      margin: EdgeInsets.all(20),
      width: 125,
      height: 125,
      decoration: ShapeDecoration(
          shape: CircleBorder(), color: Colors.grey.withOpacity(0.3)),
    ),
  );
}
