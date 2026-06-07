import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_bloc.dart';
import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/items_view_bloc.dart';
import 'package:food_delivery_app/features/orders/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/items_view_event.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/items_view_state.dart';
import 'package:food_delivery_app/features/home/presentation/widgets/custom_row.dart';
import 'package:food_delivery_app/utiles/custom_button.dart';

class ItemsViewScreen extends StatelessWidget {
  const ItemsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductEntity;

    return BlocProvider(
      create: (_) => ItemsViewBloc(),
      child: _ItemsViewBody(product: product),
    );
  }
}

class _ItemsViewBody extends StatelessWidget {
  final ProductEntity product;
  const _ItemsViewBody({required this.product});

  static const double _extraCheesePrice = 1.50;
  static const double _crispyBaconPrice = 2.00;

  double _totalPrice(ItemsViewState state) {
    double extras = 0;
    if (state.isExtraCheeseSelected) extras += _extraCheesePrice;
    if (state.isCrispyBaconSelected) extras += _crispyBaconPrice;
    return (product.price + extras) * state.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsViewBloc, ItemsViewState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: bgColor.withAlpha(500),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.h,
                      vertical: 15.v,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
                        Text("Details", style: AppTextStyle.cTextStyle),
                        const Icon(
                          Icons.favorite_outline,
                          color: secondaryColor,
                        ),
                      ],
                    ),
                  ),

                  Image.network(
                    product.imageUrl,
                    height: 300.v,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 300.v,
                        color: greyColor.withAlpha(30),
                        child: const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                      );
                    },
                    errorBuilder: (_, _, _) => Container(
                      height: 300.v,
                      color: greyColor.withAlpha(30),
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: greyColor,
                        size: 48,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                product.itemName,
                                style: AppTextStyle.hTextStyle.copyWith(
                                  color: blackColor,
                                ),
                              ),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: AppTextStyle.dTextStyle.copyWith(
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 6.v),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(width: 4.h),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: AppTextStyle.fTextStyle.copyWith(
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8.h),
                            Text(
                              '${product.restaurantName} • ${product.deliveryTime}',
                              style: AppTextStyle.fTextStyle.copyWith(
                                color: greyColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 22.v),
                        Text(
                          "Description",
                          style: AppTextStyle.bTextStyle.copyWith(
                            color: blackColor,
                          ),
                        ),
                        SizedBox(height: 6.v),
                        Text(
                          product.description,
                          textAlign: TextAlign.justify,
                          style: AppTextStyle.fTextStyle.copyWith(
                            color: blackColor.withAlpha(200),
                          ),
                        ),

                        SizedBox(height: 18.v),
                        Text(
                          "Customize Your ${product.category}",
                          style: AppTextStyle.bTextStyle.copyWith(
                            color: blackColor,
                          ),
                        ),
                        SizedBox(height: 6.v),

                        CustomizeOption(
                          label: "Extra Cheese",
                          price: "+\$${_extraCheesePrice.toStringAsFixed(2)}",
                          isSelected: state.isExtraCheeseSelected,
                          onToggle: () => context.read<ItemsViewBloc>().add(
                            const ExtraCheeseToggled(),
                          ),
                        ),

                        SizedBox(height: 6.v),

                        CustomizeOption(
                          label: "No Onions",
                          isSelected: state.isNoOnionsSelected,
                          onToggle: () => context.read<ItemsViewBloc>().add(
                            const NoOnionsToggled(),
                          ),
                        ),

                        SizedBox(height: 6.v),

                        CustomizeOption(
                          label: "Crispy Bacon",
                          price: "+\$${_crispyBaconPrice.toStringAsFixed(2)}",
                          isSelected: state.isCrispyBaconSelected,
                          onToggle: () => context.read<ItemsViewBloc>().add(
                            const CrispyBaconToggled(),
                          ),
                        ),

                        SizedBox(height: 18.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity",
                              style: AppTextStyle.bTextStyle.copyWith(
                                color: blackColor,
                              ),
                            ),
                            Container(
                              width: 154.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.h,
                                vertical: 3.v,
                              ),
                              decoration: BoxDecoration(
                                color: blackColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  55.adaptSize,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => context
                                        .read<ItemsViewBloc>()
                                        .add(const QuantityDecremented()),
                                    child: Container(
                                      padding: EdgeInsets.all(8.adaptSize),
                                      decoration: const BoxDecoration(
                                        color: whiteColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${state.quantity}',
                                    style: AppTextStyle.fTextStyle.copyWith(
                                      color: blackColor,
                                      fontSize: 22.adaptSize,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => context
                                        .read<ItemsViewBloc>()
                                        .add(const QuantityIncremented()),
                                    child: Container(
                                      padding: EdgeInsets.all(8.adaptSize),
                                      decoration: const BoxDecoration(
                                        color: secondaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 22.v),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: whiteColor.withAlpha(600),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 77.h),
              child: CustomButton(
                text:
                    'Add to Cart  —  \$${_totalPrice(state).toStringAsFixed(2)}',
                onPressed: () {
                  context.read<CartBloc>().add(
                    CartItemAdded(
                      CartItem(
                        product: product,
                        quantity: state.quantity,
                        isExtraCheeseSelected: state.isExtraCheeseSelected,
                        isNoOnionsSelected: state.isNoOnionsSelected,
                        isCrispyBaconSelected: state.isCrispyBaconSelected,
                      ),
                    ),
                  );
                  Navigator.pushNamed(context, AppRoutes.ordersScreen);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
