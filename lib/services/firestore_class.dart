import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods{

  bool isLoggedIn()
  {
    if(FirebaseAuth.instance.currentUser() != null)
      {
        return true;
      }

      else{
      return false;
    }
  }
  
  Future<void> addData(carData) async{
    if(isLoggedIn())
      {
        Firestore.instance.collection('attendance Record').add(carData).catchError((e)
        {
          print(e);
        }
        );
      }

      else{
      print("You need to login first");
    }
  }

  getData() async{
    return await Firestore.instance.collection('attendance Record').getDocuments();
  }
}