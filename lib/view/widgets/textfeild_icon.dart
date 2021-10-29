import 'package:flutter/material.dart';

import './../../controller/common/all.dart';

class TextfeildIcon extends StatelessWidget {
  final TextEditingController controller;
  final Size size;
  final String title;
  final IconData icon;
  const TextfeildIcon({
    Key? key,
    required this.controller,
    required this.size,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.01,
        horizontal: size.width * 0.045,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
        vertical: 18,
      ),
      decoration: containerdeco,
      child: Row(
        children: [
          if (title == emount || title == phonenumber)
            Text(
              title == phonenumber ? "+91" : '₹',
              style: TextStyle(
                fontSize: size.width * 0.06,
                color: txtcol,
              ),
            ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: title == emount ? 0 : 20,
                left: title == emount || title == phonenumber ? 20 : 0,
              ),
              child: TextField(
                keyboardType: title == password
                    ? TextInputType.visiblePassword
                    : title == emount || title == phonenumber
                        ? TextInputType.number
                        : TextInputType.emailAddress,
                obscureText: title == password ? true : false,
                controller: controller,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: txtcol,
                ),
                decoration: InputDecoration(
                  hintText: title,
                  border: InputBorder.none,
                ),
                maxLines: title == remark ? 3 : 1,
              ),
            ),
          ),
          if (title == emount || title == remark)
            Container()
          else
            Icon(
              icon,
              color: txtcol,
            ),
        ],
      ),
    );
  }
}
