import 'package:flutter/material.dart';
import 'package:try_make_diplom/screen/authenticate/register.dart';
import 'package:try_make_diplom/screen/authenticate/sign_in.dart';
import 'package:try_make_diplom/screen/authenticate/authenticate.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  // проверка какой экран нам показывать
  bool showSignIn = true;
  // Логика какой экран возвращать
  // Логика такая. Когда мы сначала попадаем на экран регистрации
  // и когда нажимаем на кнопку register мы запускаем функцию toggleView
  // снова и устанавливаем значение false и переключается экран и действует это
  // в обе стороны
  void toggleView() {
    setState(() =>  showSignIn = !showSignIn);
  }

  // возвращаем один из экранов
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
