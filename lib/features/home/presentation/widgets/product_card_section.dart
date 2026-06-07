import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.itemsViewScreen,
        arguments: product,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: greyColor.withAlpha(80)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                product.imageUrl,
                height: 200.v,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 200.v,
                    color: greyColor.withAlpha(30),
                    child: const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  );
                },
                errorBuilder: (_, _, _) => Container(
                  height: 200.v,
                  color: greyColor.withAlpha(30),
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: greyColor,
                    size: 48,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.itemName,
                          style: AppTextStyle.aTextStyle.copyWith(
                            color: blackColor,
                          ),
                        ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyle.cTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.v),

                  Text(
                    '${product.restaurantName} • ${product.deliveryTime}',
                    style: AppTextStyle.eTextStyle.copyWith(color: greyColor),
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
                      SizedBox(width: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.h,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
