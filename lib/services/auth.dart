import 'package:firebase_auth/firebase_auth.dart';
import 'package:try_make_diplom/models/user.dart';
import 'package:try_make_diplom/services/database.dart';

class AuthService {
  // в _auth _ означает, что мы можем использовать эту переменную только внутри этого файла
  // _auth даст нам доступ к FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Функция создания пользовательского объекта на основе Firebase
  // тип определён классом User1
  User1? _userFromFirebaseUser(User? user){
    // Возвращаем проверку, что пользователь не равен null и тогда возвращаем uid
    // пользователя используя класс User, а параметр uid будет определяться
    // параметром user этой функции
    return user != null ? User1(uid: user.uid) : null;
  }

//----------------------------------------------------------------------------------------------

  // Поток авторизации пользователей
  // то есть ели этот пользователь уже зареган, то мы можем по нему войти
  Stream<User1?> get user {
    return _auth.authStateChanges()
        .map((user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      // Пытаемся войти анонимно в приложение с помощью метода signInAnonymously
      // Записываем результат аутентификации типа UserCredential
      UserCredential result = await _auth.signInAnonymously();
      // User - пользовательский объект
      User? user = result.user;
      // Возвращаем объект _userFromFirebaseUser с данными аутентификации
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//----------------------------------------------------------------------------------------------
// sign in with email/password
  Future signInWithEmailAndPassword (String email, String password) async {
    try{
      // эта функция после того, как ей придут email и пароль попытается создать пользователями с этими кредами
      // и если получится она успешно вернёт пользователя и его uid, как мы и объявили в user.dart
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //Возвращаем user в поток авторизации пользователей, который мы сделали выше
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


//----------------------------------------------------------------------------------------------
// register with email/password
  Future registerWithEmailAndPassword (String email, String password) async {
    try{
      // эта функция после того, как ей придут email и пароль попытается создать пользователями с этими кредами
      // и если получится она успешно вернёт пользователя и его uid, как мы и объявили в user.dart
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // Создаём новый документ для пользователя у которого есть uid
      String debug = await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);
      //Возвращаем user в поток авторизации пользователей, который мы сделали выше
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
//----------------------------------------------------------------------------------------------
// sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}