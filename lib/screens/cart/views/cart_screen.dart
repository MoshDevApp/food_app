import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:food_app/blocs/cart_bloc/cart_event.dart';
import 'package:food_app/blocs/cart_bloc/cart_state.dart';
import 'package:food_app/models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartItems = state.items;
        final subtotal = cartItems.fold<double>(
          0,
          (sum, item) => sum + (item.food.price * item.quantity),
        );
        final sstTax = subtotal * 0.06;
        final totalPrice = subtotal + sstTax;
        final itemCount = cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              if (cartItems.isNotEmpty)
                IconButton(
                  onPressed: () {
                    _showClearCartConfirmation(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.trash,
                    color: Colors.red,
                  ),
                  tooltip: 'Clear All',
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: cartItems.isEmpty
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
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return _CartItemCard(item: item);
                        },
                      ),
              ),
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
                            'Subtotal ($itemCount items)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'RM ${subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'SST (6%)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'RM ${sstTax.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'RM ${totalPrice.toStringAsFixed(2)}',
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
                          onPressed: cartItems.isEmpty
                              ? null
                              : () {
                                  _showOrderReceivedDialog(context, cartItems, subtotal, sstTax, totalPrice);
                                },
                          style: TextButton.styleFrom(
                            backgroundColor: cartItems.isEmpty ? Colors.grey : Colors.black,
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
      },
    );
  }

  void _showClearCartConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(ClearCart());
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart cleared')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showOrderReceivedDialog(
    BuildContext context,
    List<CartItem> cartItems,
    double subtotal,
    double sstTax,
    double totalPrice,
  ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Order Received',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut,
        );
        return ScaleTransition(
          scale: curvedAnimation,
          child: FadeTransition(
            opacity: animation,
            child: _OrderReceivedPopup(
              cartItems: cartItems,
              subtotal: subtotal,
              sstTax: sstTax,
              totalPrice: totalPrice,
              onDismiss: () {
                context.read<CartBloc>().add(ClearCart());
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}

class _OrderReceivedPopup extends StatefulWidget {
  final List<CartItem> cartItems;
  final double subtotal;
  final double sstTax;
  final double totalPrice;
  final VoidCallback onDismiss;

  const _OrderReceivedPopup({
    required this.cartItems,
    required this.subtotal,
    required this.sstTax,
    required this.totalPrice,
    required this.onDismiss,
  });

  @override
  State<_OrderReceivedPopup> createState() => _OrderReceivedPopupState();
}

class _OrderReceivedPopupState extends State<_OrderReceivedPopup>
    with SingleTickerProviderStateMixin {
  bool _showReceipt = false;
  late AnimationController _checkAnimationController;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _checkAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _checkAnimationController,
        curve: Curves.elasticOut,
      ),
    );
    _checkAnimationController.forward();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showReceipt = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _checkAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: MediaQuery.of(context).size.width * 0.85,
          constraints: BoxConstraints(
            maxHeight: _showReceipt
                ? MediaQuery.of(context).size.height * 0.7
                : 250,
          ),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: _showReceipt ? _buildReceipt() : _buildOrderReceived(),
        ),
      ),
    );
  }

  Widget _buildOrderReceived() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _checkAnimation,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.checkmark_alt,
              color: Colors.green.shade700,
              size: 50,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Order Received',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Thank you for your order!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildReceipt() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.doc_text,
                  size: 40,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Order Receipt',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Order #${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...widget.cartItems.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${item.quantity}x ${item.food.name}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(
                    'RM ${(item.food.price * item.quantity).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'RM ${widget.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SST (6%)',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'RM ${widget.sstTax.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'RM ${widget.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: widget.onDismiss,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Ok',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
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
                  'RM ${(item.food.price * item.quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(RemoveFromCart(item.food.name));
                },
                icon: const Icon(
                  CupertinoIcons.trash,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(
                              UpdateQuantity(item.food.name, item.quantity - 1),
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
                        context.read<CartBloc>().add(
                              UpdateQuantity(item.food.name, item.quantity + 1),
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

