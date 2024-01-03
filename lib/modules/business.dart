// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_api_test/modules/news_cubit.dart';
import 'package:flutter_application_api_test/modules/news_states.dart';
import 'package:flutter_application_api_test/shared/component/buildarticleitem.dart';
import 'package:flutter_application_api_test/shared/component/taskbuilderitem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          return ConditionalBuilder(
              condition: state is! NewsGetBusinessLoadingState,
              builder: (context) =>
                  taskBuilderItem(list: list, context: context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, states) {});
  }
}

//