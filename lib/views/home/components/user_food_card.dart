import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/core/utils/text.dart';

class UserFoodCard extends StatelessWidget {
  const UserFoodCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
  final String name;
  final String description;
  final String price;
  final File image;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
          height: 125,
          width: 125,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Image.file(
            image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              AppText.heading3(name),
              const SizedBox(height: 4),
              AppText.medium(description),
              const SizedBox(height: 4),
              AppText.regular("N$price"),
            ],
          ),
        )
      ],
    );
  }
}
