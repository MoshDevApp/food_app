import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final existingIndex = state.items.indexWhere(
      (item) => item.food.name == event.item.food.name,
    );

    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingIndex].quantity += 1;
      emit(state.copyWith(items: updatedItems));
    } else {
      emit(state.copyWith(items: [...state.items, event.item]));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = state.items
        .where((item) => item.food.name != event.foodName)
        .toList();
    emit(state.copyWith(items: updatedItems));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.food.name == event.foodName) {
        return CartItem(food: item.food, quantity: event.quantity, id: item.id ?? '', name: item.name, price: item.price, image: item.image ?? '');
      }
      return item;
    }).where((item) => item.quantity > 0).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(items: []));
  }
}
