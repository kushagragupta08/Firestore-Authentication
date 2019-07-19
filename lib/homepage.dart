import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/firestore_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends  StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage>
{
  String subject;
  String attendance;
  String professor;
QuerySnapshot details;

  crudMethods crudObjects = new crudMethods();

  @override
  void initState()
  {
    crudObjects.getData().then((results)
    {
      setState(() {
        details = results;
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar: AppBar(
          title: Text("Data Handling"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),

              onPressed: ()
              {
                crudObjects.getData().then((results)
                {
                  setState(() {
                    details = results;
                  });
                });
              },
            ),

            IconButton(
              icon: Icon(Icons.add),

              onPressed: ()
                  {
                    _showDialog(context);
                  },
            ),
            IconButton(
              icon: Icon(Icons.call_missed_outgoing),
              onPressed: ()
    {
      FirebaseAuth.instance.signOut().then((value)
      {
        Navigator.of(context).pushNamed('/landingPage');
      }
      ).catchError((e)
      {
        print(e);
      }
      );
    },
            )
          ],
        ),
          body:

    _carList()
      );

  }

  _makeDialog(BuildContext context){
    return showDialog(context: context,
    builder: (BuildContext context)

        {
          return AlertDialog(
            title: Text("Success !!",
            style: TextStyle(
              color: Colors.green,
              fontSize: 15.0,
            ),
            ),
            content: Text("Data Added Successfully"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: ()
                {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
  Future<bool> _showDialog(BuildContext context) async{

    return showDialog(context: context,

    builder: ( BuildContext context)
        {
          return AlertDialog(

            title: Text("Add Details"),
            content:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

              TextField(
                decoration: InputDecoration(

                  labelText: "Enter Professor Name",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15.0,
                   // fontWeight: FontWeight.bold,
                  ),

                ),
                onChanged: (value){
                  setState(() {
                    this.professor  = value;
                  });
                },


              ),

SizedBox(height: 10.0,),
              TextField(
                decoration: InputDecoration(

                  labelText: "Enter Subject Name",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15.0,
                  //  fontWeight: FontWeight.bold,
                  ),

                ),
                onChanged: (value){
                  setState(() {
                    this.subject  = value;
                  });
                },


              ),
              SizedBox(height: 10.0,),

              TextField(
                decoration: InputDecoration(

                  labelText: "Enter No. of Attendance",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15.0,
                    //fontWeight: FontWeight.bold,
                  ),

                ),
                onChanged: (value){
                  setState(() {
                    this.attendance  = value;
                  });
                },


              ),



            ],),
            actions: <Widget>[
              FlatButton(
                  onPressed: ()
                      {
                        Navigator.pop(context);
                      }
                      , child: Text("Cancel",
              style: TextStyle(color: Colors.green,
              fontSize: 15.0,
              ),
              )),
              FlatButton(
                  onPressed: ()
                  {
                    Navigator.pop(context);
Map<String,String> subjectData = {

  'profName' : this.professor, 'subName':this.subject,'attendance':this.attendance
};

crudObjects.addData(subjectData).then((result)
{
  _makeDialog(context);
}
)
.catchError((e)
                    {
                      print("Error is $e");
                    }
                    );



                  }
                  , child: Text("Submit",
                  style: TextStyle(color: Colors.green,
                  fontSize: 15.0
                  ),
              ))
            ],

          );
        }

    );

  }


Widget _carList() {

    if(details != null)
      {
        return ListView.builder(
            itemCount: details.documents.length,
            padding: EdgeInsets.all(10.0),

            itemBuilder: (context,i)
        {
          return new ListTile(
            title: Text(details.documents[i].data['subName'],),
            subtitle: Text(details.documents[i].data['profName']),
            trailing: Text(details.documents[i].data['attendance'],
            style: TextStyle(color: Colors.green),
            ),

          );
        }
        );
      }

      else
        {
          return Text("Loading Please wait");
        }
}


}