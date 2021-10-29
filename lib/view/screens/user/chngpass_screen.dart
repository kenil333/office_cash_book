import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

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
        title: const Text("Change Password"),
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
              controller: _credcont.fpasscont,
              size: size,
              title: password,
              icon: Icons.lock_outline,
            ),
            TextfeildIcon(
              controller: _credcont.fpassconfcont,
              size: size,
              title: confpassword,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 40),
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
                      _bloc.loadingsink.add(true);
                      _credcont.forgotpassget(
                        widget.phonestring,
                        () {
                          Navigator.of(context).pop();
                          _bloc.loadingsink.add(false);
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
