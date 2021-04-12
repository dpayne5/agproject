import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
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
      var names = validName.split(" ");
      names[0] = names[0][0].toUpperCase() + names[0].substring(1);
      names[1] = names[1][0].toUpperCase() + names[1].substring(1);

      _userName = names.join(" ");
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
      return "Please use the format (XXX)XXX-XXXX";
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
    if (value == null || value.length == 0) {
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
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
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
                                lines: 3)));

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
    return Material(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          applicationTitle(),
          ProfileImageView(name: _userName),
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
      ),
    ));
  }
}

Widget applicationTitle() {
  return Container(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: RichText(
          text: TextSpan(
              text: "Edit Profile",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 36,
                  fontWeight: FontWeight.w400))));
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

class ProfileImageView extends StatefulWidget {
  final String name;

  final picker = ImagePicker();

  ProfileImageView({Key key, @required this.name});

  @override
  _ProfileImageViewState createState() => _ProfileImageViewState();
}

class _ProfileImageViewState extends State<ProfileImageView> {
  File _file;

  void setImage(File file, bool userDidEdit) {
    if (userDidEdit) {
      setState(() {
        _file = file;
      });
    }
    // setState(() {
    //   _file = file;
    // });
  }

  void deleteImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var nameSeperated = widget.name.split(" ");
    String initials =
        widget.name == "" ? "" : nameSeperated[0][0] + nameSeperated[1][0];

    return Center(
        child: Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(10),
            width: 175,
            height: 175,
            decoration: ShapeDecoration(
                shape: CircleBorder(
                    side: BorderSide(
                        color: Colors.grey.withOpacity(0.2), width: 10))),
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.1),
              backgroundImage: _file == null ? null : FileImage(_file),
              // new AssetImage(_file.path),
              child: Text(
                widget.name == null || _file != null
                    ? ""
                    : initials.toUpperCase(),
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6)),
              ),
            )),
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePictureEditView(
                          setProfilePic: setImage,
                          deleteCurrentPic: deleteImage,
                          currentImage: _file,
                          initials: initials,
                        )));
          },
        ),
      ],
    ));
  }
}
