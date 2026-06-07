import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/bottomNavBar/presentation/bloc/bottom_nav_bar_event.dart';
import 'package:food_delivery_app/features/bottomNavBar/presentation/bloc/bottom_nav_bar_state.dart';
import 'package:food_delivery_app/features/home/presentation/views/home_screen.dart';
import 'package:food_delivery_app/features/menu/presetations/views/menu_screen.dart';
import 'package:food_delivery_app/features/profile/presentations/views/profile_screen.dart';
import 'package:food_delivery_app/features/trackOrder/presentations/views/track_order_screen.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final List<Widget> widgetList = [
    HomeScreen(),
    MenuScreen(),
    TrackOrderScreen(),
    ProfileScreen(),
  ];

  BottomNavigationBloc() : super(const BottomNavigationState()) {
    on<NavigationTabChanged>(_onNavigationTabChanged);
  }

  void _onNavigationTabChanged(
    NavigationTabChanged event,
    Emitter<BottomNavigationState> emit,
  ) {
    if (event.tabIndex >= 0 && event.tabIndex < widgetList.length) {
      emit(state.copyWith(selectedIndex: event.tabIndex));
    }
  }
}
