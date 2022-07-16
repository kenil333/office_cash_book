import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class Etrphonescreen extends StatefulWidget {
  final String what;
  const Etrphonescreen({
    Key? key,
    required this.what,
  }) : super(key: key);

  @override
  State<Etrphonescreen> createState() => _EtrphonescreenState();
}

class _EtrphonescreenState extends State<Etrphonescreen> {
  final _loading = BoolStream();
  final CredentialGet _credcont = Get.find();
  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.screenback,
      appBar: AppBar(
        title: const Text("${AppString.confirm} ${AppString.phonenumber}"),
        backgroundColor: AppColor.screenback,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        foregroundColor: AppColor.txtcol,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Imagewid(size: size),
            const SizedBox(height: 40),
            TextfeildIcon(
              controller: _phone,
              size: size,
              title: AppString.phonenumber,
              icon: Icons.phone,
            ),
            const SizedBox(height: 40),
            StreamBuilder<bool>(
              stream: _loading.stream,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: AppColor.prim),
                  );
                } else {
                  return Custbutton(
                    title: AppString.continu,
                    size: size,
                    custbutfunc: () {
                      _loading.sink.add(true);
                      if (widget.what == AppString.register) {
                        _credcont.checkphoneget(
                          _phone.text,
                          () {
                            _loading.sink.add(false);
                            CustMeth().onlypu(
                              context,
                              OtpScreen(
                                what: widget.what,
                                phonestring: _phone.text,
                              ),
                            );
                          },
                          () {
                            _loading.sink.add(false);
                            _credcont.custsnak(AlertString.phoneninused);
                          },
                        );
                      } else {
                        _credcont.checkphoneget(
                          _phone.text,
                          () {
                            _loading.sink.add(false);
                            _credcont.custsnak(AlertString.phonenotinused);
                          },
                          () {
                            _loading.sink.add(false);
                            CustMeth().onlypu(
                              context,
                              OtpScreen(
                                what: widget.what,
                                phonestring: _phone.text,
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
