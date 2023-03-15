import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/auth/user/user_cubit.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_event.dart';
import 'package:haveliapp/model/MenuModel.dart';
import 'package:haveliapp/model/User_model.dart';
import 'package:haveliapp/utils.dart';

import '../auth/user/user_state.dart';
import '../constant.dart';
import '../model/Items.dart';

class MenuItem extends StatelessWidget {
  Items item;

  MenuItem(this.item);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {

        bool alreadyAdded = state.userdata.cart.contains(item.id);

        return Container(
        // height: 160,
        width: 120,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: BASE_URL + item.image,
                height: 80,
                width: 80,
              ),
              Text(
                item.name,
                style: TextStyle(fontSize: 15),
              ),
              OutlinedButton(
                onPressed: () {
                  if (alreadyAdded) {
                    //  remove
                      BlocProvider.of<UserCubit>(context).removeToCart(item.id);
                    } else {
                    //  add
                    BlocProvider.of<UserCubit>(context).addToCart(item.id);

                  }
                },
                child: Text(alreadyAdded ? "Remove - " : "Add +"),
              ),
              Text("₹${item.price.toString()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ],
          ),
        ),
      );
      },
    );
  }
}
