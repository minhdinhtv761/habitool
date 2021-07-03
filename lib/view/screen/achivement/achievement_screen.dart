import 'dart:io';

import 'package:habitool/model/blocs/newsbloc/news_bloc.dart';
import 'package:habitool/model/blocs/newsbloc/news_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitool/repositories/news_repository.dart';
import 'package:habitool/view/screen/achivement/splash_screen.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
              initialState: NewsInitState(), newsRepositoty: NewsRepository()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            )),
        home: SplashScreen(),
      ),
    );
  }
}
