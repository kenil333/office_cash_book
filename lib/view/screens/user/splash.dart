import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _credcont = Get.put(CredentialGet());
  final _cont = Get.put(GlobalGet());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then(
      (_) {
        _credcont.autologinget(
          (
            bool lead,
            String comp,
            String pho,
            String na,
          ) {
            _cont.changeuserdata(lead, comp, pho, na);
            CustMeth().replash(
              context,
              const BottomBar(),
            );
          },
          () {
            CustMeth().replash(
              context,
              const LoginScreen(),
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: prim,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
        ),
        preferredSize: const Size.fromHeight(0),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              prim,
              primlow,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                color: whit,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                    color: txtcol.withOpacity(0.23),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.15),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
