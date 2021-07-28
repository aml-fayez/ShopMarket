import 'package:buy/admin/orderScreen.dart';
import 'package:flutter/material.dart';
import 'package:buy/admin/addproduct.dart';
import 'package:buy/admin/manageproduct.dart';
class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body:Container(
        child:Column(
     mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            SizedBox(
              width:double.infinity,
            ),  
         ElevatedButton(
          onPressed:(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return AddProduct();}));
          },
         child:Text('Add Product'),
          ),
          ElevatedButton(
          onPressed:(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return ManageProduct();}));
          },
         child:Text('Edit Product'),
          ),
        
           ElevatedButton(
          onPressed:(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return OrderScreen();}));
          },
         child:Text('View Product'),
          ),
          ],
          ),
      ),
    );
  }
}