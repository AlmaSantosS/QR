import 'package:flutter/material.dart';
import 'package:esqrcode/routes/routes.dart';

//acount
import 'package:esqrcode/src/account/login.dart';
import 'package:esqrcode/src/account/register.dart';
//home
import 'package:esqrcode/main.dart';
//pages
import 'package:esqrcode/src/pages/first.dart';
import 'package:esqrcode/src/pages/second.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
Routes.login: (_) => const Login(),
Routes.register: (_) => const Register(),


};


