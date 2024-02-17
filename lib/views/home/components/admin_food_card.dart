import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/services/order_service.dart';
import 'package:food_app/core/utils/text.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/widgets/custom_switch.dart';

class AdminFoodCard extends ConsumerStatefulWidget {
  const AdminFoodCard({
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
  ConsumerState<AdminFoodCard> createState() => _AdminFoodCardState();
}

class _AdminFoodCardState extends ConsumerState<AdminFoodCard> {
  late bool isAvailable = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 125,
          width: 125,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Image.file(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable:
                          ref.read(orderServiceProvider).selectedOrder,
                      builder:
                          (BuildContext context, FoodModel selectedOrder, _) {
                        var orderService = ref.read(orderServiceProvider);
                        return CustomSwitch(
                          move: isAvailable,
                          onTap: () {
                            setState(() {
                              print(isAvailable);
                              isAvailable = !isAvailable;
                              print(isAvailable);
                            });
                            print(orderService.order);
                            isAvailable
                                ? orderService.addOrder(
                                    FoodModel(
                                      image: widget.image,
                                      name: widget.name,
                                      description: widget.description,
                                      price: widget.price,
                                    ),
                                  )
                                : orderService.removeOrder(
                                    FoodModel(
                                      image: widget.image,
                                      name: widget.name,
                                      description: widget.description,
                                      price: widget.price,
                                    ),
                                  );

                            print(orderService.order);
                            setState(() {
                              orderService.order;
                            });
                          },
                        );
                      }),
                  const SizedBox(width: 8),
                  isAvailable
                      ? AppText.medium("Available")
                      : AppText.medium("Unavailable"),
                ],
              ),
              const SizedBox(height: 4),
              AppText.heading4(widget.name),
              const SizedBox(height: 4),
              AppText.small(
                widget.description,
                maxLines: 3,
              ),
              const SizedBox(height: 4),
              AppText.medium("N${widget.price}"),
            ],
          ),
        )
      ],
    );
  }
}
