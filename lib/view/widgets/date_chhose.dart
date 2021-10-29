import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../controller/common/all.dart';

class Datechoose extends StatelessWidget {
  final Size size;
  final String title;
  final DateTime? date;
  final Function datefunc;
  const Datechoose({
    Key? key,
    required this.size,
    required this.title,
    required this.date,
    required this.datefunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
        vertical: 18,
      ),
      padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
      decoration: containerdeco,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.05),
              alignment: Alignment.centerLeft,
              child: Text(
                date == null ? title : DateFormat('dd-MM-yyyy').format(date!),
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: txtcol,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                datefunc();
              },
              icon: Icon(
                Icons.date_range_rounded,
                size: size.width * 0.07,
                color: txtcol,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
