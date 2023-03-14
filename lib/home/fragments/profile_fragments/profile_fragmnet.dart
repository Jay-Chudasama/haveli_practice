// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Color.fromRGBO(230, 109, 70, 1.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(child: Text("Profile",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),alignment: Alignment.topLeft,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: CircleAvatar(
                    radius: 47,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://avatars.mds.yandex.net/i?id=d4abcb99b86e99d3aff0bd407085450db353bea3-9137660-images-thumbs&n=13&exp=1",
                      ),
                      radius: 45,
                    ),
                  ),
                ),
                SizedBox(height: 14,),
                Text("Sahil Viradiya",style: TextStyle(color: Colors.white,fontSize: 20),),
                SizedBox(height: 4,),
                Text("9725558828",style: TextStyle(color: Colors.white,fontSize: 20),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48.0,bottom: 24),
            child: Text("Total No. Of Orders",style: TextStyle(color: Colors.black,fontSize: 20),),
          ),

          Text("10",style: TextStyle(color: Colors.black,fontSize: 28),),
        SizedBox(height: 18,),
        Divider(),
        ],
      ),
    );
  }
}
