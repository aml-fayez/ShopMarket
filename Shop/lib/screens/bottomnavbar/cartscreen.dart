import 'package:buy/models/product.dart';
import 'package:buy/provider/cartitem.dart';
import 'package:buy/screens/bottomnavbar/home.dart';
import 'package:buy/screens/bottomnavbar/productinfo.dart';
import 'package:buy/services/store.dart';
import 'package:buy/widget/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatefulWidget {
  static String id ='CartScreen';
  
  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> cproduct=Provider.of<CartItem>(context).products;
    final hs=MediaQuery.of(context).size.height;
    final ws=MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
         icon:Icon(Icons.arrow_back_ios),color: Colors.black,
          onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return HomePage();}));
          },
          ),
          title: Text('My Cart',style: TextStyle(color: Colors.black),),
      ),
      body:Column(
        children: [
      Expanded(
     child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: cproduct.length,
        itemBuilder:(context,index){
         return Padding(
           padding: const EdgeInsets.all(15),
          child:GestureDetector(
            onTapUp:(details){
            showMenucustom(details,context,cproduct[index]);
            },
          child:Container(
           height:hs * 0.15,
           color: Colors.orange[200],
           child:Row(
             children: [
               CircleAvatar(
                 radius: hs*0.15/2,
                backgroundImage: AssetImage(cproduct[index].pLocation), 
               ),
               Row(children: [
                 Padding(
                   padding: const EdgeInsets.only(left:15),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                  Text(cproduct[index].pName,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text('\$${cproduct[index].pPrice}',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),) ,
                Text('Q:' + cproduct[index].pQuentity.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                   ],)
                 ),
               ],),
             ],),
          ),
          ),
         );
        }, 
      ),
      ),
      Builder(
        builder:(context)=>
       ButtonTheme(
        height: hs*0.08,
        minWidth: ws,
     child: RaisedButton(
        shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(20) ),
        color: Colors.orange,
        child:Text('order'.toUpperCase(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        
        onPressed:(){
          showCutomDialog(cproduct,context);
        },
      ),
      ),
      ),
        ]),   
    );
  }
 void showMenucustom(details,context,product) async{
              double dx=details.globalPosition.dx;
              double dy=details.globalPosition.dy;
              double dx2=MediaQuery.of(context).size.width-dx;
              double dy2=MediaQuery.of(context).size.width-dy;
            await  showMenu(context: context,
               position:RelativeRect.fromLTRB(dx, dy, dx2, dy2) , 
               items:[
                 MyPopupMenuItem(
                   onClick:(){
                    Navigator.pop(context);
                    Navigator.pushNamed(context,ProductInfo.id,arguments:product);
                    Provider.of<CartItem>(context,listen: false).deleteProduct(product);
                   } ,
                   child:Text('Edit'),),
                 MyPopupMenuItem(
                   onClick:(){
                     Navigator.pop(context);
                      Navigator.pushNamed(context,ProductInfo.id,arguments:product);
                   } ,
                   child:Text('Delete'),),
               ],
               );
  }
  showCutomDialog(List<Product> products,context)async{
    var price=getTotalPrice(products);
    var address;
    AlertDialog alertDialog =AlertDialog(
      title: Text('Total Price =\$ $price'),
      actions: [
        MaterialButton(
          child:Text('Confirm') ,
          onPressed: (){
            try{
            Store _store =Store();
            _store.storeOrder({
             'TotallPrice':price,
             'Address':address,
            }, products);
           Scaffold.of(context).showSnackBar(SnackBar(
               content:Text('Orderd Successfully'))
              );
            Navigator.pop(context);
            }catch(ex){
              print(ex.message);
            }
          },
          )
      ],
      content: TextField (
        onChanged: (value){
          address=value;
        },
        decoration:InputDecoration(
        hintText:'Enter your Address'),
        ), 
       );
    
     await showDialog(context: context,
     builder:(context){
       return alertDialog;
     });
  }
  getTotalPrice(List<Product> products){
  var price=0;
  for( var product in products){
  price += product.pQuentity * int.parse(product.pPrice);
  }
  return price;
  }
}
