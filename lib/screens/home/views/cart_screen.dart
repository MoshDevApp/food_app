import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:food_app/blocs/cart_bloc/cart_event.dart';
import 'package:food_app/blocs/cart_bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _showOrderReceivedDialog(BuildContext context, CartState state) {
    final subtotal = state.totalPrice;
    final sstTax = subtotal * 0.06;
    final totalWithTax = subtotal + sstTax;
    
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => _OrderReceivedPopup(
        items: state.items,
        subtotal: subtotal,
        sstTax: sstTax,
        totalPrice: totalWithTax,
        onDismiss: () {
          context.read<CartBloc>().add(ClearCart());
          Navigator.of(context).pop();
        },
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(ClearCart());
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart cleared')),
              );
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final subtotal = state.totalPrice;
        final sstTax = subtotal * 0.06;
        final totalWithTax = subtotal + sstTax;
        
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [
              if (state.items.isNotEmpty)
                IconButton(
                  onPressed: () => _showClearAllDialog(context),
                  icon: const Icon(CupertinoIcons.trash, color: Colors.red),
                  tooltip: 'Clear All',
                ),
            ],
          ),
          body: state.items.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.cart, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: const Offset(0, 2))],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(item.food.image, width: 80, height: 80, fit: BoxFit.cover),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.food.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text('RM ${item.food.price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => context.read<CartBloc>().add(UpdateQuantity(item.food.name, item.quantity - 1)),
                                        icon: const Icon(CupertinoIcons.minus_circle, color: Colors.red),
                                      ),
                                      Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      IconButton(
                                        onPressed: () => context.read<CartBloc>().add(UpdateQuantity(item.food.name, item.quantity + 1)),
                                        icon: Icon(CupertinoIcons.plus_circle, color: Theme.of(context).colorScheme.primary),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () => context.read<CartBloc>().add(RemoveFromCart(item.food.name)),
                                    icon: const Icon(CupertinoIcons.trash, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, -2))],
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal', style: TextStyle(color: Colors.grey)),
                                Text('RM ${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('SST (6%)', style: TextStyle(color: Colors.grey)),
                                Text('RM ${sstTax.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const Divider(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                Text('RM ${totalWithTax.toStringAsFixed(2)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _showOrderReceivedDialog(context, state),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 16)),
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
}

class _OrderReceivedPopup extends StatefulWidget {
  final List items;
  final double subtotal;
  final double sstTax;
  final double totalPrice;
  final VoidCallback onDismiss;

  const _OrderReceivedPopup({
    required this.items,
    required this.subtotal,
    required this.sstTax,
    required this.totalPrice,
    required this.onDismiss,
  });

  @override
  State<_OrderReceivedPopup> createState() => _OrderReceivedPopupState();
}

class _OrderReceivedPopupState extends State<_OrderReceivedPopup> with SingleTickerProviderStateMixin {
  bool _showReceipt = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _showReceipt = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
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
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade100, shape: BoxShape.circle),
            child: const Icon(CupertinoIcons.checkmark_alt, color: Colors.green, size: 48),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Order Received!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Preparing your receipt...', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildReceipt() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(CupertinoIcons.doc_text, size: 40, color: Colors.black54),
        const SizedBox(height: 12),
        const Text('Receipt', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Divider(height: 24),
        ...widget.items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('${item.food.name} x${item.quantity}', overflow: TextOverflow.ellipsis)),
              Text('RM ${(item.food.price * item.quantity).toStringAsFixed(2)}'),
            ],
          ),
        )),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subtotal', style: TextStyle(color: Colors.grey)),
            Text('RM ${widget.subtotal.toStringAsFixed(2)}'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('SST (6%)', style: TextStyle(color: Colors.grey)),
            Text('RM ${widget.sstTax.toStringAsFixed(2)}'),
          ],
        ),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('RM ${widget.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onDismiss,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Ok', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
