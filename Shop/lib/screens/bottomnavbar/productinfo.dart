import 'package:buy/models/product.dart';
import 'package:buy/provider/cartitem.dart';
import 'package:buy/screens/bottomnavbar/cartscreen.dart';
import 'package:buy/screens/bottomnavbar/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
class ProductInfo extends StatefulWidget {
  static String id ='ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity=1;
  
  @override
  Widget build(BuildContext context) {
    Product iproduct= ModalRoute.of(context).settings.arguments;
    return Scaffold( 
        appBar: AppBar(
           backgroundColor: Colors.white,
           elevation: 0,
            title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
         IconButton(
         icon: Icon(Icons.arrow_back_ios,color: Colors.black),
           onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return HomePage();}));
         },  
      ),
      IconButton(
         icon:  Icon(Icons.shopping_cart,color: Colors.black),
           onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return CartScreen();}));
         },  
      ),
     
     ],
      ),
        ),
      body: Stack
      (children: [
        Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       child: Image(
          image: AssetImage(iproduct.pLocation),
          fit: BoxFit.fill,
          ),
        ),
        Positioned(
           bottom: 0,
          child:Column(
            children: [
              Opacity(
             child: Container(
               color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height *0.25,
            child:Padding(
              padding: EdgeInsets.all(30),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(iproduct.pName,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                ),),
                Text(iproduct.pDescription,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                ),),
                 Text( '\$ ${iproduct.pPrice}',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                    child:Material(
                      color: Colors.orange,  
                 child:GestureDetector(
                   onTap: add,
                  child: Icon(Icons.add),
                 ),
                    ), 
                    ),
                    Text(_quantity.toString(),
                    style: TextStyle(fontSize: 50),
                    ),
                     ClipOval(
                    child:Material(
                      color: Colors.orange,  
                 child:GestureDetector(
                   onTap: subtract,
                  child: Icon(Icons.remove),
                 ),
                    ), 
                    ),
                  
                  ],)
                
              ],)  
            ),
              ),
            opacity: 0.5,
              ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height *0.08,
           child: Builder(
             builder:(context)=>
          RaisedButton(
           color:Colors.orange,
            onPressed:(){
              addToCart(context,iproduct);
            },
            
            child:Text('Add to Cart'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20.0),),
            ),
          ),
            ),
      ],
      ),
        ),
      ],),
    );
  }
  subtract(){
    if(_quantity>0){
      setState(() {
        _quantity--;
      });
    }
  }
  add(){
    setState(() {
      _quantity++;
    });
  }
  addToCart(context,iproduct)
           {
             CartItem cartItem=  Provider.of<CartItem>(context,listen: false);
             iproduct.pQuentity=_quantity;
             bool exist=false;
             var productsInCart=cartItem.products;
             for( var productInCart in productsInCart){
               if(productInCart.pName== iproduct.pName){
                 exist=true;
               }
             }
             if(exist){
              Scaffold.of(context).showSnackBar(SnackBar(
               content:Text('you\'ve added this item before'))
              );
             }
             else{
             cartItem.addProduct(iproduct);
             Scaffold.of(context).showSnackBar(SnackBar(
               content:Text('Added to Cart '))
               );
              }}
}