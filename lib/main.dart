import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/view/screen/intro/login_screen.dart';
import 'package:habitool/view/screen/new_habit/newhabit_screen.dart';
import 'package:provider/provider.dart';
import 'Widget_tree.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: FirebaseAuth.instance.authStateChanges()),
        ChangeNotifierProvider.value(value: UserProvider()),
        Provider(
          create: (_) => HabitServices(),
        ),
        ChangeNotifierProvider(create: (_) => HabitServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WidgetTree(),
      ),
    );
  }
}
