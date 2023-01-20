import 'package:flutter/material.dart';
import 'package:haveliapp/Widgets/product_item.dart';

import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  List<ProductModel> list = [
    ProductModel(
        "Iphone 14 pro max 512gb (black)",
        "Rs.1,39,999",
        "Rs.1,49,999",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",
        1),
    ProductModel(
        "Iphone 12 pro max 256gb (black)",
        "Rs.1,39,999",
        "Rs.1,49,999",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",
        1),
    ProductModel(
        "Iphone 13 pro max 256gb (black)",
        "Rs.1,39,999",
        "Rs.1,49,999",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",
        1),
    ProductModel(
        "Iphone 11 pro max 256gb (black)",
        "Rs.1,39,999",
        "Rs.1,49,999",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",
        1),
    ProductModel(
        "Iphone x pro max 256gb (black)",
        "Rs.1,39,999",
        "Rs.1,49,999",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaucN9zuzGy4HmGLlO3S50Ih9iq9KYhz0nAQ&usqp=CAU",
        1),
  ];

  List<ProductModel> filterList = [];

  @override
  Widget build(BuildContext context) {

    var renderlist = controller.text.isEmpty?list:filterList;

    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              ...renderlist
                  .map((ProductModel element) => ProductItem(element, () {
                        setState(() {
                          list.remove(element);
                        });
                      }))
                  .toList()
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 25)]),
          child: TextField(
            onSubmitted: (value) {
              filterList.clear();
              if(value.isEmpty){
                setState(() {

                });
                return;
              }
              setState(() {
                list.forEach((e) {
                  if (e.title.contains(value)) {
                    filterList.add(e);
                  }
                });
              });
            },
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                 setState(() {
                   controller.text = "";
                   filterList.clear();
                 });
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
            ),
          ),
        )
      ]),
    );
  }
}
