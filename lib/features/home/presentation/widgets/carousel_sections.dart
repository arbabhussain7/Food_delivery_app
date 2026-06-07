import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/constant/app_color.dart';
import 'package:food_delivery_app/core/constant/app_device_size_manager.dart';
import 'package:food_delivery_app/core/constant/app_textstyle.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_events.dart';
import 'package:food_delivery_app/features/home/presentation/bloc/home_states.dart';

class CarouselSection extends StatelessWidget {
  final HomeState state;
  CarouselSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.v,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CarouselSlider.builder(
              itemCount: state.carouselItems.length,
              itemBuilder: (context, index, realIndex) {
                return Image.asset(
                  state.carouselItems[index].image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
              options: CarouselOptions(
                height: 200.v,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                onPageChanged: (index, _) =>
                    context.read<HomeBloc>().add(HomeCarouselChanged(index)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.85),
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.v,
                      horizontal: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'Limited Offer',
                      style: AppTextStyle.iTextStyle.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.v),
                  Text(
                    state.carouselItems[state.currentIndex].title,
                    style: AppTextStyle.bTextStyle.copyWith(color: whiteColor),
                  ),
                  SizedBox(height: 12.v),
                  Text(
                    state.carouselItems[state.currentIndex].subtitle,
                    style: AppTextStyle.iTextStyle.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 12.v),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
