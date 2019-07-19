import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userManagement.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 150.0),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                      )),
                  labelText: "Enter e-mail id",
                  labelStyle:
                      TextStyle(color: Colors.greenAccent, fontSize: 20.0)),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                      )),
                  labelText: "Enter password",
                  labelStyle:
                      TextStyle(color: Colors.greenAccent, fontSize: 20.0)),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
          ),
          Row(children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                width:MediaQuery.of(context).size.width/2,

                child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                      ),
                    ),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    onPressed: () {})),
            Container(
                padding: EdgeInsets.all(10.0),
                width:MediaQuery.of(context).size.width/2,

                child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                      ),
                    ),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((signedInUser) {

                            new UserManagement().storeNewUser(signedInUser,context);
                      })
                          .catchError((e) {
                        print(e);
                      });
                    }))
          ])
        ],
      ),
    );
  }
}
