
import 'package:food_app/core/constants/routing_path.dart';
import 'package:food_app/core/services/navigation.dart';
import 'package:food_app/widgets/base_viewmodel.dart';

class SplashViewModel extends BaseViewModel {
  NavigationService navigationService = NavigationService.instance;
  initialise() {
    navigationService.navigateToReplace(NavigatorRoutes.dashBoardView);
  }
}
