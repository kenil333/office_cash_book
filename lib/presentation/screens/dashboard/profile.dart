import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';

import '../../../domain/all.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final GlobalGet globalcontroller = Get.find();
    return Column(
      children: [
        PersonWid(
          size: size,
          name: globalcontroller.namerx.value,
          number: globalcontroller.phonerx.value,
          persofunc: () {},
        ),
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: size.width * 0.03,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: 15,
          ),
          decoration: ConstDecoration.containerdeco,
          child: Column(
            children: [
              SimpleBut(
                size: size,
                icon: Icons.analytics_outlined,
                title: AppString.team,
                butfunc: () {
                  pushNewScreen(
                    context,
                    screen: TeamScreen(
                      comp: globalcontroller.compayrx.value,
                      lead: globalcontroller.leaderx.value,
                      phonefrm: globalcontroller.phonerx.value,
                    ),
                    withNavBar: false,
                  );
                },
              ),
              const Divider(color: AppColor.txtcol),
              SimpleBut(
                size: size,
                icon: Icons.logout_outlined,
                title: AppString.logout,
                butfunc: () {
                  globalcontroller.logoutget(() {
                    Get.offAll(const LoginScreen());
                    // Navigator.of(context).pop();
                    // pushNewScreen(
                    //   context,
                    //   screen: const LoginScreen(),
                    //   withNavBar: false,
                    // );
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
