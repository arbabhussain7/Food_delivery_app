import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delivery_app/core/services/notification_service.dart';

// Must be top-level — runs in a separate isolate when app is terminated/background.
@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  // Firebase auto-displays the notification when the app is in background/terminated
  // if the FCM payload contains a `notification` key. No extra code needed here.
  log('[FCM] Background message: ${message.messageId}');
}

class FCMService {
  FCMService._();

  static final _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // Register background/terminated handler (must be called before runApp)
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    // Request permission – on Android 13+ this shows the system dialog
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('[FCM] Permission status: ${settings.authorizationStatus}');

    // Fetch token and persist it so a backend/Cloud Function can target this device
    final token = await _messaging.getToken();
    if (token != null) {
      log('[FCM] Device token: $token');
      await _saveToken(token);
    }

    // Keep the stored token fresh
    _messaging.onTokenRefresh.listen(_saveToken);

    // App is in FOREGROUND → Firebase does NOT auto-display; show via local notification
    FirebaseMessaging.onMessage.listen(_handleForeground);

    // Notification tapped while app was in background (not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      log('[FCM] Opened via notification tap: ${msg.data}');
    });
  }

  // Handles FCM messages received while the app is in the foreground.
  // Expected FCM data payload: { "deliveryStatus": "Delivered", "orderId": "<id>" }
  static void _handleForeground(RemoteMessage message) {
    log('[FCM] Foreground message: ${message.data}');
    final status = message.data['deliveryStatus'] as String?;
    final orderId = message.data['orderId'] as String? ?? 'order';

    if (status != null && status.isNotEmpty) {
      NotificationService.showOrderStatusNotification(
        orderId: orderId,
        status: status,
      );
    }
  }

  // Saves the FCM token to Firestore under the current user's document.
  // A backend / Cloud Function reads this to send targeted push notifications.
  static Future<void> _saveToken(String token) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'fcmToken': token}, SetOptions(merge: true));
      log('[FCM] Token saved → users/$uid');
    } catch (e) {
      log('[FCM] Token save error: $e');
    }
  }
}
