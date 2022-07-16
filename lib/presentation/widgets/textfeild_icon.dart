import 'package:flutter/material.dart';

import '../../domain/all.dart';

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
      decoration: ConstDecoration.containerdeco,
      child: Row(
        children: [
          if (title == AppString.emount || title == AppString.phonenumber)
            Text(
              title == AppString.phonenumber ? "+91" : '₹',
              style: TextStyle(
                fontSize: size.width * 0.06,
                color: AppColor.txtcol,
              ),
            ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: title == AppString.emount ? 0 : 20,
                left:
                    title == AppString.emount || title == AppString.phonenumber
                        ? 20
                        : 0,
              ),
              child: TextField(
                keyboardType: title == AppString.password
                    ? TextInputType.visiblePassword
                    : title == AppString.emount ||
                            title == AppString.phonenumber
                        ? TextInputType.number
                        : TextInputType.emailAddress,
                obscureText: title == AppString.password ? true : false,
                controller: controller,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: AppColor.txtcol,
                ),
                decoration: InputDecoration(
                  hintText: title,
                  border: InputBorder.none,
                ),
                maxLines: title == AppString.remark ? 3 : 1,
              ),
            ),
          ),
          if (title == AppString.emount || title == AppString.remark)
            Container()
          else
            Icon(
              icon,
              color: AppColor.txtcol,
            ),
        ],
      ),
    );
  }
}
