import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/account_screen.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_state.dart';
import 'package:haveliapp/main.dart';
import 'package:haveliapp/model/SearchModel.dart';

class SearchItem extends StatefulWidget {
  // String? username;
  //
  // SearchScreen(this.username);

  SearchModel model;

  SearchItem(this.model);

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AccountScreen(widget.model.id,follow)));
      },
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: widget.model.image == null
                    ? Icon(Icons.account_circle)
                    : CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                    fit: BoxFit.cover,
                    imageUrl: BASE_URL + widget.model.image),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.model.email,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.model.following ? Colors.grey : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  follow();
                },
                child: Text(
                  widget.model.following ? "following" : "follow",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void follow() {

    print("hello");

    setState(() {
      MyProfileState state = profileBloc.state;

      if(state is Loaded){
        if(widget.model.following) {
          state.model.following--;
        }else{
          state.model.following++;
        }
      }
      widget.model.following = !widget.model.following;
    });
    DIO.post("$BASE_URL/api/follow/",
        data: {
          "id": widget.model.id,
        },
        options: TOKEN_HEDER);
  }
}
