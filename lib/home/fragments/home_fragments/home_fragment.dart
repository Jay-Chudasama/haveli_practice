import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_cubit.dart';
import 'package:haveliapp/auth/auth_state.dart' as AuthState;
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_event.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_state.dart';
import 'package:haveliapp/utils.dart';
import 'package:jiffy/jiffy.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is Failed) {
          if (state.messsage == UNAUTHENTICATED) {
            BlocProvider.of<AuthCubit>(context)
                .emit(AuthState.UnAuthenticated());
            deletToke();
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.messsage)));
        }
      },
      builder: (context, state) {
        if (state is Init) {
          BlocProvider.of<HomeBloc>(context).add(MenuLoad());
        }

        if (state is Loaded) {

          if(state.menu==null){
            return Center(child: Text("Order window has been closed"),);
          }

          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(
                        "Naranpura, Ahmeda...",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        Jiffy(state.menu!.closing).format('till hh:mm aa'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.alarm)
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.yellowAccent.shade100,
                    ),
                    child: Center(
                      child: Text(
                        "Hurry Up! Order window is OPEN",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      shape: BoxShape.rectangle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        BASE_URL + state.menu!.banner!,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    state.menu!.type!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Wrap(
                      direction: Axis.horizontal,
                      children: state.menu!.items
                          .map((element) => Container(
                              height: 160,
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
                                   CachedNetworkImage(imageUrl: BASE_URL+element.image,height: 80,width: 80,),
                                    Text(
                                      element.name,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    OutlinedButton(
                                        onPressed: () {
                                          //todo
                                        },
                                        child: Text("Add +"))
                                  ],
                                ),
                              )))
                          .toList()),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  Text(
                    "Extras",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                      children: state.menu!.extras
                          .map((element) => Container(
                          height: 160,
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
                                CachedNetworkImage(imageUrl: BASE_URL+element.image,height: 80,width: 80,),
                                Text(
                                  element.name,
                                  style: TextStyle(fontSize: 15),
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      //todo
                                    },
                                    child: Text("Add +"))
                              ],
                            ),
                          )))
                          .toList()
                  ),
                ],
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
