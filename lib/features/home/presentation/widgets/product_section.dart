import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_events.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_states.dart';
import 'package:food_delivery_app/features/home/presentation/widgets/product_card_section.dart';

class ProductsSection extends StatelessWidget {
  final HomeState state;
  ProductsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state.productsStatus) {
      case ProductsStatus.initial:
      case ProductsStatus.loading:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
              backgroundColor: whiteColor,
            ),
          ),
        );

      case ProductsStatus.failure:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Text(
                state.errorMessage ?? 'Something went wrong.',
                style: AppTextStyle.eTextStyle.copyWith(color: greyColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.v),
              TextButton(
                onPressed: () => context.read<HomeBloc>().add(
                  const ProductsFetchRequested(),
                ),
                child: Text(
                  'Retry',
                  style: AppTextStyle.eTextStyle.copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
        );

      case ProductsStatus.loaded:
        if (state.products.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                'No products available.',
                style: AppTextStyle.eTextStyle.copyWith(color: greyColor),
              ),
            ),
          );
        }
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.products.length,
          itemBuilder: (context, index) =>
              ProductCard(product: state.products[index]),
          separatorBuilder: (_, _) => SizedBox(height: 22.v),
        );
    }
  }
}
