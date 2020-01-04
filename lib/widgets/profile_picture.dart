import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  String imagePath;
  String name;
  double size;

  ProfilePicture({this.name = "", this.imagePath = "", this.size =45 });

  @override
  Widget build(BuildContext context) {

    return imagePath == ""
        ? CircleAvatar(
            child: Text(
              "${name.toUpperCase().substring(0, 1)}",
              style: TextStyle(fontSize: 30),
            ),
            radius: size)
        : CircleAvatar(
            /// IMAGE PART
            backgroundImage: CachedNetworkImageProvider(imagePath,),
            radius: size,
          );
  }
}
