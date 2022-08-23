import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fox_delivery_owner/Modules/HomeScreen/HomeScreen.dart';
import 'package:fox_delivery_owner/shared/BlocObserver/BlocObserver.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:fox_delivery_owner/styles/Themes.dart';

import 'firebase_options.dart';

////Notifications////////
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  showToast(
      msg: 'On Message Background',
      color: Colors.green,
      textColor: Colors.white);
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // internetConnection = await InternetConnectionChecker().hasConnection;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // DioHelper.init();

  BlocOverrides.runZoned(
        () {
          runApp(const MyApp());

        },
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoxCubit(),
      child: BlocConsumer<FoxCubit, FoxStates>(
        listener: (context,state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: ThemeMode.light,
            theme: lightTheme,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

