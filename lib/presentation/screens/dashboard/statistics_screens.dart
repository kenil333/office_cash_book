import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final _start = DateTimeStream();
  final _end = DateTimeStream();

  @override
  void dispose() {
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final GlobalGet globalcontroller = Get.find();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            AppString.statistics,
            style: TextStyle(
              fontSize: size.width * 0.06,
              color: AppColor.txtcol,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder<DateTime?>(
            stream: _start.stream,
            initialData: null,
            builder: (context, startsnap) => StreamBuilder<DateTime?>(
              stream: _end.stream,
              initialData: null,
              builder: (context, endsnap) => Column(
                children: [
                  BalanceWid(
                    size: size,
                    title: AppString.credit,
                    amount: globalcontroller
                        .gettotalcredit(startsnap.data, endsnap.data)
                        .toStringAsFixed(2),
                  ),
                  BalanceWid(
                    size: size,
                    title: AppString.debit,
                    amount: globalcontroller
                        .gettotaldebit(startsnap.data, endsnap.data)
                        .toStringAsFixed(2),
                  ),
                  const SizedBox(height: 40),
                  Datechoose(
                    size: size,
                    title: "Starting Date",
                    date: startsnap.data,
                    datefunc: () async {
                      _start.sink.add(await CustMeth().pickthedate(context));
                    },
                  ),
                  Datechoose(
                    size: size,
                    title: "Ending Date",
                    date: endsnap.data,
                    datefunc: () async {
                      _end.sink.add(await CustMeth().pickthedate(context));
                      if (startsnap.data != null && endsnap.data != null) {
                        if (startsnap.data!.isAfter(endsnap.data!)) {
                          globalcontroller.custsnakg(AlertString.validmanner);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
