import 'package:buy/admin/adminHome.dart';
import 'package:buy/admin/ordersDetails.dart';
import 'package:buy/provider/cartitem.dart';
import 'package:buy/screens/bottomnavbar/cartscreen.dart';
import 'package:buy/screens/bottomnavbar/login.dart';
import 'package:buy/screens/bottomnavbar/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:buy/screens/bottomnavbar/home.dart';
import 'package:buy/admin/editproduct.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
 bool isUserLoggedIn=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),//علشان ترجع الدتا الى شايه الميل 
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(home: Scaffold(body: Center(child:Text('Loading......')),),);
        }
        else{
          isUserLoggedIn=snapshot.data.getBool('keepMeLoggedIn') ?? false;
      return  MultiProvider(
      providers:[
      ChangeNotifierProvider<CartItem>(
        create:(context)=>CartItem() ,
        ),
      ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
      
      routes: {
        EditProduct.id:(context)=> EditProduct(),
        CartScreen.id:(context)=> CartScreen(),
        ProductInfo.id:(context)=> ProductInfo(),
        OrdersDetails.id:(context)=> OrdersDetails(), 
        HomePage.id:(context)=> HomePage(),
         LoginScreen.id:(context)=> LoginScreen(),
      }, 
    ),
    );
   }
      }
    );
  }
}
