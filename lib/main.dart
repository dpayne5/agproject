import 'package:flutter/material.dart';
import 'mainProfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileView(),
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

Widget profileField(String fieldName, String fieldValue, int lines) {
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
          Icon(
            Icons.edit,
            color: Colors.blue,
          )
        ],
      ));
}
