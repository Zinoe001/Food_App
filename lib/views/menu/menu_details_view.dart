import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/routing_path.dart';
import 'package:food_app/core/services/menu_service.dart';
import 'package:food_app/core/services/navigation.dart';
import 'package:food_app/core/utils/colors.dart';
import 'package:food_app/core/utils/text.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/widgets/app_text_field.dart';
// import 'package:food_app/widgets/loader_page.dart';
import 'package:image_picker/image_picker.dart';

class MenuDetailView extends ConsumerStatefulWidget {
  const MenuDetailView({super.key});

  @override
  ConsumerState<MenuDetailView> createState() => _MenuDetailViewState();
}

class _MenuDetailViewState extends ConsumerState<MenuDetailView> {
  NavigationService navigationService = NavigationService.instance;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  File? _selectedImage;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: Container(
                    height: 275,
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Icon(
                              Icons.image,
                              size: 52,
                              color: AppColors.kGrey.shade700,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  title: "Name",
                  controller: _nameController,
                  hintText: "Eba and Egusi",
                ),
                const SizedBox(height: 8),
                AppTextField(
                  title: "Decription",
                  controller: _descriptionController,
                  hintText: "Sed ut perspiciatis unde omnis to....",
                ),
                const SizedBox(height: 8),
                AppTextField(
                  title: "Price",
                  controller: _priceController,
                  hintText: "N500",
                  keyboardType: TextInputType.number,
                  formatter: [NairaInputFormatter()],
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder(
                    valueListenable: ref.read(menuServiceProvider).selectedMenu,
                    builder: (BuildContext context, FoodModel selectedMenu, _) {
                      var menuService = ref.read(menuServiceProvider);
                      return GestureDetector(
                        onTap: () {
                          menuService.addMenu(
                            FoodModel(
                              image: _selectedImage!,
                              name: _nameController.text,
                              description: _descriptionController.text,
                              price: _priceController.text,
                            ),
                          );
                          navigationService
                              .navigateToReplace(NavigatorRoutes.dashBoardView);
                        },
                        child: Container(
                          height: 56,
                          width: 175,
                          decoration: BoxDecoration(
                            color: AppColors.kSecondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: AppText.button("Save",color: AppColors.kWhite,),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NairaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // // Add a dollar sign at the beginning of the entered value
    // if (newValue.text.isNotEmpty && !newValue.text.startsWith('\$')) {
    //   return TextEditingValue(
    //     text: '\$${newValue.text}',
    //     selection: const TextSelection.collapsed(offset: '\$'.length),
    //   );

    if (newValue.text.startsWith('N')) {
      return newValue; // Don't modify if already starts with '$'
    }

    final int newTextLength = newValue.text.length;

    // If the new text is empty, do nothing
    if (newTextLength == 0) {
      return newValue;
    }

    // Add the dollar sign and move the cursor after the text
    final String newText = 'N${newValue.text}';
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
