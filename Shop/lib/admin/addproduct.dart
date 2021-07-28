import 'package:buy/models/product.dart';
import 'package:flutter/material.dart';
import 'package:buy/services/store.dart';
import 'package:buy/admin/adminHome.dart';
//import 'package:buy/models/product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
TextEditingController pnameController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController categoryController = TextEditingController();
TextEditingController locationController = TextEditingController();
bool secure = true;
GlobalKey<FormState> pnameKey = GlobalKey<FormState>();
GlobalKey<FormState> priceKey = GlobalKey<FormState>();
GlobalKey<FormState> descriptionKey = GlobalKey<FormState>();
GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
GlobalKey<FormState> locationKey = GlobalKey<FormState>();
var _productKey =GlobalKey<FormState>();
final _store=Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading:IconButton(
          icon:Icon(Icons.arrow_back_ios),
           onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return AdminPage();}));
         },
      ),
      ),
      backgroundColor: Colors.orange[200],
      body:Container(
        margin: EdgeInsets.all(15.0),
        child:Form(
          key: _productKey,
       child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
       
              margin: EdgeInsets.all(15.0),
             child:Column(
               children: [
                
            field('Product Name',pnameController,TextInputType.text,false,pnameKey),
            field('Product Price',priceController,TextInputType.emailAddress,false,priceKey),
            field('Product Description',descriptionController,TextInputType.text,false,descriptionKey),
            field('Product Category',categoryController,TextInputType.text,false,categoryKey),
            field('Product Location',locationController,TextInputType.text,false,locationKey),
         ElevatedButton(
        onPressed:() async{
          if(_productKey.currentState.validate()){
             _productKey.currentState.save();
           try{
           await _store.addProduct(Product(
              pName:pnameController.text,
              pPrice:priceController.text,
              pDescription:descriptionController.text,
              pCategory:categoryController.text,
              pLocation:locationController.text,
          ));
           }catch(e){
     Scaffold.of(context).showSnackBar(snack(e.message));
     }
          
        }
        },
         child:Text('Add Product'),
          ),
               ],
               
             ),
            ), 
          ],
       ),
        ),
        ),
    );
  }
  snack(String content){
    return SnackBar(
      content:Text( content),
     duration: Duration(seconds: 3),
     backgroundColor: Colors.red,
      );
  }

  field(String label,TextEditingController controller,TextInputType type,bool secured,Key key){
  return Padding(
    padding: const EdgeInsets.all(15.0),
  child:TextFormField(
    cursorColor: Colors.orange[200],
   key: key,
   validator:(value){
   if(value.isEmpty){
   return 'this field required';
   }else{
     return null;  
   }
},
decoration: InputDecoration(
    filled: true,
    fillColor:Colors.white,
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.white, width:1)
          
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white, width: 1)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white, width: 1)
          ),
  labelText: label,
  ),
  textInputAction: TextInputAction.done,
  keyboardType: type,
   obscureText: secured,
   controller: controller
  
  ),
  );
}
}
/*child:IconButton(icon:Icons.arrow_back,
              onPressed:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return AdminPage();}));
              }),*/
