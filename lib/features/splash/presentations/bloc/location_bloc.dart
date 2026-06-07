import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_event.dart';
import 'package:food_delivery_app/features/splash/presentations/bloc/location_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationInitial()) {
    on<LocationRequested>(_onLocationRequested);
  }

  Future<void> _onLocationRequested(
    LocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(const LocationServiceDisabled());
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(const LocationPermissionDenied());
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(const LocationPermissionDenied());
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );

      String cityLine = 'Current Location';
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          final city = p.locality ?? p.subAdministrativeArea ?? '';
          final admin = p.administrativeArea ?? '';
          if (city.isNotEmpty && admin.isNotEmpty && city != admin) {
            cityLine = '$city, $admin';
          } else if (city.isNotEmpty) {
            cityLine = city;
          } else if (admin.isNotEmpty) {
            cityLine = admin;
          }
        }
      } catch (_) {
        cityLine =
            '${position.latitude.toStringAsFixed(3)}, ${position.longitude.toStringAsFixed(3)}';
      }

      emit(
        LocationLoaded(
          cityLine: cityLine,
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
