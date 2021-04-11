import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class UserFieldEditView extends StatefulWidget {
  final Function setField;
  final Function fieldValidator;
  final String fieldHint;
  final String title;
  final int lines;

  UserFieldEditView(
      {Key key,
      @required this.setField,
      @required this.fieldHint,
      @required this.title,
      @required this.fieldValidator,
      @required this.lines})
      : super(key: key);
  @override
  _UserFieldEditViewState createState() => _UserFieldEditViewState();
}

class _UserFieldEditViewState extends State<UserFieldEditView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fieldFormValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      Padding(
        padding: EdgeInsets.all(30),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
                        child: Text(
                          widget.title ?? "",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )),
                    TextFormField(
                      maxLines: widget.lines,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: widget.fieldHint ?? "",
                          hintStyle: TextStyle(color: Colors.grey)),
                      controller: fieldFormValue,
                      validator: (value) => widget.fieldValidator(value),
                    ),
                  ]),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                widget.setField(fieldFormValue.text);
                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                )),
                          )))
                ],
              ),
            ),
          )
        ]),
      )
    ]))));
  }
}

class ProfilePictureEditView extends StatefulWidget {
  final Function setProfilePic;
  final Function deleteCurrentPic;
  File currentImage;

  ProfilePictureEditView(
      {Key key,
      @required this.setProfilePic,
      @required this.deleteCurrentPic,
      @required this.currentImage});
  @override
  _ProfilePictureEditViewState createState() => _ProfilePictureEditViewState();
}

class _ProfilePictureEditViewState extends State<ProfilePictureEditView> {
  final picker = ImagePicker();

  File _image;

  void removeThisImage() {
    setState(() {
      _image = null;
      widget.currentImage = null;
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    _cropImage(pickedFile.path);
  }

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 175,
        maxHeight: 175,
        cropStyle: CropStyle.circle);

    setState(() {
      if (croppedImage != null) {
        _image = croppedImage;
      } else {
        print("no img");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
                child: Text(
                  "Change your profile picture",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Center(
                child: _image == null && widget.currentImage == null
                    ? Container(
                        decoration: ShapeDecoration(
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 10)),
                            color: Colors.grey.withOpacity(0.1)),
                        width: 175,
                        height: 175,
                      )
                    : Container(
                        width: 175,
                        height: 175,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 10))),
                        child: CircleAvatar(
                          backgroundImage: new AssetImage(_image == null
                              ? widget.currentImage.path
                              : _image.path),
                        ),
                      )
                // Image.file(_image),
                ),
            IntrinsicWidth(
                child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeThisImage();
                      widget.deleteCurrentPic();
                    }),
                IconButton(icon: Icon(Icons.photo_album), onPressed: getImage),
              ],
            )),
            // IconButton(icon: Icon(Icons.photo_album), onPressed: getImage),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        widget.setProfilePic(_image);
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          )),
                    )))
            // ElevatedButton(
            //     onPressed: () {
            //       widget.setProfilePic(_image);
            //       Navigator.pop(context);
            //     },
            //     child: Text("quick return"))
          ],
        ),
      )
    ]))));
  }
}
