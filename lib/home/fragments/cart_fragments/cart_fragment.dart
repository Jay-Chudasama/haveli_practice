// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/MyWidget/cart_total.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_bloc.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_event.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_state.dart';

import '../../../MyWidget/cart_item.dart';

class CartFragmemnt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc,CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is Init) {
          BlocProvider.of<CartBloc>(context).add(Cart());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Center(
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
            state is Loaded
                ? ListView.builder(
                    itemBuilder: (context, index) =>
                        CartItem(state.list[index]),
                    itemCount: state.list.length,
                  )
                : Center(child: CircularProgressIndicator()),
            if(state is Loaded && state.list.length>0)
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 8),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(230, 109, 70, 1.0)),
                    onPressed: () {
                      //todo
                    },
                    child: Text(
                      "Place Order",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}
