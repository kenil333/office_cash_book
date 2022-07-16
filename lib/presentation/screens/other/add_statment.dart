import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class AddStatmentScreen extends StatefulWidget {
  final String compname;
  const AddStatmentScreen({Key? key, required this.compname}) : super(key: key);

  @override
  State<AddStatmentScreen> createState() => _AddStatmentScreenState();
}

class _AddStatmentScreenState extends State<AddStatmentScreen> {
  final GlobalGet _cont = Get.find();
  final _loading = BoolStream();
  final _date = DateTimeStream();

  @override
  void dispose() {
    _loading.dispose();
    _date.dispose();
    super.dispose();
  }

  _showconfimpromp(Size size) {
    Timer(
      const Duration(milliseconds: 1500),
      () {
        Navigator.of(context).pop();
      },
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: size.height * 0.3,
          child: Image.asset(
            'assets/images/abc.gif',
            fit: BoxFit.contain,
          ),
        ),
      ),
    ).then((_) {
      Timer(
        const Duration(seconds: 0),
        () {
          Navigator.of(context).pop();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.screenback,
      appBar: AppBar(
        title: const Text("Add Statement"),
        backgroundColor: AppColor.prim,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<DateTime?>(
        stream: _date.stream,
        initialData: null,
        builder: (context, datesnap) => Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        TextfeildIcon(
                          controller: _cont.aamountcont,
                          size: size,
                          title: AppString.emount,
                          icon: Icons.date_range_rounded,
                        ),
                        TextfeildIcon(
                          controller: _cont.aremarkcont,
                          size: size,
                          title: AppString.remark,
                          icon: Icons.date_range_rounded,
                        ),
                        Datechoose(
                          size: size,
                          title: "Choose Date",
                          date: datesnap.data,
                          datefunc: () async {
                            _date.sink
                                .add(await CustMeth().pickthedate(context));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 15,
              child: SizedBox(
                width: size.width,
                child: StreamBuilder<bool>(
                  initialData: false,
                  stream: _loading.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data!) {
                      return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(color: AppColor.prim),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Halfbutton(
                            size: size,
                            color: AppColor.butred,
                            title: AppString.debit,
                            halfunc: () {
                              _loading.sink.add(true);
                              if (datesnap.data == null) {
                                _cont.custsnakg(AlertString.allfeildsmandotory);
                                _loading.sink.add(false);
                              } else {
                                _cont.addstatmentget(
                                  datesnap.data,
                                  true,
                                  () {
                                    _loading.sink.add(false);
                                    _showconfimpromp(size);
                                  },
                                  () {
                                    _loading.sink.add(false);
                                  },
                                );
                              }
                            },
                          ),
                          Halfbutton(
                            size: size,
                            color: AppColor.butgreen,
                            title: AppString.credit,
                            halfunc: () {
                              _loading.sink.add(true);
                              if (datesnap.data == null) {
                                _cont.custsnakg(AlertString.allfeildsmandotory);
                                _loading.sink.add(false);
                              } else {
                                _cont.addstatmentget(
                                  datesnap.data,
                                  false,
                                  () {
                                    _loading.sink.add(false);
                                    _showconfimpromp(size);
                                  },
                                  () {
                                    _loading.sink.add(false);
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
