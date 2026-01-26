import '../../screens/home/views/home_screen.dart';

class CartItem {
  final DummyFood food;
  int quantity;

  CartItem({required this.food, this.quantity = 1, required String id, required String name, required double price, required String image});

  double get totalPrice => food.price * quantity;

  String? get id => food.id;

  String get name => food.name;

  double get price => food.price;

  String get image => food.image;
}
