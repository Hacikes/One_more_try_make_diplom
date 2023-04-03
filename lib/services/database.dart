import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String uid;
  // консруктор для передачи uid
  DatabaseService({required this.uid});

  // Ссылка на колекцию в бд для получения и изменения данных
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brew');

  // Функция с тремя параметрами: сахар, имя и крепость
  // асинхронно возвращаем колекцию с данными
  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }
}
