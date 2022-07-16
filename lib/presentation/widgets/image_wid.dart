import 'package:flutter/material.dart';

class Imagewid extends StatelessWidget {
  final Size size;
  const Imagewid({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          "assets/images/icon.png",
          width: size.width * 0.3,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
