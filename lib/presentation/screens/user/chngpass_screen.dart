import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class ChangepassScreen extends StatefulWidget {
  final String phonestring;
  const ChangepassScreen({
    Key? key,
    required this.phonestring,
  }) : super(key: key);

  @override
  State<ChangepassScreen> createState() => _ChangepassScreenState();
}

class _ChangepassScreenState extends State<ChangepassScreen> {
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
        title: const Text("Change Password"),
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
              controller: _credcont.fpasscont,
              size: size,
              title: AppString.password,
              icon: Icons.lock_outline,
            ),
            TextfeildIcon(
              controller: _credcont.fpassconfcont,
              size: size,
              title: AppString.confpassword,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 40),
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
                    title: AppString.confirm,
                    size: size,
                    custbutfunc: () {
                      _loading.sink.add(true);
                      _credcont.forgotpassget(
                        widget.phonestring,
                        () {
                          Navigator.of(context).pop();
                          _loading.sink.add(false);
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
