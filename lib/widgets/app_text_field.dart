import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/core/constants/text_style.dart';
import 'package:food_app/core/extensions/extensions.dart';
import 'package:food_app/core/utils/colors.dart';
import 'package:food_app/core/utils/text.dart';
import 'package:food_app/models/app_textfield_state.dart';

class AppTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String value)? validator;
  final List<TextInputFormatter> formatter;
  final TextInputType? keyboardType;
  final FocusNode focusNode;
  final int maxLines;
  late final ValueNotifier<AppTextFieldState> formState;

  AppTextField({
    Key? key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.maxLines = 1,
    this.formatter = const [],
    FocusNode? focusNode,
    ValueNotifier<AppTextFieldState>? formState,
  })  : focusNode = focusNode ?? FocusNode(),
        formState = formState ??
            ValueNotifier<AppTextFieldState>(
              AppTextFieldState.defaultValue(),
            ),
        super(key: key);
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscure;
  late ValueNotifier<bool> hasFocus = ValueNotifier<bool>(false);
  late ValueNotifier<String?> errorState = ValueNotifier<String?>(null);

  @override
  void initState() {
    obscure = widget.isPassword;
    widget.focusNode.addListener(() {
      hasFocus.value = widget.focusNode.hasFocus;
    });
    super.initState();
  }

  toggleVisibility() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
        valueListenable: errorState,
        builder: (context, errorMessage, _) {
          return ValueListenableBuilder<bool>(
              valueListenable: hasFocus,
              builder: (context, hasFocus, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.regular(
                      widget.title,
                      color: errorMessage == null
                          ? AppColors.kPrimaryColor
                          : Colors.red,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      // height: 56,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: hasFocus
                                ? errorMessage == null
                                    ? AppColors.kPrimaryColor
                                    : Colors.red
                                : AppColors.kWhite.shade200,
                            width: 1,
                          ),
                          color: AppColors.kGrey.shade50,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: widget.controller,
                        keyboardType: widget.keyboardType,
                        obscureText: widget.isPassword,
                        focusNode: widget.focusNode,
                        maxLines: widget.maxLines,
                        inputFormatters: widget.formatter,
                        style: regularStyle.copyWith(
                            color: AppColors.kBlack.shade800),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: widget.hintText,
                          hintStyle: regularStyle.copyWith(
                              color: errorMessage == null
                                  ? AppColors.kBlack.shade800
                                  : Colors.red),
                          suffixIcon: widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                    obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility,
                                    color: errorMessage == null
                                        ? AppColors.kPrimaryColor
                                        : Colors.red,
                                  ),
                                  onPressed: toggleVisibility,
                                )
                              : null,
                          contentPadding: widget.isPassword
                              ? const EdgeInsets.only(left: 8, top: 12)
                              : const EdgeInsets.only(left: 8),
                        ),
                        validator: (value) {
                          errorState.value = null;
                          String? error;
                          // if (value != null && value.isEmpty) {
                          //   error = "cannot be empty";
                          // }
                          if (widget.validator != null) {
                            error = widget.validator!(value!);
                          }
                          errorState.value = error;
                          return null;
                          // return error;
                        },
                      ),
                    ),
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: AppText.caption(
                          errorMessage.isEmpty
                              ? errorMessage
                              : errorMessage.capitalize(),
                          color: Colors.red,
                        ),
                      )
                  ],
                );
              });
        });
  }
}
