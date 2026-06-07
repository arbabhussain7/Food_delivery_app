import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_bloc.dart';
import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';
import 'package:food_delivery_app/features/menu/presetations/widgets/qty_button.dart';
import 'package:food_delivery_app/features/orders/domain/entities/cart_item.dart';

class MenuProductCard extends StatelessWidget {
  final ProductEntity product;
  const MenuProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.v),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12.adaptSize),
        boxShadow: [
          BoxShadow(
            color: blackColor.withAlpha(20),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10.adaptSize),
            child: Image.network(
              product.imageUrl,
              width: 96.h,
              height: 96.v,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: 96.h,
                  height: 96.v,
                  color: greyColor.withAlpha(30),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (_, _, _) => Container(
                width: 96.h,
                height: 96.v,
                color: greyColor.withAlpha(30),
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: greyColor,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.h),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.itemName,
                  style: AppTextStyle.cTextStyle.copyWith(color: blackColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.v),
                Text(
                  '${product.restaurantName} • ${product.deliveryTime}',
                  style: AppTextStyle.fTextStyle.copyWith(
                    color: blackColor.withAlpha(120),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.v),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 14,
                    ),
                    SizedBox(width: 3.h),
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: AppTextStyle.fTextStyle.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.h,
                        vertical: 2.v,
                      ),
                      decoration: BoxDecoration(
                        color: greyColor.withAlpha(40),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.category,
                        style: AppTextStyle.fTextStyle.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.v),

                // Price + Add/Remove button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyle.bTextStyle.copyWith(
                        color: blackColor,
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, cartState) {
                        final inCart = cartState.containsProduct(product.id);
                        final qty =
                            cartState.itemFor(product.id)?.quantity ?? 0;

                        return inCart
                            ? Row(
                                children: [
                                  QtyButton(
                                    icon: Icons.remove,
                                    color: Colors.red.shade400,
                                    onTap: () {
                                      if (qty <= 1) {
                                        context.read<CartBloc>().add(
                                          CartItemRemoved(product.id),
                                        );
                                      } else {
                                        context.read<CartBloc>().add(
                                          CartItemQuantityUpdated(
                                            productId: product.id,
                                            quantity: qty - 1,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.h,
                                    ),
                                    child: Text(
                                      '$qty',
                                      style: AppTextStyle.cTextStyle.copyWith(
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                  QtyButton(
                                    icon: Icons.add,
                                    color: primaryColor,
                                    onTap: () => context.read<CartBloc>().add(
                                      CartItemQuantityUpdated(
                                        productId: product.id,
                                        quantity: qty + 1,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () => context.read<CartBloc>().add(
                                  CartItemAdded(
                                    CartItem(
                                      product: product,
                                      quantity: 1,
                                      isExtraCheeseSelected: false,
                                      isNoOnionsSelected: false,
                                      isCrispyBaconSelected: false,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.h,
                                    vertical: 8.v,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.adaptSize,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: AppTextStyle.fTextStyle.copyWith(
                                    color: whiteColor,
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
