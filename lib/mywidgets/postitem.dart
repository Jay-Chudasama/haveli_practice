import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/model/PostModel.dart';
import 'package:jiffy/jiffy.dart';
import 'package:like_button/like_button.dart';

class PostItem extends StatefulWidget {
  PostModel model;
  late LikeButton likeBtn;

  PostItem(this.model) {
    likeBtn = LikeButton(
      size: 30,
      circleColor:
          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xffd7227e),
        dotSecondaryColor: Color(0xffcc0000),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          !isLiked ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
          color: isLiked ? Colors.redAccent : Colors.black,
          size: 30,
        );
      },
      countBuilder: (likeCount, isLiked, text) {
        return Text("$text likes");
      },
  onTap: (isLiked) async {
    like();
    return !isLiked;
  },
      isLiked: model.liked,
      likeCount: model.likes,
    );
  }

  void like() async {

      if(model.liked){
        //  dislike
        model.likes--;
        model.liked = false;

      }else{
        //  like
        model.liked = true;
        model.likes++;

      }
    try {
       await DIO.post("$BASE_URL/api/like/",
          data: {"id": model.id}, options: TOKEN_HEDER);

    } catch (value) {
      print(value);
    }
  }

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  double hoverScale = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 8, color: Colors.grey.shade200)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 19,
                  child: widget.model.user!.image == null
                      ? Icon(Icons.account_circle)
                      : CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            BASE_URL + widget.model.user!.image,
                          ),
                        ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.user!.username,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      Jiffy(widget.model.createdAt).fromNow(),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              if(widget.model.liked){
                return;
              }
              widget.likeBtn.onMyTap();
              setState(() {
                hoverScale = 1;
                Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    hoverScale = 0;
                  });
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: screenWidth * 9 / 16,
                  imageUrl:
                  BASE_URL + widget.model.image,
                ),

                AnimatedScale(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 400),
                  scale: hoverScale,
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.white.withAlpha(100),
                    size: 70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model.caption,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [widget.likeBtn],
            ),
          )
        ],
      ),
    );
  }


}
