import 'package:buy/finctions.dart';
import 'package:buy/models/product.dart';
import 'package:buy/screens/bottomnavbar/productinfo.dart';
import 'package:flutter/material.dart';



productViwe(String category,List<Product> allproducts ) {
  List<Product> dproducts;
  dproducts = productByCategory(category,allproducts) ;
  return Container(
    margin: EdgeInsets.all(10.0),
    child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: dproducts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, ProductInfo.id,arguments: dproducts[index]);
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: AssetImage(dproducts[index].pLocation),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Opacity(
                      opacity: 0.6,
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dproducts[index].pName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$ ${dproducts[index].pPrice}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
  );
}
