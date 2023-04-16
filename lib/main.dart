import 'package:flutter/material.dart';

import 'screen/screens.dart';
import 'services/push_notifications_service.dart';

void main() async {
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    //Context
    PushNotificationService.messagesStream.listen((message) {
      print('Myapp: $message');
      navigatorKey.currentState?.pushNamed('message', arguments: message);
      // Navigator.pushNamed(context, 'message');
      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey, //Navegar
      scaffoldMessengerKey: messengerKey, // Mostrar snacks
      routes: {
        'home': (_) => const HomeScreen(),
        'message': (_) => const MessageScreen(),
      },
    );
  }
}
