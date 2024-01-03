// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_api_test/modules/news_cubit.dart';
import 'package:flutter_application_api_test/modules/news_states.dart';
import 'package:flutter_application_api_test/shared/component/taskbuilderitem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnologyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list = NewsCubit.get(context).technology;
          return ConditionalBuilder(
              condition: state is! NewsGetTechnologyLoadingState,
              builder: (context) =>
                  taskBuilderItem(list: list, context: context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, states) {});
  }
}
