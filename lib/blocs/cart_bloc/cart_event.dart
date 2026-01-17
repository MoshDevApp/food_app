import 'package:food_app/models/cart_item.dart';


abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;
  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final String foodName;
  RemoveFromCart(this.foodName);
}

class UpdateQuantity extends CartEvent {
  final String foodName;
  final int quantity;
  UpdateQuantity(this.foodName, this.quantity);
}

class ClearCart extends CartEvent {}
