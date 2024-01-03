// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_api_test/modules/news_cubit.dart';
import 'package:flutter_application_api_test/modules/news_states.dart';
import 'package:flutter_application_api_test/modules/search_screen.dart';
import 'package:flutter_application_api_test/shared/component/buildarticleitem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "News App",
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      // color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      cubit.changeAppMode();
                      cubit.getBusiness();
                      cubit.getScience();
                      cubit.getTechnology();
                    },
                    icon: Icon(
                      Icons.dark_mode_outlined,
                      // color: Colors.black,
                    )),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items: cubit.bottomsItems),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
