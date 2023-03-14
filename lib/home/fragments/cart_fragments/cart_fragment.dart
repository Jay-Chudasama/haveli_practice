// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:haveliapp/MyWidget/cart_total.dart';

class CartFragmemnt extends StatelessWidget {
  const CartFragmemnt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(12),
              // margin: EdgeInsets.only(right: 50,left: 50),
              decoration: BoxDecoration(
                color: Color.fromRGBO(222, 191, 173, 0.8117647058823529),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: Colors.deepOrange,
                  ),
                  Text(
                    "You have 3 items your list chart",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 14),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  "https://avatars.mds.yandex.net/i?id=323ddc46cc384578f7013afdf3eafed231fa7cda-7066046-images-thumbs&n=13&exp=1",
                  height: 100,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Jeera Rise",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "₹40",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    //todo
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                Text("15"),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    //todo
                                  },
                                  icon: Icon(Icons.remove),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.delete,
                            size: 32,
                            color: Colors.red,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CartTotal(),
        Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 24,bottom: 8),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(230, 109, 70, 1.0)
              ),
                onPressed: () {
              //todo
            }, child: Text("Place Order",style: TextStyle(fontSize: 20),)),
          ),
        ),
      ],
    );
  }
}
