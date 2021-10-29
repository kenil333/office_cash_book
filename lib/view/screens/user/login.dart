import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _credcont = Get.put(CredentialGet());
  final _cont = Get.put(GlobalGet());
  final _bloc = LoadingBloc();

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
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: screenback,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
        ),
        preferredSize: const Size.fromHeight(0),
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
                title: phonenumber,
                icon: Icons.phone,
              ),
              TextfeildIcon(
                controller: _credcont.lpasscont,
                size: size,
                title: password,
                icon: Icons.lock_outline,
              ),
              Customtxtbut(
                size: size,
                title: "$forgot $password !",
                txtfunc: () {
                  CustMeth().onlypu(
                    context,
                    const Etrphonescreen(
                      what: forgot,
                    ),
                  );
                },
                align: Alignment.centerRight,
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
                      title: login,
                      size: size,
                      custbutfunc: () {
                        _bloc.loadingsink.add(true);
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
                            _bloc.loadingsink.add(false);
                            CustMeth().replash(context, const BottomBar());
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
              Customtxtbut(
                size: size,
                title: "$register the $company",
                txtfunc: () {
                  CustMeth().onlypu(
                    context,
                    const Etrphonescreen(
                      what: register,
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
