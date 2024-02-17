import 'package:flutter/material.dart';
import 'package:food_app/core/constants/routing_path.dart';
import 'package:food_app/views/home/admin_home_page.dart';
import 'package:food_app/views/home/dash_board_view.dart';
import 'package:food_app/views/home/user_home_page.dart';
import 'package:food_app/views/menu/menu_details_view.dart';
// import 'package:logistics_app/core/constants/routing_path.dart';

class AppRouter {
  static PageRoute _getPageRoute({
    required RouteSettings settings,
    required Widget viewToShow,
  }) {
    return MaterialPageRoute(
        builder: (context) => viewToShow, settings: settings);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Map<String, dynamic> routeArgs = settings.arguments != null
    //     ? settings.arguments as Map<String, dynamic>
    //     : {};

    switch (settings.name) {
       case NavigatorRoutes.dashBoardView:
        return _getPageRoute(
          settings: settings,
          viewToShow: const DashBoardView(),
        );
      case NavigatorRoutes.adminHomeView:
        return _getPageRoute(
          settings: settings,
          viewToShow: AdminHomeView(),
        );
      case NavigatorRoutes.userHomeView:
        return _getPageRoute(
          settings: settings,
          viewToShow: const UserHomeView(),
        );
      case NavigatorRoutes.menuDetailView:
        return _getPageRoute(
          settings: settings,
          viewToShow: const MenuDetailView(),
        );
      default:
        return _getPageRoute(
          settings: settings,
          viewToShow: const Scaffold(),
        );
    }
  }
}
