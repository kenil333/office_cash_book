import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class OtpScreen extends StatefulWidget {
  final String what;
  final String phonestring;
  const OtpScreen({
    Key? key,
    required this.what,
    required this.phonestring,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _bloc = LoadingBloc();
  final _credcont = Get.put(CredentialGet());
  String _pen = "null";

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then(
      (_) {
        _credcont.sendotpget(
          widget.phonestring,
        );
      },
    );

    super.initState();
  }

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
        title: const Text("$confirm OTP"),
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
            const SizedBox(height: 50),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              style: const TextStyle(fontSize: 20, color: txtcol),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              keyboardType: TextInputType.number,
              otpFieldStyle: OtpFieldStyle(
                focusBorderColor: prim,
                borderColor: gry,
              ),
              onCompleted: (pin) {
                _bloc.loadingsink.add(true);
                _credcont.confirmotpget(
                  pin,
                  () {
                    _pen = pin;
                    setState(() {});
                    _bloc.loadingsink.add(false);
                    if (widget.what == register) {
                      Navigator.of(context).pop();
                      CustMeth().replash(
                        context,
                        RegisterScreen(phonestring: widget.phonestring),
                      );
                    } else {
                      Navigator.of(context).pop();
                      CustMeth().replash(
                        context,
                        ChangepassScreen(phonestring: widget.phonestring),
                      );
                    }
                  },
                  () {
                    _bloc.loadingsink.add(false);
                  },
                );
              },
            ),
            const SizedBox(height: 80),
            StreamBuilder<bool>(
              initialData: false,
              stream: _bloc.loadingstrim,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: prim),
                  );
                } else {
                  return Custbutton(
                    title: confirm,
                    size: size,
                    custbutfunc: () {
                      if (_pen != "null") {
                        _bloc.loadingsink.add(true);
                        _credcont.confirmotpget(
                          _pen,
                          () {
                            _bloc.loadingsink.add(false);
                            if (widget.what == register) {
                              Navigator.of(context).pop();
                              CustMeth().replash(
                                context,
                                RegisterScreen(phonestring: widget.phonestring),
                              );
                            } else {
                              Navigator.of(context).pop();
                              CustMeth().replash(
                                context,
                                ChangepassScreen(
                                    phonestring: widget.phonestring),
                              );
                            }
                          },
                          () {
                            _bloc.loadingsink.add(false);
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
