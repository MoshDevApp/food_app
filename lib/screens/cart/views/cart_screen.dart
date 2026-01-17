import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/cart_item.dart';
import 'package:food_app/screens/home/views/home_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // Dummy cart items for display
  static final List<CartItem> dummyCartItems = [
    CartItem(
      food: DummyFood(
        name: "Cheesy Marvel",
        shortDescription: "Loaded cheese pizza with mozzarella",
        fullDescription: "Cheesy Marvel is a cheese-lover's dream.",
        price: 12.0,
        isVeg: true,
        spicy: 1,
        image: "assets/1.png",
      ),
      quantity: 2,
    ),
    CartItem(
      food: DummyFood(
        name: "Spicy Beast",
        shortDescription: "Hot & spicy chicken delight",
        fullDescription: "Spicy Beast brings the heat.",
        price: 14.0,
        isVeg: false,
        spicy: 3,
        image: "assets/2.png",
      ),
      quantity: 1,
    ),
    CartItem(
      food: DummyFood(
        name: "BBQ Blast",
        shortDescription: "Smoky BBQ chicken overload",
        fullDescription: "BBQ Blast is topped with smoky barbecue chicken.",
        price: 15.0,
        isVeg: false,
        spicy: 2,
        image: "assets/4.png",
      ),
      quantity: 3,
    ),
    CartItem(
      food: DummyFood(
        name: "Paneer Power",
        shortDescription: "Indian paneer fusion pizza",
        fullDescription: "Paneer Power blends soft paneer cubes.",
        price: 13.0,
        isVeg: true,
        spicy: 1,
        image: "assets/5.png",
      ),
      quantity: 1,
    ),
    CartItem(
      food: DummyFood(
        name: "Pepperoni King",
        shortDescription: "Classic pepperoni perfection",
        fullDescription: "Pepperoni King delivers bold, meaty flavor.",
        price: 16.0,
        isVeg: false,
        spicy: 2,
        image: "assets/6.png",
      ),
      quantity: 2,
    ),
  ];

  double get _totalPrice {
    return dummyCartItems.fold(
      0,
      (sum, item) => sum + (item.food.price * item.quantity),
    );
  }

  int get _itemCount {
    return dummyCartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: dummyCartItems.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.cart, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Your cart is empty',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: dummyCartItems.length,
                    itemBuilder: (context, index) {
                      final item = dummyCartItems[index];
                      return _CartItemCard(item: item);
                    },
                  ),
          ),

          // Static Total Price Panel
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, -2),
                  blurRadius: 10,
                ),
              ],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total ($_itemCount items)',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '\$${_totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Proceeding to checkout...'),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;

  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.food.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Food Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.food.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.food.shortDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${(item.food.price * item.quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            children: [
              // Remove Button
              IconButton(
                onPressed: () {
                  // For dummy display, this won't work without state
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Remove functionality disabled in demo'),
                    ),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.trash,
                  color: Colors.red,
                  size: 20,
                ),
              ),

              // Quantity Selector
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Quantity controls disabled in demo'),
                          ),
                        );
                      },
                      icon: const Icon(CupertinoIcons.minus, size: 16),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Quantity controls disabled in demo'),
                          ),
                        );
                      },
                      icon: const Icon(CupertinoIcons.plus, size: 16),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
