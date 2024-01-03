// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_api_test/modules/news_cubit.dart';
import 'package:flutter_application_api_test/modules/news_states.dart';
import 'package:flutter_application_api_test/shared/component/taskbuilderitem.dart';
import 'package:flutter_application_api_test/shared/component/textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  bool searchedItem = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                defaultFormField(
                    controller: searchController,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      searchedItem = true;
                      NewsCubit.get(context).getSearch(value);
                    },
                    type: TextInputType.text,
                    prefix: Icons.search,
                    label: 'search'),
                Expanded(child: taskBuilderItem(list: list, context: context))
              ],
            ),
          ),
        );
      },
    );
  }
}
