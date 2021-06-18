import 'package:chat/provider/home_provider.dart';
import 'package:chat/ui/auth/user_name.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// root application launch
final Handler rootHandler =
    Handler(handlerFunc: (context, params) => UserNameScreen());

final Handler homeHandler = Handler(handlerFunc: (context, params) {
  final obj = ModalRoute.of(context!)!.settings.arguments;
  return ChangeNotifierProvider<HomeProvider>(
    create: (context) => HomeProvider(obj as String),
    child: HomeScreen(),
  );
});
