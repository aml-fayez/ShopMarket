
//import 'package:buy/admin/addproduct.dart';
import 'package:buy/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Store {
final Firestore _firestore=Firestore.instance;
addProduct(Product product ) {
_firestore.collection('Products').add(
  {
      'productName':product.pName,
      'productPrice' :product.pPrice,
      'productDescription':product.pDescription,
      'productCategory' :product.pCategory , 
      'productLocation':product.pLocation,
  }
);
}

Stream<QuerySnapshot> loadProduct(){
return  _firestore.collection('Products').snapshots();
}
deleteProduct(documentID){
  _firestore.collection('Products').document(documentID).delete();
}
editProduct(data,documentID){
  _firestore.collection('Products').document(documentID).updateData(data);
}
storeOrder(data,List<Product> products){
   var documentRef= _firestore.collection('Orders').document();
   documentRef.setData(data);
   documentRef.collection('orderDetails');
   for(var product in products){
   documentRef.collection('orderDetails').document().setData({
    'productName':product.pName,
    'productPrice' :product.pPrice,
    'productQuentity' :product.pQuentity,
    'productLocation':product.pLocation,
    'productCategory' :product.pCategory ,
   });
   }

}
Stream<QuerySnapshot> loadOrders(){
return  _firestore.collection('Orders').snapshots();
}
Stream<QuerySnapshot> loadOrdersDetails(documentID){
return  _firestore.collection('Orders').document(documentID).collection('orderDetails').snapshots();
}
}
