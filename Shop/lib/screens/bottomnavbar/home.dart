import 'package:buy/finctions.dart';
import 'package:buy/screens/bottomnavbar/cartscreen.dart';
import 'package:buy/screens/bottomnavbar/login.dart';
import 'package:buy/screens/bottomnavbar/productinfo.dart';
import 'package:buy/widget/productviwe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy/services/store.dart';
import 'package:buy/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buy/services/auth.dart';


class HomePage extends StatefulWidget {
  static String id ='HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabvalue=0;
  int indexbar=0;
  final _store=Store();
  final _auth =Auth();
  List<Product> _products=[];
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(length: 4,
       child: Scaffold(
     bottomNavigationBar: BottomNavigationBar(
       fixedColor: Colors.orange,
       currentIndex: indexbar,
       unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon:Icon(Icons.home_outlined),
          label:'Home',
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.logout),
          label:'Logout',
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.book_outlined),
          label:'Book Mark',
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.person_outline),
          label:'Profile',
        ),
      ],
      onTap:(value)async{
        if(value==1){
          SharedPreferences pref =await SharedPreferences.getInstance();// عملت object من sharedpreference
          pref.clear();
        await _auth.signOut();
        Navigator.popAndPushNamed(context, LoginScreen.id);
        }
        setState(() {
          indexbar=value;
        });  
       },

     ),
         appBar: AppBar( 
           title:Text('DISCOVER',
           style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.black,),),
           leading:IconButton(
         icon:  Icon(Icons.shopping_cart,color: Colors.black),
           onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return CartScreen();}));
         },  
      ),
           backgroundColor: Colors.white,
           elevation: 0,
           bottom:TabBar(
             indicatorColor: Colors.orange[200],
             onTap: (value){
             setState(() {
              tabvalue=value;
             });
             },
             tabs: [
               Text('Jackets',
               style:TextStyle(color: tabvalue==0?Colors.black:Colors.grey,fontSize:tabvalue==0? 16: null ),),
               Text('Trouser',
               style:TextStyle(color: tabvalue==1?Colors.black:Colors.grey,fontSize:tabvalue==1? 16: null ),),
               Text('T-shirts',
               style:TextStyle(color: tabvalue==2?Colors.black:Colors.grey,fontSize:tabvalue==2? 16: null ),),
               Text('Shoes',
               style:TextStyle(color: tabvalue==3?Colors.black:Colors.grey,fontSize:tabvalue==3? 16: null ),),
             ],
           ),
         ),
          body:TabBarView(
            children: [
            jacketViwe(),
            productViwe('trousers',_products),
            productViwe('t-shirts',_products),
            productViwe('shoes',_products),
            
            ],)
       ),
        ), 
      ],
    );
  }
  jacketViwe(){
    return StreamBuilder<QuerySnapshot>(
        stream:_store.loadProduct(),
        builder: (context,snapshot){
          List<Product> dproducts=[];
          
       for(var doc in snapshot.data.documents){
       dproducts.add(Product(
       pId: doc.documentID,
       pName: doc.data['productName'],
       pPrice: doc.data['productPrice'],
       pDescription: doc.data['productDescription'],
       pCategory: doc.data['productCategory'],
       pLocation: doc.data['productLocation'],
     ));
       }
       _products=[...dproducts];
       dproducts.clear();
       dproducts= productByCategory('jackets',_products);
     return Container( 
          margin:EdgeInsets.all(10.0),
         child: GridView.builder(
           scrollDirection: Axis.vertical,
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            ),
          itemCount:dproducts.length ,
          itemBuilder:(context,index){
            return Padding(
              padding:EdgeInsets.all(10.0),
           child:GestureDetector(
            onTap: (){
                Navigator.pushNamed(context, ProductInfo.id,arguments: dproducts[index]);
              },
            child:Stack(
              children:[
                Positioned.fill(
               child: Image(
                image:AssetImage(dproducts[index].pLocation),
                fit: BoxFit.fill,
                ),
                ),
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity:0.6 ,
                    child:Container(
                     height: 60,
                     width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(dproducts[index].pName,
                        style:TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${dproducts[index].pPrice}',
                        style:TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ], 
                    ),
                    ),
                    ),
                  ),
                    ) ,  
              ],
           ),
           ),
            );
          }
         ),
          );  
},);
  }  
}