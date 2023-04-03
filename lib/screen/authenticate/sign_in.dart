import 'package:flutter/material.dart';
import 'package:try_make_diplom/services/auth.dart';
import 'package:try_make_diplom/shared/constant.dart';
import 'package:try_make_diplom/shared/loading.dart';

class SignIn extends StatefulWidget {

  // Передаём свойсто toggleView для того, чтобы понимать какой экран перключать
  // крч добавляем его в конструктор экземпляра класса
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // Создаём экзмепляр класса AuthService
  final AuthService _auth = AuthService();
  // Валидация логина и пароля
  final _formKey = GlobalKey<FormState>();
  // Для состояния, когда нужна загрузка
  bool loading = false;

  // Переменные для состояние логина и пароля
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // Если loading = true, вернуть экран загрузки, иначе экран входа
    return loading ?  Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to app'),
        //
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              // использем функцию для переключения вида
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          // поможет остележить форму и её состояние
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              // Тут указываем, что произойдёт, когда поле формы изменится
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email': null,
                // Каждый раз, когда значение в форме меняется
                // будет запускаться эта функция
                // крч форма логина
                onChanged: (val) {
                  // Устанавливаем состояние для логина
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              // Форма логина
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter an password 6 + char long': null,
                // заменяет ввод на точки, как во всех вводах пароля
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Устанавливаем состояние экрана загрузки, когда нажали на кнопку Sign In
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        error = 'Could not Sign In those credentials';
                        // Если будет ошибка, то есть ответ = null, то переводим состояние экрана загрузки в false
                        loading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400]
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(color:Colors.white),
                ),
              ),
              SizedBox(height: 12.0,),
              // Печатаем текст ошибки, что email пустой
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
