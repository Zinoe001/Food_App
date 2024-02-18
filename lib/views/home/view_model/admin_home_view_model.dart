
import 'package:food_app/core/constants/routing_path.dart';
import 'package:food_app/core/services/navigation.dart';
import 'package:food_app/widgets/base_viewmodel.dart';

class AdminHomeViewModel extends BaseViewModel {
  NavigationService navigationService = NavigationService.instance;
  createMenu() {
    navigationService.navigateToReplace(NavigatorRoutes.menuDetailView);
  }
}
