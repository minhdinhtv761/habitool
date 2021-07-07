import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/services/statistic_services.dart';
import 'package:habitool/view/screen/home_screen.dart';
import 'package:habitool/view/screen/intro/login_screen.dart';
import 'package:habitool/view/screen/new_habit/newhabit_screen.dart';
import 'package:habitool/widget_tree.dart';
import 'package:provider/provider.dart';
import 'Widget_tree.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: App(), debugShowCheckedModeBanner: false);
//   }
// }
//
// /// We are using a StatefulWidget such that we only create the [Future] once,
// /// no matter how many times our widget rebuild.
// /// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
// /// would re-initialize FlutterFire and make our application re-enter loading state,
// /// which is undesired.
// class App extends StatefulWidget {
//   // Create the initialization Future outside of `build`:
//   @override
//   _AppState createState() => _AppState();
// }
//
// class _AppState extends State<App> {
//   /// The future is part of the state of our widget. We should not call `initializeApp`
//   /// directly inside [build].
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           print('Some thing went wrong!');
//           //return SomethingWentWrong();
//         }
//
//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return LogInScreen();
//         }
//
//         // Otherwise, show something whilst waiting for initialization to complete
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }

import 'Widget_tree.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: FirebaseAuth.instance.authStateChanges()),
        // ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        Provider(
          create: (_) => UserProvider(),
        ),
        Provider(
          create: (_) => HabitServices(),
        ),
        Provider(
          create: (_) => StatisticServices(),
        ),
        ChangeNotifierProvider(create: (_) => HabitServices()),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/logo.png'),
          nextScreen: WidgetTree(),

          splashTransition: SplashTransition.fadeTransition,
        )

        //WidgetTree(),
      ),
    );
  }
}

class WidgetTree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return LogInScreen();
    }
    return LogInScreen();
  }
}
