import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class AvatarFromUsername extends StatelessWidget {
  final String username;
  final double radius;

  AvatarFromUsername({required this.username, this.radius = 20.0});

  @override
  Widget build(BuildContext context) {
    // Tạo ngẫu nhiên một màu từ username để sử dụng làm màu nền của avatar
    final backgroundColor = Color(int.parse(username.hashCode.toRadixString(16).substring(0, 6), radix: 16) | 0xFF000000);

    return SizedBox(
      child: AvatarGlow(
        // startDelay: Duration(milliseconds: 100),
        // duration: Duration(milliseconds: 200),
        // repeat: true,
        // showTwoGlows: true,
        // repeatPauseDuration: Duration(milliseconds: 100),
        glowColor: backgroundColor,
        endRadius: radius + 10.0,
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: radius,
          child: Text(
            username.isNotEmpty ? username[0].toUpperCase() : 'A',
            style: TextStyle(fontSize: radius - 5.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
