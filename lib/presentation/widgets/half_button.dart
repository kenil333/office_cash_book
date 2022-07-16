import 'package:flutter/material.dart';

class Halfbutton extends StatelessWidget {
  final Size size;
  final Color color;
  final String title;
  final Function halfunc;
  const Halfbutton({
    Key? key,
    required this.size,
    required this.color,
    required this.title,
    required this.halfunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: color,
        ),
        onPressed: () {
          halfunc();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
          child: Text(
            title,
            style: TextStyle(fontSize: size.width * 0.05),
          ),
        ),
      ),
    );
  }
}
