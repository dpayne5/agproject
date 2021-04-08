import 'package:flutter/material.dart';

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
    return Material(
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
    ]));
  }
}
