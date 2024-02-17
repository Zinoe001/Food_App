import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/colors.dart';
import 'package:food_app/core/utils/text.dart';
import 'package:food_app/views/onboarding/view_model/splash_view_model.dart';

final _splashViewModel =
    ChangeNotifierProvider.autoDispose<SplashViewModel>((ref) {
  return SplashViewModel();
});

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3), ref.read(_splashViewModel).initialise);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundColor: AppColors.kPrimaryColor,
          child: AppText.heading1(
            "FOOD",
            color: AppColors.kWhite,
          ),
        ),
      ),
    );
  }
}
