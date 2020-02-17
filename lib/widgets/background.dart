import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  String imgUrl;
  Background({this.imgUrl = 'assets/bg/plexus.gif'});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(imgUrl, fit: BoxFit.cover,),
    );
  }

}
