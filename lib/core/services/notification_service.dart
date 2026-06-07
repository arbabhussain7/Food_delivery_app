import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'order_delivery';
  static const _channelName = 'Order Delivery';
  static const _channelDesc = 'Real-time updates about your food delivery';

  static Future<void> init() async {
    // Create high-importance channel (required Android 8+)
    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
      playSound: true,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(settings: initSettings);
  }

  static Future<void> showOrderStatusNotification({
    required String orderId,
    required String status,
  }) async {
    String title;
    String body;

    switch (status) {
      case 'Preparing':
        title = 'Your Order is Being Prepared';
        body = 'The chef is crafting your delicious meal!';
      case 'Out for Delivery':
        title = 'Your Order is on the Way!';
        body = 'Your delivery rider is heading to you now.';
      case 'Delivered':
        title = 'Your Order Has Arrived!';
        body = 'Your order is at your door. Enjoy your meal!';
      default:
        return;
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );

    await _plugin.show(
      id: orderId.hashCode & 0x7FFFFFFF,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}
