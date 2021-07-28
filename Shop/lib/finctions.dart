//import 'package:flutter/material.dart';
import 'package:buy/models/product.dart';

productByCategory(String ca,List<Product> allproducts){
     List<Product>  dproducts=[];
     try{
   for( var Product in allproducts){
      if(Product.pCategory== ca){
        dproducts.add (Product);
      }
       }
     }on Error catch(ex){
       print(ex);
     }
       return dproducts;
  }