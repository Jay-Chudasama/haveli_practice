import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_event.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  XFile? image;

  final ImagePicker _picker = ImagePicker();

  File? file;
TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickImage(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (file != null)
                Image.file(
                  file!,
                  height: screenWidth * 9 / 16,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _controller,
                maxLines: 3,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Caption",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: file==null? null: () {
                        Navigator.pop(context,AddPost(file!, _controller.text));
                    },
                    child: Text("add Post")),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pickImage(context) async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    print(image);
    if (image == null) {
      Navigator.pop(context);
    }
    file = File(image!.path);
    setState(() {});
  }
}
