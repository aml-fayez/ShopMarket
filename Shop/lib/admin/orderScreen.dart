import 'package:buy/admin/ordersDetails.dart';
import 'package:buy/models/orders.dart';
import 'package:buy/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Store _store =Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: StreamBuilder<QuerySnapshot>(
        stream:_store.loadOrders(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child:Text('there is no orders'),
            );
          }
          else{
            List<Order> orders=[];
            for(var doc in snapshot.data.documents){
              orders.add(Order(
               oAddress:doc.data['Address'],
               oTotallPrice:doc.data['TotallPrice'],
               oId: doc.documentID,
              ));
            }
            return ListView.builder(
              itemBuilder:(context,index)=>Padding(
                padding: const EdgeInsets.all(20),
              child:GestureDetector(
              onTap:(){
              Navigator.pushNamed(context, OrdersDetails.id,arguments: orders[index].oId);
              },
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
                        Text('\$ ${orders[index].oTotallPrice}',
                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                         Text(orders[index].oAddress,
                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                      ]
              ),
                    ),
              ),
              ),
              ),
              itemCount: orders.length,
              );
          }
        }
      ), 
    );
  }
}