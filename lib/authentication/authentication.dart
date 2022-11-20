import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen/home_screen_view.dart';
import 'login_screen/login_screen_view.dart';

class Authentication extends StatelessWidget {
  Authentication({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return const HomeScreenView();
  }
}
