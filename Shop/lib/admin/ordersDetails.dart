import 'package:buy/models/orders.dart';
import 'package:buy/models/product.dart';
import 'package:buy/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersDetails extends StatefulWidget {
  static String id='OrdersDetails';
  @override
  _OrdersDetailsState createState() => _OrdersDetailsState();
}
class _OrdersDetailsState extends State<OrdersDetails> {
   Store _store =Store();
  @override
  Widget build(BuildContext context) {
    String documentID=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrdersDetails(documentID),
        builder: (context,snapshot){
           if(!snapshot.hasData){
            return Center(
              child:Text('Loading orders Details'),
            );
          }
          else{
          List<Product> products=[];
          for(var doc in snapshot.data.documents){
            products.add(Product(
       pName: doc.data['productName'],
       pPrice: doc.data['productPrice'],
       pQuentity: doc.data['prodctQuentity'],
            ));
          }
             return Column(children: [
               Expanded(child: 
              ListView.builder(
              itemBuilder:(context,index)=>Padding(
                padding: const EdgeInsets.all(20),
            child: Container(
                     height: MediaQuery.of(context).size.height*0.2,
                     width: MediaQuery.of(context).size.width,
                     color: Colors.orange[200],
                    child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text('product name :${products[index].pName}',
                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                         Text('product price :${products[index].pPrice}',
                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                         Text('product qientity :${products[index].pQuentity.toString()}',
                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                      ]
                    ),
                    ),
                    ),
              ),
              itemCount:products.length,
             ),
               ),
               Padding(padding:const EdgeInsets.all(20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               RaisedButton(
        shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(20) ),
        color: Colors.orange,
        child:Text('Confirm Order',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                 onPressed:(){}),
                RaisedButton(
        shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(20) ),
        color: Colors.orange,
        child:Text('Delete Order',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                 onPressed:(){}),  
             ],),
               ),
             ],
             );
          }
        }
      ),   
    );
  }
}