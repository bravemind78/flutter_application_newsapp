// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_api_test/shared/component/buildarticleitem.dart';

Widget taskBuilderItem({required List list, context, searchedItem = false}) =>
    ConditionalBuilder(
        condition: list.isNotEmpty,
        builder: (context) => ListView.separated(
            itemBuilder: ((context, index) =>
                buildArticlItem(list[index], context)),
            separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
            itemCount: list.length),
        fallback: (context) => searchedItem
            ? Container()
            : Center(
                child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    Text(
                      "sorry there is no data yet",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )));
