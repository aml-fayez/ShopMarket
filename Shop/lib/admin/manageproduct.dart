import 'package:buy/widget/custom_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy/services/store.dart';
import 'package:buy/models/product.dart';
import 'package:buy/admin/editproduct.dart';
class ManageProduct extends StatefulWidget {
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store=Store();
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body:StreamBuilder<QuerySnapshot>(
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
            onTapUp:(details){
              double dx=details.globalPosition.dx;
              double dy=details.globalPosition.dy;
              double dx2=MediaQuery.of(context).size.width-dx;
              double dy2=MediaQuery.of(context).size.width-dy;
              showMenu(context: context,
               position:RelativeRect.fromLTRB(dx, dy, dx2, dy2) , 
               items:[
                 MyPopupMenuItem(
                   onClick:(){
                    Navigator.pushNamed(context,EditProduct.id,arguments:dproducts[index]); 
                   } ,
                   child:Text('Edit'),),
                 MyPopupMenuItem(
                   onClick:(){
                    _store.deleteProduct(dproducts[index].pId) ;
                     Navigator.pop(context);
                   } ,
                   child:Text('Delete'),),
               ],
               );
            } ,
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
        },
      ), 
    );
  }
}
