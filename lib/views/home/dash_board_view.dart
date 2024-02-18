import 'package:flutter/material.dart';
import 'package:food_app/core/constants/text_style.dart';
import 'package:food_app/core/utils/colors.dart';
import 'package:food_app/views/home/admin_home_page.dart';
import 'package:food_app/views/home/user_home_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home_rounded,
        ),
        inactiveIcon: const Icon(
          Icons.home_outlined,
        ),
        title: ("Admin"),
        activeColorPrimary: AppColors.kPrimaryColor.withOpacity(0.3),
        // activeColorSecondary: AppColors.black,
        inactiveColorPrimary: AppColors.kGrey.shade800,
        textStyle: buttonStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.kWhite,
        ),
      ),
     PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home_rounded,
        ),
        inactiveIcon: const Icon(
          Icons.home_outlined,
        ),
        title: ("User"),
        activeColorPrimary: AppColors.kPrimaryColor.withOpacity(0.3),
        // activeColorSecondary: AppColors.black,
        inactiveColorPrimary: AppColors.kGrey.shade500,
        textStyle: smallStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.kWhite,
        ),
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
       AdminHomeView(),
       UserHomeView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      navBarHeight: 64,
      screens: _buildScreens(),
      items: _navBarsItems(),
      // confineInSafeArea: true,
      // padding: const NavBarPadding.symmetric(
      //   horizontal: 28,
      //   vertical: 10.5,
      // ),
      // backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(10.0),
      //   colorBehindNavBar: Colors.white,
      // ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style7, // Choose the nav bar style with this property.
    );
  }
}
