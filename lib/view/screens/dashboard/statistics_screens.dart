import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTime? _start;
  DateTime? _end;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _cont = Get.put(GlobalGet());
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            statistics,
            style: TextStyle(
              fontSize: size.width * 0.06,
              color: txtcol,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          BalanceWid(
            size: size,
            title: credit,
            amount: _cont.gettotalcredit(_start, _end).toStringAsFixed(2),
          ),
          BalanceWid(
            size: size,
            title: debit,
            amount: _cont.gettotaldebit(_start, _end).toStringAsFixed(2),
          ),
          const SizedBox(height: 40),
          Datechoose(
            size: size,
            title: "Starting Date",
            date: _start,
            datefunc: () async {
              _start = await CustMeth().pickthedate(context);
              setState(() {});
            },
          ),
          Datechoose(
            size: size,
            title: "Ending Date",
            date: _end,
            datefunc: () async {
              _end = await CustMeth().pickthedate(context);
              setState(() {});
              if (_start != null) {
                if (_start!.isAfter(_end!)) {
                  _cont.custsnakg(validmanner);
                }
              }
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
