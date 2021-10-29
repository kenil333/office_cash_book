import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

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
  final _bloc = LoadingBloc();
  final _credcont = Get.put(CredentialGet());

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
        automaticallyImplyLeading: false,
        title: const Text(register),
        backgroundColor: screenback,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        foregroundColor: txtcol,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 18),
            TextfeildIcon(
              controller: _credcont.rcompanycont,
              size: size,
              title: "$company $name",
              icon: Icons.app_registration_outlined,
            ),
            TextfeildIcon(
              controller: _credcont.rnamecont,
              size: size,
              title: name,
              icon: Icons.person,
            ),
            TextfeildIcon(
              controller: _credcont.rpasscont,
              size: size,
              title: password,
              icon: Icons.lock_outline,
            ),
            TextfeildIcon(
              controller: _credcont.rconfpasscont,
              size: size,
              title: confpassword,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 50),
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
                    title: register,
                    size: size,
                    custbutfunc: () {
                      _bloc.loadingsink.add(true);
                      _credcont.registerget(
                        widget.phonestring,
                        () {
                          _bloc.loadingsink.add(false);
                          Navigator.of(context).pop();
                        },
                        () {
                          _bloc.loadingsink.add(false);
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
