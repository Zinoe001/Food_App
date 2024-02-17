import 'package:flutter/material.dart';
import 'package:food_app/core/utils/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.move, this.onTap});
  final bool move;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: move ? AppColors.kPrimaryColor : AppColors.kGrey.shade100,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate,
          alignment: move ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.kWhite),
            ),
          ),
        ),
      ),
    );
  }
}
