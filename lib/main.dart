import 'package:flutter/material.dart';
import 'homepage.dart';
import 'signuppage.dart';
import 'loginpage.dart';
void main() {
  runApp( new MyApp()
  );
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: <String,WidgetBuilder>
      {
        '/landingPage':(BuildContext context) => new MyApp(),
        '/signUp':(BuildContext context)=>new  SignUpPage(),
        '/homePage':(BuildContext context)=> HomePage(),
      },
    );
  }

}
