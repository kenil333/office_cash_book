import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

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
  final _bloc = LoadingBloc();
  final _credcont = Get.put(CredentialGet());
  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        title: const Text("$confirm $phonenumber"),
        backgroundColor: screenback,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        foregroundColor: txtcol,
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
              title: phonenumber,
              icon: Icons.phone,
            ),
            const SizedBox(height: 40),
            StreamBuilder<bool>(
              stream: _bloc.loadingstrim,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: prim),
                  );
                } else {
                  return Custbutton(
                    title: continu,
                    size: size,
                    custbutfunc: () {
                      _bloc.loadingsink.add(true);
                      if (widget.what == register) {
                        _credcont.checkphoneget(
                          _phone.text,
                          () {
                            _bloc.loadingsink.add(false);
                            CustMeth().onlypu(
                              context,
                              OtpScreen(
                                what: widget.what,
                                phonestring: _phone.text,
                              ),
                            );
                          },
                          () {
                            _bloc.loadingsink.add(false);
                            _credcont.custsnak(phoneninused);
                          },
                        );
                      } else {
                        _credcont.checkphoneget(
                          _phone.text,
                          () {
                            _bloc.loadingsink.add(false);
                            _credcont.custsnak(phonenotinused);
                          },
                          () {
                            _bloc.loadingsink.add(false);
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
