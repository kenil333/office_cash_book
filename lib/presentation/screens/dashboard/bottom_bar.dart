import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../domain/all.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController tabcontroller;
    tabcontroller = PersistentTabController(initialIndex: 0);
    List<Widget> screensofbar = [
      const DashboardScreen(),
      const PdfGeneratorScreen(),
      const StatisticsScreen(),
      const ProfileScreen(),
    ];

    List<PersistentBottomNavBarItem> _navbaritems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          title: (AppString.home),
          activeColorPrimary: AppColor.prim,
          inactiveColorPrimary: AppColor.gry,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.picture_as_pdf_outlined),
          title: (AppString.pdf),
          activeColorPrimary: AppColor.prim,
          inactiveColorPrimary: AppColor.gry,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.analytics_outlined),
          title: (AppString.statistics),
          activeColorPrimary: AppColor.prim,
          inactiveColorPrimary: AppColor.gry,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: (AppString.profile),
          activeColorPrimary: AppColor.prim,
          inactiveColorPrimary: AppColor.gry,
        ),
      ];
    }

    return Scaffold(
      backgroundColor: AppColor.screenback,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColor.prim,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
        ),
      ),
      body: PersistentTabView(
        context,
        controller: tabcontroller,
        screens: screensofbar,
        items: _navbaritems(),
        confineInSafeArea: true,
        backgroundColor: AppColor.whit,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: AppColor.whit,
          boxShadow: [
            BoxShadow(
              color: AppColor.txtcol,
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
