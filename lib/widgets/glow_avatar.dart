import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GlowAvatar extends StatelessWidget {
  String avatarUrl;
  GlowAvatar({this.avatarUrl = ''});
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      endRadius: 120,
      duration: Duration(seconds: 2),
      glowColor: Colors.white,
      repeat: true,
      repeatPauseDuration: Duration(milliseconds: 15),
      startDelay: Duration(seconds: 1),
      child: Material(
          elevation: 15.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Image.asset("${avatarUrl}"),
            radius: 80.0,
          )),
    );
  }
}
