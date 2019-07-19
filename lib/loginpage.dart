import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  //Google Sign in
  GoogleSignIn googleSignIn = new GoogleSignIn();

  //Facebook Sign in
FacebookLogin fbLogin = new FacebookLogin();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Column(
        children: <Widget>[
          Image.network('https://firebase.google.com/_static/images/firebase/touchicon-180.png',
          height: 250.0,
            width: 250.0,
            fit: BoxFit.cover,

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
                  labelText: "Enter e-mail id",
                  labelStyle:
                  TextStyle(color: Colors.greenAccent, fontSize: 20.0)),
            onChanged: (value)
              {
                setState(()
                {
                  _email = value;
                }
                );

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
              onChanged: (value)
              {
                setState(()
                {
                  _password = value;
                }
                );

              },

            ),
          ),
          Row(children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width/2,
                child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
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
                    onPressed: () {
                      FirebaseAuth.instance.
                      signInWithEmailAndPassword(
                          email: _email, password: _password).then((
                          FirebaseUser user) {
                        Navigator.of(context).pushReplacementNamed('/homePage');
                      }
                      ).catchError((e) {
                        print(e);
                      });
                    })),

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
                      Navigator.of(context).pushNamed('/signUp');
                    }))

          ]),
        SizedBox(width: 300.0,
        height: 50.0,
          child:RaisedButton.icon(
            onPressed: ()
            {
                  googleSignIn.signIn().then((result) {

                    result.authentication.then((googleKey)
                    {
                          FirebaseAuth.instance.signInWithGoogle(
                              idToken: googleKey.idToken,
                              accessToken: googleKey.accessToken).then((signedInUser)
                          {
                            print("Signed in as ${signedInUser.email} ");
                           String a = signedInUser.uid;
                            debugPrint("Your mobile Number is : $a");
                            Navigator.of(context).pushReplacementNamed('/homePage');
                          }
                          ).catchError((e)
                          {
                            print(e);
                          }
                          );
                    }
                    ).catchError((e)
                    {

                    }
                    );
                  }).catchError((e)
                  {
                    print(e);
                  }
                  );

            },

            icon: Image.network('https://image.flaticon.com/teams/slug/google.jpg',
              width: 30.0,
              height: 30.0,
            ),
            label: Text("Sign in with Google"),
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
            textColor: Colors.grey,
            textTheme: ButtonTextTheme.accent,
          ),
        ),
SizedBox(height: 20.0,),
          SizedBox(
            width: 300.0,
            height: 50.0,
            child:RaisedButton.icon(
              onPressed: ()
              {
                    fbLogin.logInWithReadPermissions(
                      ['email','public_profile']).then((result)
               {
                 switch(result.status)
                 {

                   case FacebookLoginStatus.loggedIn:
                     FirebaseAuth.instance.
                 signInWithFacebook(accessToken: result.accessToken.token)
                         .then((signedInUser)
                     {
                       print("Signed in as : ${signedInUser.displayName}");
                       Navigator.of(context).pushReplacementNamed('/homePage');
                     }
                     ).catchError((e)
                     {
                       print(e);
                     }

                     ).catchError((e)
                     {
                       print(e);
                     }
                     );
                     break;
                   case FacebookLoginStatus.cancelledByUser:break;
                   case FacebookLoginStatus.error:break;
                 }
               }
                    );
              },
              icon: Image.network('http://www.stickpng.com/assets/images/584ac2d03ac3a570f94a666d.png',
                width: 30.0,
                height: 30.0,
              ),
              label: Text("Sign in with Facebook"),
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),

              ),
              textColor: Colors.white,
              textTheme: ButtonTextTheme.accent,
              color: Color.fromRGBO(59, 89, 152, 1.0),
            ) ,
          ),
        SizedBox(
          height: 20.0,
        )
        ,
          SizedBox(
            width: 300.0,
            height: 50.0,
            child:RaisedButton.icon(
              onPressed: ()
              {

              },
              icon: Image.network('https://pmcdeadline2.files.wordpress.com/2014/06/twitter-logo.png?w=446&h=299&crop=1',
                width: 30.0,
                height: 30.0,
              ),
              label: Text("Sign in with Twitter"),
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),

              ),
              textColor: Colors.white,
              textTheme: ButtonTextTheme.accent,
              color: Color.fromRGBO(0, 172, 237, 1.0),
            ) ,
          ),

        ],
      ),
    );
  }

}