import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
 class Auth {
   final _auth=FirebaseAuth.instance;
 
 
 signUp(String email,String password) async
  {
   final authResult = (await _auth.createUserWithEmailAndPassword(email:email,password:password));
   return authResult;
  }
   signIn(String email,String password) async
  {
   final authResult = (await _auth.signInWithEmailAndPassword(email:email,password:password));
   return authResult;
  }
  getUser()async{
   return await _auth.currentUser();
  }
  signOut()async{
    return await _auth.signOut();
  }
 }
 