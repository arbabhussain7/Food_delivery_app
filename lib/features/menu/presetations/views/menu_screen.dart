import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/config/app_routes.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_bloc.dart';
import 'package:food_delivery_app/features/menu/presetations/bloc/menu_bloc.dart';
import 'package:food_delivery_app/features/menu/presetations/widgets/location_header.dart';
import 'package:food_delivery_app/features/menu/presetations/widgets/menu_card.dart';
import 'package:food_delivery_app/features/menu/presetations/widgets/search_header.dart';
import 'package:food_delivery_app/init_dependencies.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MenuBloc>()..add(const MenuProductsFetchRequested()),
      child: const _MenuBody(),
    );
  }
}

class _MenuBody extends StatefulWidget {
  const _MenuBody();

  @override
  State<_MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<_MenuBody> {
  bool _searchActive = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<MenuBloc>().add(const MenuSearchChanged(''));
    setState(() => _searchActive = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.v),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _searchActive
                    ? SearchHeader(
                        key: const ValueKey('search'),
                        controller: _searchController,
                        onClose: _clearSearch,
                        onChanged: (q) =>
                            context.read<MenuBloc>().add(MenuSearchChanged(q)),
                      )
                    : LocationHeader(
                        key: const ValueKey('location'),
                        onSearchTap: () => setState(() => _searchActive = true),
                      ),
              ),

              SizedBox(height: 22.v),

              if (!_searchActive) ...[
                Text(
                  'All Items',
                  style: AppTextStyle.bTextStyle.copyWith(color: blackColor),
                ),
                SizedBox(height: 12.v),
              ],

              Expanded(
                child: BlocBuilder<MenuBloc, MenuState>(
                  builder: (context, state) {
                    if (state is MenuLoading || state is MenuInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: whiteColor,
                          backgroundColor: primaryColor,
                        ),
                      );
                    }

                    if (state is MenuFailure) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.message,
                              style: AppTextStyle.eTextStyle.copyWith(
                                color: greyColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12.v),
                            TextButton(
                              onPressed: () => context.read<MenuBloc>().add(
                                const MenuProductsFetchRequested(),
                              ),
                              child: Text(
                                'Retry',
                                style: AppTextStyle.eTextStyle.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is MenuLoaded) {
                      final products = state.displayProducts;

                      if (products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.search_off_rounded,
                                size: 56,
                                color: greyColor,
                              ),
                              SizedBox(height: 12.v),
                              Text(
                                state.searchQuery.isEmpty
                                    ? 'No products available.'
                                    : 'No results for "${state.searchQuery}"',
                                style: AppTextStyle.eTextStyle.copyWith(
                                  color: greyColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: products.length,
                        separatorBuilder: (_, _) => SizedBox(height: 12.v),
                        itemBuilder: (context, index) =>
                            MenuProductCard(product: products[index]),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          if (cartState.items.isEmpty) return const SizedBox.shrink();
          return Container(
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.v),
            child: SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.ordersScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.v),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.adaptSize),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_rounded,
                      color: whiteColor,
                      size: 18,
                    ),
                    SizedBox(width: 8.h),
                    Text(
                      'View Cart  (${cartState.totalItemCount} items)  —  \$${cartState.total.toStringAsFixed(2)}',
                      style: AppTextStyle.eTextStyle.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
