// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_api_test/modules/webview.dart';

Widget buildArticlItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context,WebViewScreen(article['url']) );
      },
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: article['urlToImage'] == null
                        ? NetworkImage(
                            "https://images.unsplash.com/photo-1614027164847-1b28cfe1df60?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D")
                        : NetworkImage(article['urlToImage']),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    article['title'],
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Text(
                    article['publishedAt'],
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
