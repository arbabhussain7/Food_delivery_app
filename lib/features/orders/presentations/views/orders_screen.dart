import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_bloc.dart';
import 'package:food_delivery_app/features/orders/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_state.dart';
import 'package:food_delivery_app/features/trackOrder/domain/usecases/create_order_usecase.dart';
import 'package:food_delivery_app/init_dependencies.dart';
import 'package:food_delivery_app/utiles/custom_button.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaymentBloc>(),
      child: const _OrdersBody(),
    );
  }
}

class _OrdersBody extends StatelessWidget {
  const _OrdersBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        if (state is PaymentSuccess) {
          final cartState = context.read<CartBloc>().state;
          if (cartState.items.isEmpty) return;

          final userId = getIt<FirebaseAuth>().currentUser?.uid ?? '';

          final result = await getIt<CreateOrderUseCase>()(
            CreateOrderParams(
              userId: userId,
              cartItems: cartState.items,
              totalAmount: cartState.total,
              deliveryAddress: '742 Evergreen Terrace',
            ),
          );

          if (!context.mounted) return;

          context.read<CartBloc>().add(const CartCleared());

          result.fold(
            (failure) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Payment succeeded — tracking unavailable: ${failure.message}',
                ),
                backgroundColor: Colors.orange.shade700,
              ),
            ),
            (orderId) => Navigator.pushReplacementNamed(
              context,
              AppRoutes.trackOrderScreen,
              arguments: orderId,
            ),
          );
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      },
      builder: (context, paymentState) {
        final isLoading = paymentState is PaymentLoading;

        return BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            // Empty cart
            if (cartState.items.isEmpty) {
              return Scaffold(
                backgroundColor: bgColor,
                appBar: AppBar(
                  backgroundColor: bgColor,
                  elevation: 0,
                  leading: const BackButton(color: blackColor),
                  title: Text(
                    'Your Cart',
                    style: AppTextStyle.bTextStyle.copyWith(color: blackColor),
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 72,
                        color: greyColor,
                      ),
                      SizedBox(height: 16.v),
                      Text(
                        'Your cart is empty',
                        style: AppTextStyle.bTextStyle.copyWith(
                          color: blackColor,
                        ),
                      ),
                      SizedBox(height: 8.v),
                      Text(
                        'Add items from the menu to get started.',
                        style: AppTextStyle.fTextStyle.copyWith(
                          color: greyColor,
                        ),
                      ),
                      SizedBox(height: 24.v),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Browse Menu',
                          style: AppTextStyle.eTextStyle.copyWith(
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Stack(
              children: [
                Scaffold(
                  backgroundColor: bgColor,
                  body: SafeArea(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.v),

                                // ── Header ─────────────────────────
                                Row(
                                  children: [
                                    SvgPicture.asset(AppAssets.locationsIcon),
                                    SizedBox(width: 12.h),
                                    BlocBuilder<LocationBloc, LocationState>(
                                      builder: (context, locState) {
                                        final String city;
                                        if (locState is LocationLoaded) {
                                          city = locState.cityLine;
                                        } else if (locState
                                            is LocationLoading) {
                                          city = 'Getting location...';
                                        } else if (locState
                                                is LocationPermissionDenied ||
                                            locState
                                                is LocationServiceDisabled ||
                                            locState is LocationError) {
                                          city = 'Location unavailable';
                                        } else {
                                          city = 'Current Location';
                                        }
                                        return Text(
                                          city,
                                          style: AppTextStyle.iTextStyle
                                              .copyWith(color: secondaryColor),
                                        );
                                      },
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(AppAssets.searchIcon),
                                  ],
                                ),

                                SizedBox(height: 15.v),

                                // ── Delivery address ───────────────
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.h,
                                    vertical: 12.v,
                                  ),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(
                                      12.adaptSize,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.delivery_dining,
                                            color: secondaryColor,
                                          ),
                                          SizedBox(width: 6.h),
                                          Text(
                                            'Delivery Address',
                                            style: AppTextStyle.iTextStyle
                                                .copyWith(color: blackColor),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Change',
                                            style: AppTextStyle.iTextStyle
                                                .copyWith(
                                                  color: secondaryColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.v),
                                      Text(
                                        '742 Evergreen Terrace',
                                        style: AppTextStyle.eTextStyle.copyWith(
                                          color: blackColor.withAlpha(50),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 22.v),
                                Row(
                                  children: [
                                    Text(
                                      'Your Items',
                                      style: AppTextStyle.bTextStyle.copyWith(
                                        color: blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () => context
                                          .read<CartBloc>()
                                          .add(const CartCleared()),
                                      child: Text(
                                        'Clear All',
                                        style: AppTextStyle.fTextStyle.copyWith(
                                          color: Colors.red.shade400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.v),
                              ],
                            ),
                          ),
                        ),

                        // ── Cart items list ───────────────────────
                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final item = cartState.items[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.h,
                                vertical: 6.v,
                              ),
                              child: _CartItemCard(item: item),
                            );
                          }, childCount: cartState.items.length),
                        ),

                        // ── Price breakdown ───────────────────────
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Column(
                              children: [
                                SizedBox(height: 22.v),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.h,
                                    vertical: 14.v,
                                  ),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(
                                      12.adaptSize,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      _PriceRow(
                                        label:
                                            'Sub Total (${cartState.totalItemCount} items)',
                                        amount: cartState.subTotal,
                                      ),
                                      SizedBox(height: 12.v),
                                      _PriceRow(
                                        label: 'Delivery Fee',
                                        amount: CartItem.deliveryFee,
                                      ),
                                      SizedBox(height: 12.v),
                                      const Divider(),
                                      SizedBox(height: 12.v),
                                      _PriceRow(
                                        label: 'Total',
                                        amount: cartState.total,
                                        bold: true,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 100.v),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: BottomAppBar(
                    child: CustomButton(
                      text:
                          'Checkout  —  \$${cartState.total.toStringAsFixed(2)}',
                      onPressed: isLoading
                          ? null
                          : () => context.read<PaymentBloc>().add(
                              PaymentInitiated(totalAmount: cartState.total),
                            ),
                    ),
                  ),
                ),

                // ── Loading overlay ───────────────────────────────
                if (isLoading)
                  const AbsorbPointer(
                    child: ColoredBox(
                      color: Color(0x66000000),
                      child: Center(
                        child: CircularProgressIndicator(color: whiteColor),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

// ── Single cart item card ─────────────────────────────────────────────────────

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.v),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12.adaptSize),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10.adaptSize),
            child: Image.network(
              item.product.imageUrl,
              width: 80.h,
              height: 80.v,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 80.h,
                height: 80.v,
                color: greyColor.withAlpha(30),
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: greyColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.h),

          // Info + controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.product.itemName,
                        style: AppTextStyle.cTextStyle.copyWith(
                          color: blackColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Remove button
                    GestureDetector(
                      onTap: () => context.read<CartBloc>().add(
                        CartItemRemoved(item.product.id),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),

                if (item.customizationLabels.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 2.v),
                    child: Text(
                      item.customizationLabels.join(', '),
                      style: AppTextStyle.fTextStyle.copyWith(
                        color: blackColor.withAlpha(120),
                      ),
                    ),
                  ),

                SizedBox(height: 10.v),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.lineTotal.toStringAsFixed(2)}',
                      style: AppTextStyle.bTextStyle.copyWith(
                        color: secondaryColor,
                      ),
                    ),

                    // Quantity stepper
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                        vertical: 4.v,
                      ),
                      decoration: BoxDecoration(
                        color: blackColor.withAlpha(15),
                        borderRadius: BorderRadius.circular(88.adaptSize),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final next = item.quantity - 1;
                              if (next <= 0) {
                                context.read<CartBloc>().add(
                                  CartItemRemoved(item.product.id),
                                );
                              } else {
                                context.read<CartBloc>().add(
                                  CartItemQuantityUpdated(
                                    productId: item.product.id,
                                    quantity: next,
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: blackColor,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: 12.h),
                          Text(
                            '${item.quantity}',
                            style: AppTextStyle.cTextStyle.copyWith(
                              color: blackColor,
                            ),
                          ),
                          SizedBox(width: 12.h),
                          GestureDetector(
                            onTap: () => context.read<CartBloc>().add(
                              CartItemQuantityUpdated(
                                productId: item.product.id,
                                quantity: item.quantity + 1,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              color: secondaryColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
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

// ── Price row ─────────────────────────────────────────────────────────────────

class _PriceRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool bold;

  const _PriceRow({
    required this.label,
    required this.amount,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? AppTextStyle.bTextStyle.copyWith(color: blackColor)
        : AppTextStyle.eTextStyle.copyWith(color: blackColor.withAlpha(150));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\$${amount.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
