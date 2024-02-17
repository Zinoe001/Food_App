import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/services/order_service.dart';
import 'package:food_app/core/utils/text.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/views/home/components/user_food_card.dart';

class UserHomeView extends ConsumerStatefulWidget {
  const UserHomeView({super.key});
  @override
  ConsumerState<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends ConsumerState<UserHomeView> {
  @override
  void initState() {
    setState(() {
      ref.read(orderServiceProvider).order;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ref.read(orderServiceProvider).selectedOrder,
        builder: (BuildContext context, FoodModel selectedOrder, _) {
          var orderService = ref.read(orderServiceProvider);
          return Scaffold(
            body: SafeArea(
              top: true,
              child: orderService.order.isEmpty
                  ? Center(
                      child: AppText.regular("No Order is availabe"),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            ...List.generate(
                              orderService.order.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: UserFoodCard(
                                  image: orderService.order[index].image,
                                  name: orderService.order[index].name,
                                  description:
                                      orderService.order[index].description,
                                  price: orderService.order[index].price,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}
