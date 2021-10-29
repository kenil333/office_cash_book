import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class AddStatmentScreen extends StatefulWidget {
  final String compname;
  const AddStatmentScreen({Key? key, required this.compname}) : super(key: key);

  @override
  State<AddStatmentScreen> createState() => _AddStatmentScreenState();
}

class _AddStatmentScreenState extends State<AddStatmentScreen> {
  final _cont = Get.put(GlobalGet());
  final _bloc = LoadingBloc();
  DateTime? _date;

  @override
  void dispose() {
    _bloc.dispose();
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
      backgroundColor: screenback,
      appBar: AppBar(
        title: const Text("Add Statement"),
        backgroundColor: prim,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
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
                        title: emount,
                        icon: Icons.date_range_rounded,
                      ),
                      TextfeildIcon(
                        controller: _cont.aremarkcont,
                        size: size,
                        title: remark,
                        icon: Icons.date_range_rounded,
                      ),
                      Datechoose(
                        size: size,
                        title: "Choose Date",
                        date: _date,
                        datefunc: () async {
                          _date = await CustMeth().pickthedate(context);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              width: size.width,
              child: StreamBuilder<bool>(
                initialData: false,
                stream: _bloc.loadingstrim,
                builder: (context, snapshot) {
                  if (snapshot.data!) {
                    return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: prim),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Halfbutton(
                          size: size,
                          color: butred,
                          title: debit,
                          halfunc: () {
                            _bloc.loadingsink.add(true);
                            if (_date == null) {
                              _cont.custsnakg(allfeildsmandotory);
                              _bloc.loadingsink.add(false);
                            } else {
                              _cont.addstatmentget(
                                _date,
                                true,
                                () {
                                  _bloc.loadingsink.add(false);
                                  _showconfimpromp(size);
                                },
                                () {
                                  _bloc.loadingsink.add(false);
                                },
                              );
                            }
                          },
                        ),
                        Halfbutton(
                          size: size,
                          color: butgreen,
                          title: credit,
                          halfunc: () {
                            _bloc.loadingsink.add(true);
                            if (_date == null) {
                              _cont.custsnakg(allfeildsmandotory);
                              _bloc.loadingsink.add(false);
                            } else {
                              _cont.addstatmentget(
                                _date,
                                false,
                                () {
                                  _bloc.loadingsink.add(false);
                                  _showconfimpromp(size);
                                },
                                () {
                                  _bloc.loadingsink.add(false);
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
    );
  }
}
