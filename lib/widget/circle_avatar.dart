import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String linkImg;
  final double size;

  const ProfilePicture({
    Key? key,
    required this.linkImg,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: linkImg.isNotEmpty
            ? Image.network(
                linkImg,
                height: size,
                width: size,
              )
            : Icon(
                Icons.account_circle_rounded,
                size: size,
              ),
      ),
    );
  }
}
