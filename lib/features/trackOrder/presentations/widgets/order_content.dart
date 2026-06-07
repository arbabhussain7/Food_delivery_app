import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';
import 'package:food_delivery_app/utiles/custom_stepper.dart';

class OrderContent extends StatelessWidget {
  final OrderEntity order;
  const OrderContent({required this.order});

  static const _statuses = [
    'Order Placed',
    'Preparing',
    'Out for Delivery',
    'Delivered',
  ];

  int get _activeIndex => _statuses.indexOf(order.deliveryStatus).clamp(0, 3);

  String _formatTime(DateTime dt) {
    final hour = dt.hour;
    final minute = dt.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final placedTime = _formatTime(order.orderPlacedAt);
    final estTime = _formatTime(order.estimatedDelivery);
    final active = _activeIndex;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Column(
              children: [
                SizedBox(height: 12.v),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 10.h),
                    SvgPicture.asset(AppAssets.locationsIcon),
                    SizedBox(width: 10.h),
                    Expanded(
                      child: Text(
                        'Order #${order.id.substring(0, 6).toUpperCase()} Tracking',
                        style: AppTextStyle.eTextStyle.copyWith(
                          color: blackColor.withAlpha(90),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SvgPicture.asset(AppAssets.searchIcon),
                    SizedBox(width: 10.h),
                    SvgPicture.asset(
                      AppAssets.infoIcon,
                      // ignore: deprecated_member_use
                      color: secondaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 22.v),

          Container(
            height: 310.v,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.adaptSize),
            ),
            child: ClipRRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(AppAssets.mapImg, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.12),
                          Colors.black.withValues(alpha: 0.66),
                        ],
                        stops: const [0.45, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.v,
                    left: 20.h,
                    right: 20.h,
                    child: Container(
                      padding:  EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 12.v,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.adaptSize),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ESTIMATED DELIVERY',
                                style: AppTextStyle.bTextStyle.copyWith(
                                  color: Colors.black.withAlpha(90),
                                  fontSize: 11.adaptSize,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4.v),
                              Text(
                                order.deliveryStatus == 'Delivered'
                                    ? 'Delivered!'
                                    : estTime,
                                style: AppTextStyle.jTextStyle.copyWith(
                                  color: order.deliveryStatus == 'Delivered'
                                      ? Colors.green
                                      : secondaryColor,
                                  fontSize: 28.adaptSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.v),
                              Text(
                                'Ordered at $placedTime · ${order.deliveryTimeRange}',
                                style: AppTextStyle.fTextStyle.copyWith(
                                  color: Colors.black54,
                                  fontSize: 11.adaptSize,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10.adaptSize),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondaryColor.withAlpha(20),
                            ),
                            child: SvgPicture.asset(
                              AppAssets.clockIcon,
                              // ignore: deprecated_member_use
                              color: secondaryColor,
                              width: 33.h,
                              height: 33.v,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 22.v),

          // ── Order Status stepper ───────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Status',
                  style: AppTextStyle.bTextStyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: 12.v),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12.adaptSize),
                  ),
                  child: Column(
                    children: [
                      CustomStepper(
                        icon: Icons.check,
                        title: 'Order Placed',
                        subtitle: 'Your order was received at $placedTime',
                        isCompleted: active > 0,
                        isActive: active == 0,
                        isLast: false,
                      ),
                      CustomStepper(
                        icon: Icons.restaurant_rounded,
                        title: 'Preparing',
                        subtitle: 'The chef is crafting your meal',
                        isCompleted: active > 1,
                        isActive: active == 1,
                        isLast: false,
                      ),
                      CustomStepper(
                        icon: Icons.delivery_dining,
                        title: 'Out for Delivery',
                        subtitle: 'Your courier is on the way!',
                        isCompleted: active > 2,
                        isActive: active == 2,
                        isLast: false,
                      ),
                      CustomStepper(
                        icon: Icons.home_outlined,
                        title: 'Delivered',
                        subtitle: 'Enjoy your delicious meal',
                        isCompleted: active > 3,
                        isActive: active == 3,
                        isLast: true,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 22.v),

                Container(
                  padding: EdgeInsets.all(14.adaptSize),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12.adaptSize),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.adaptSize),
                        child: Image.network(
                          order.imageUrl,
                          width: 72.h,
                          height: 72.v,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            width: 72.h,
                            height: 72.v,
                            color: greyColor.withAlpha(30),
                            child: const Icon(
                              Icons.broken_image_outlined,
                              color: greyColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.h),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.itemName,
                              style: AppTextStyle.cTextStyle.copyWith(
                                color: blackColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              order.restaurantName,
                              style: AppTextStyle.fTextStyle.copyWith(
                                color: blackColor.withAlpha(120),
                              ),
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Qty: ${order.quantity}  ·  \$${order.totalAmount.toStringAsFixed(2)}',
                              style: AppTextStyle.eTextStyle.copyWith(
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22.v),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
