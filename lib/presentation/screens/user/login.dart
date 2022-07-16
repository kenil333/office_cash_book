import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final CredentialGet _credcont = Get.find();
  final GlobalGet _cont = Get.find();
  final _loading = BoolStream();

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColor.screenback,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Imagewid(size: size),
              ),
              const SizedBox(height: 40),
              TextfeildIcon(
                controller: _credcont.lphonecont,
                size: size,
                title: AppString.phonenumber,
                icon: Icons.phone,
              ),
              TextfeildIcon(
                controller: _credcont.lpasscont,
                size: size,
                title: AppString.password,
                icon: Icons.lock_outline,
              ),
              Customtxtbut(
                size: size,
                title: "${AppString.forgot} ${AppString.password} !",
                txtfunc: () {
                  CustMeth().onlypu(
                    context,
                    const Etrphonescreen(
                      what: AppString.forgot,
                    ),
                  );
                },
                align: Alignment.centerRight,
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
                      title: AppString.login,
                      size: size,
                      custbutfunc: () {
                        _loading.sink.add(true);
                        _credcont.loginget(
                          (
                            bool leadl,
                            String companyl,
                            String phonel,
                            String namel,
                          ) {
                            _cont.changeuserdata(
                              leadl,
                              companyl,
                              phonel,
                              namel,
                            );
                            _loading.sink.add(false);
                            CustMeth().replash(context, const BottomBar());
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
              Customtxtbut(
                size: size,
                title: "${AppString.register} the ${AppString.company}",
                txtfunc: () {
                  CustMeth().onlypu(
                    context,
                    const Etrphonescreen(
                      what: AppString.register,
                    ),
                  );
                },
                align: Alignment.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
