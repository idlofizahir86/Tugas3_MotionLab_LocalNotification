// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:local_notification/notification_api.dart';
import 'package:local_notification/second_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();

    tz.initializeTimeZones();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SecondPage(payload: payload)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5F7FF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/motion_lab_logo.png',
            ),
            const Text(
              'Local Notification App',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () => NotificationApi.showNotification(
                id: 0,
                title: 'Notifikasi Default',
                body:
                    'Ini notifikasi default yang langsung muncul\nketika di tombol diklik',
                payload: 'Idlofi ZR',
              ),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: 45,
                decoration: const BoxDecoration(
                  color: Color(0xff878EDE),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(
                      Icons.notifications_active_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      'Notifikasi Default',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                NotificationApi.showScheduledNotification(
                  id: 1,
                  title: 'Notifikasi Terjadwal',
                  body: 'Motion Lab',
                  payload: 'Motion Lab',
                  scheduledDate: DateTime.now().add(
                    const Duration(seconds: 10),
                  ),
                );

                const snackBar = SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text(
                    'Notifikasi akan ditampikan dalam 10 detik!',
                    style: TextStyle(fontSize: 15),
                  ),
                  backgroundColor: Colors.teal,
                );
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
                height: 45,
                decoration: const BoxDecoration(
                  color: Color(0xff878EDE),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(
                      Icons.schedule_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      'Notifikasi Schedule',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
