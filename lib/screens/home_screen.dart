import 'package:flutter/material.dart';
import 'package:haveliapp/Widgets/product_item.dart';

import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> list = [
    ProductModel("Iphone 14 pro max 256gb (black)","Rs.1,39,999","Rs.1,49,999","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",1),
    ProductModel("Iphone 14 pro max 256gb (black)","Rs.1,39,999","Rs.1,49,999","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",1),
    ProductModel("Iphone 14 pro max 256gb (black)","Rs.1,39,999","Rs.1,49,999","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",1),
    ProductModel("Iphone 14 pro max 256gb (black)","Rs.1,39,999","Rs.1,49,999","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",1),
    ProductModel("Iphone 14 pro max 256gb (black)","Rs.1,39,999","Rs.1,49,999","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          ...list.map((ProductModel element)=>ProductItem(element,(){
            setState(() {
              list.remove(element);
            });
          })).toList()
          ],
        ),
      ),
    );
  }
}
