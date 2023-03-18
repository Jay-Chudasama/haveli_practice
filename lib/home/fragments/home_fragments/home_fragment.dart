import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haveliapp/MyWidget/menu_item.dart';
import 'package:haveliapp/auth/auth_cubit.dart';
import 'package:haveliapp/auth/auth_state.dart' as AuthState;
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_event.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_state.dart';
import 'package:haveliapp/utils.dart';
import 'package:jiffy/jiffy.dart';

class HomeFragment extends StatelessWidget {
  Position? _currentPosition;

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
          _getCurrentPosition(context).then((value) {
            BlocProvider.of<HomeBloc>(context).add(MenuLoad());
          }).catchError((value){
            print(value);
          });
        }

        if (state is Failed) {
          return Center(
            child: Text(state.messsage),
          );
        }

        if (state is Loaded) {
          if (state.menu == null) {
            return Center(
              child: Text("Order window has been closed"),
            );
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
                        AREA,
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
                          .map(
                            (element) => MenuItem(element),
                          )
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
                          .map(
                            (element) => MenuItem(element),
                          )
                          .toList()),
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

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition(context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await _getAddressFromLatLng(_currentPosition!);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude);

    Placemark place = placemarks[0];
    AREA = place.subLocality != null ? place.subLocality! : place.locality!;
    print(place.locality);
    print(place.subLocality);
  }
}
