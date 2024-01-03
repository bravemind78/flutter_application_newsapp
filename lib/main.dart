// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_api_test/layout/news_layout.dart';
import 'package:flutter_application_api_test/modules/news_cubit.dart';
import 'package:flutter_application_api_test/modules/news_states.dart';
import 'package:flutter_application_api_test/shared/network/local/cach_helper.dart';
import 'package:flutter_application_api_test/shared/network/remote/dio_helper.dart';
import 'package:flutter_application_api_test/shared/styles/bloc-observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..changeAppMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  textTheme: TextTheme(
                      bodyText1: TextStyle(fontSize: 18, color: Colors.black)),
                  iconTheme: IconThemeData(color: Colors.black),
                  primarySwatch: Colors.teal,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark),
                      elevation: 0,
                      titleTextStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.teal)),
              darkTheme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(fontSize: 18, color: Colors.white)),
                primarySwatch: Colors.teal,
                scaffoldBackgroundColor: HexColor('333739'),
                iconTheme: IconThemeData(color: Colors.white),
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.white),
                    backgroundColor: HexColor('333739'),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: HexColor('333739'),
                    unselectedItemColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.teal),
              ),
              themeMode: NewsCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: NewsLayout(),
            );
          }),
    );
  }
}
