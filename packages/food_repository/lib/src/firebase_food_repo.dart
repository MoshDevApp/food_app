import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_repository/food_repository.dart';

class FirebasePizzaRepo implements PizzaRepo{
  final pizzaCollection = FirebaseFirestore.instance.collection('pizza');

  Future<List<Pizza>> getPizzas() async {
    try{
      return await pizzaCollection
      .get()
      .then((value) => value.docs.map((e) =>
      Pizza.fromEntity(PizzaEntity.fromDocument(e.data()))
    ).toList());
    }catch (e){
      log(e.toString());
      rethrow;
    }
  }
}