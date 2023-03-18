// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/MyWidget/cart_total.dart';
import 'package:haveliapp/auth/user/user_cubit.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_bloc.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_event.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_state.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../MyWidget/cart_item.dart';

class CartFragmemnt extends StatelessWidget {
  int price = 0;
  late String address;
  int totalAmount = 0;

  bool dialogOpen = false;

  String orderID = "";

  @override
  Widget build(BuildContext context) {
    address = BlocProvider.of<UserCubit>(context).state.userdata.address;
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is Verified || state is PaymentFailed) {
          if (state is Verified) {
            BlocProvider.of<UserCubit>(context).emptyCart();
          }
          if (dialogOpen) {
            dialogOpen = false;
            Navigator.pop(context);
          }
        }

        if (state is PaymentInitiated) {
          if (dialogOpen) {
            dialogOpen = false;
            Navigator.pop(context);
          }
          Razorpay _razorpay = Razorpay();
          _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
              (PaymentSuccessResponse response) {
            dialogOpen = true;
            paymentDialog(context,
                "Verifying Payment... Please Do not Press back button");
            BlocProvider.of<CartBloc>(context).add(VerifyPayment(
                response.orderId!, response.paymentId!, response.signature!));
          });
          _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
              (PaymentFailureResponse response) {
            //todo
            dialogOpen = true;
            paymentDialog(context,
                "Verifying Payment... Please Do not Press back button");
            BlocProvider.of<CartBloc>(context).add(PaymentFailure(orderID));
          });
          _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
              (ExternalWalletResponse response) {
            //nothing
            //   print(response);
          });
          orderID = state.orderId;
          var options = {
            'order_id': state.orderId,
            'key': state.key,
            'amount': totalAmount,
            'name': 'Tiffin App',
            'description': 'hello world',
          };

          _razorpay.open(options);
        }

        if (state is InitiatingPayment) {
          dialogOpen = true;
          paymentDialog(context, "Initiating Payment...");
        }
      },
      builder: (context, state) {
        price = 0;
        if (state is Init) {
          BlocProvider.of<CartBloc>(context).add(Cart());
        }
        if (state is Failed) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is Verified) {
          return Center(
            child: Text("OrderPlaced Successfully"),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state is Loaded
                ? Expanded(
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          toolbarHeight: 80,
                          expandedHeight: 80.0,
                          backgroundColor: Colors.transparent,
                          leading: SizedBox(),
                          flexibleSpace: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            centerTitle: true,
                            title: Container(
                              padding: EdgeInsets.all(12),
                              // margin: EdgeInsets.only(right: 50,left: 50),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(
                                    222, 191, 173, 0.8117647058823529),
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
                                    "You have ${state.list.length} items your list chart",
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
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index == state.list.length) {
                                totalAmount = price + state.deliveryCharge;
                                return CartTotal(price, state.deliveryCharge);
                              }

                              price = price +
                                  (state.list[index].price *
                                      state.list[index].qty);

                              return CartItem(state.list[index]);
                            },
                            childCount: state.list.length == 0
                                ? 0
                                : state.list.length + 1,
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
            if (state is Loaded && state.list.length > 0)
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24, bottom: 8),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(230, 109, 70, 1.0)),
                      onPressed: () {
                        TextEditingController _controller =
                        TextEditingController(text: address);
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {

                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Address",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    TextFormField(
                                      maxLines: 5,
                                      controller: _controller,
                                      decoration: InputDecoration(
                                          hintText: "Enter Address",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      height: 50,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<UserCubit>(context).state.userdata.address = _controller.text;
                                            Navigator.pop(context);
                                            BlocProvider.of<CartBloc>(context)
                                                .add(InitiatePayment(
                                                    _controller.text,
                                                    totalAmount));
                                          },
                                          child: Text(
                                            "Deliver Here",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    )
                                  ],
                                ),
                              );
                            });
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

  void paymentDialog(context, msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Center(
                    child: Text(
                  msg,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ));
  }
}
