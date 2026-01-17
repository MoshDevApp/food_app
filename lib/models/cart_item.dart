import '../../screens/home/views/home_screen.dart';

class CartItem {
  final DummyFood food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});

  double get totalPrice => food.price * quantity;
}
