import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_notification/utils.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    // final largeIconPath = await Utils.downloadFile(
    //   'https://media-exp1.licdn.com/dms/image/C4E0BAQH4_rcyldo-1Q/company-logo_100_100/0/1557799548882?e=1652918400&v=beta&t=pUoqLBm1m7q7LELW_hmxZgQYoKSWL5hwZke7_dPbybI',
    //   'largeIcon',
    // );

    // final bigPicturePath = await Utils.downloadFile(
    //   'https://media-exp1.licdn.com/dms/image/C560BAQFz2LdsonUL1A/company-logo_200_200/0/1519897312357?e=1652918400&v=beta&t=flAkfMziDTShXowy6GUv6UxwVdtO3375r4Ky4fTkgOs',
    //   'bigPicture',
    // );

    // final styleInformation = BigPictureStyleInformation(
    //   FilePathAndroidBitmap(bigPicturePath),
    //   largeIcon: FilePathAndroidBitmap(largeIconPath),
    // );
    const sound = 'nico_nico_nii_sound.wav';
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        'ChannelDescription',
        importance: Importance.high,
        priority: Priority.high,
        enableLights: true,
        sound: RawResourceAndroidNotificationSound(sound.split('.').first),
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500,
        timeoutAfter: 5000,
        // styleInformation: styleInformation,
      ),
      iOS: const IOSNotificationDetails(
        sound: sound,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future<void> showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}
