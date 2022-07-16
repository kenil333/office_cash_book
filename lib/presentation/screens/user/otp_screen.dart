import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

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
  final CredentialGet _credcont = Get.find();
  final _penstream = StringStream();

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
    _penstream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.screenback,
      appBar: AppBar(
        title: const Text("${AppString.confirm} OTP"),
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
            const SizedBox(height: 50),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              style: const TextStyle(fontSize: 20, color: AppColor.txtcol),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              keyboardType: TextInputType.number,
              otpFieldStyle: OtpFieldStyle(
                focusBorderColor: AppColor.prim,
                borderColor: AppColor.gry,
              ),
              onCompleted: (pin) {
                _credcont.loadingotp.value = true;
                _credcont.confirmotpget(
                  pin,
                  () {
                    _penstream.sink.add(pin);
                    _credcont.loadingotp.value = false;
                    if (widget.what == AppString.register) {
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
                    _credcont.loadingotp.value = false;
                  },
                );
              },
              onChanged: (String value) {},
            ),
            const SizedBox(height: 80),
            StreamBuilder<String?>(
              stream: _penstream.stream,
              initialData: null,
              builder: (context, pensnap) => _credcont.loadingotp.value
                  ? const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: AppColor.prim),
                    )
                  : Custbutton(
                      title: AppString.confirm,
                      size: size,
                      custbutfunc: () {
                        if (pensnap.data != null) {
                          _credcont.loadingotp.value = true;
                          _credcont.confirmotpget(
                            pensnap.data!,
                            () {
                              _credcont.loadingotp.value = false;
                              if (widget.what == AppString.register) {
                                Navigator.of(context).pop();
                                CustMeth().replash(
                                  context,
                                  RegisterScreen(
                                      phonestring: widget.phonestring),
                                );
                              } else {
                                Navigator.of(context).pop();
                                CustMeth().replash(
                                  context,
                                  ChangepassScreen(
                                    phonestring: widget.phonestring,
                                  ),
                                );
                              }
                            },
                            () {
                              _credcont.loadingotp.value = false;
                            },
                          );
                        }
                      },
                    ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
