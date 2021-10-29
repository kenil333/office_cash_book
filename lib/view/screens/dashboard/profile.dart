import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';

import './../../../controller/common/all.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _cont = Get.put(GlobalGet());
    return Column(
      children: [
        PersonWid(
          size: size,
          name: _cont.namerx.value,
          number: _cont.phonerx.value,
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
          decoration: containerdeco,
          child: Column(
            children: [
              SimpleBut(
                size: size,
                icon: Icons.analytics_outlined,
                title: team,
                butfunc: () {
                  pushNewScreen(
                    context,
                    screen: TeamScreen(
                      comp: _cont.compayrx.value,
                      lead: _cont.leaderx.value,
                      phonefrm: _cont.phonerx.value,
                    ),
                    withNavBar: false,
                  );
                },
              ),
              const Divider(color: txtcol),
              SimpleBut(
                size: size,
                icon: Icons.logout_outlined,
                title: logout,
                butfunc: () {
                  _cont.logoutget(() {
                    Navigator.of(context).pop();
                    pushNewScreen(
                      context,
                      screen: const LoginScreen(),
                      withNavBar: false,
                    );
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
