import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class RegisterScreen extends StatefulWidget {
  final String phonestring;
  const RegisterScreen({
    Key? key,
    required this.phonestring,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _loading = BoolStream();
  final CredentialGet _credcont = Get.find();

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
        automaticallyImplyLeading: false,
        title: const Text(AppString.register),
        backgroundColor: AppColor.screenback,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        foregroundColor: AppColor.txtcol,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 18),
            TextfeildIcon(
              controller: _credcont.rcompanycont,
              size: size,
              title: "${AppString.company} ${AppString.name}",
              icon: Icons.app_registration_outlined,
            ),
            TextfeildIcon(
              controller: _credcont.rnamecont,
              size: size,
              title: AppString.name,
              icon: Icons.person,
            ),
            TextfeildIcon(
              controller: _credcont.rpasscont,
              size: size,
              title: AppString.password,
              icon: Icons.lock_outline,
            ),
            TextfeildIcon(
              controller: _credcont.rconfpasscont,
              size: size,
              title: AppString.confpassword,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 50),
            StreamBuilder<bool>(
              initialData: false,
              stream: _loading.stream,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: AppColor.prim),
                  );
                } else {
                  return Custbutton(
                    title: AppString.register,
                    size: size,
                    custbutfunc: () {
                      _loading.sink.add(true);
                      _credcont.registerget(
                        widget.phonestring,
                        () {
                          _loading.sink.add(false);
                          Navigator.of(context).pop();
                        },
                        () {
                          _loading.sink.add(false);
                        },
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
