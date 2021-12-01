import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import './../../../controller/common/all.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _screensofbar = [
      const DashboardScreen(),
      const PdfGeneratorScreen(),
      const StatisticsScreen(),
      const ProfileScreen(),
    ];

    List<PersistentBottomNavBarItem> _navbaritems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          title: (home),
          activeColorPrimary: prim,
          inactiveColorPrimary: gry,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.picture_as_pdf_outlined),
          title: (pdf),
          activeColorPrimary: prim,
          inactiveColorPrimary: gry,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.analytics_outlined),
          title: (statistics),
          activeColorPrimary: prim,
          inactiveColorPrimary: gry,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: (profile),
          activeColorPrimary: prim,
          inactiveColorPrimary: gry,
        ),
      ];
    }

    return Scaffold(
      backgroundColor: screenback,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: prim,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
        ),
        preferredSize: const Size.fromHeight(0),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _screensofbar,
        items: _navbaritems(),
        confineInSafeArea: true,
        backgroundColor: whit,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: whit,
          boxShadow: [
            BoxShadow(
              color: txtcol,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
