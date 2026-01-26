import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'details_screen.dart';
import 'cart_screen.dart';
import 'package:food_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:food_app/blocs/cart_bloc/cart_event.dart';
import 'package:food_app/blocs/cart_bloc/cart_state.dart';
import 'package:food_app/models/cart_item.dart';

/// -----------------------------
/// Dummy Food Model
/// -----------------------------
class DummyFood {
  final String name;
  final String shortDescription;
  final String fullDescription;
  final double price;
  final bool isVeg;
  final int spicy;
  final String image;

  DummyFood({
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.price,
    required this.isVeg,
    required this.spicy,
    required this.image,
  });

  String? get id => null;
}

/// -----------------------------
/// Dummy Food Data
/// -----------------------------
final List<DummyFood> dummyFoods = [
  DummyFood(
    name: "Nasi Lemak",
    shortDescription: "Dive into coconut rice sparkle!",
    fullDescription:
        "Fragrant rice cooked in coconut milk and pandan leaf. Served with spicy sambal, crunchy fried anchovies (ikan bilis), toasted peanuts, cucumber slices, and a hard-boiled egg.",
    price: 12.0,
    isVeg: false,
    spicy: 1,
    image: "assets/1.png",
  ),
  DummyFood(
    name: "Satay",
    shortDescription: "Grab the spicy peanut chicken!",
    fullDescription: "Skewered and grilled marinated chicken meat, served with a rich and spicy peanut dipping sauce, compressed rice cakes (nasi impit), onions, and cucumber.",
    price: 14.0,
    isVeg: false,
    spicy: 3,
    image: "assets/2.png",
  ),
  DummyFood(
    name: "Mee Goreng",
    shortDescription: "Taste the tangy fish noodles!",
    fullDescription: "A sour and spicy fish-based noodle soup. Features thick rice noodles in a tangy mackerel broth with tamarind (asam), topped with mint, pineapple, onions, and prawn paste (hae ko).",
    price: 10.0,
    isVeg: false,
    spicy: 2,
    image: "assets/3.png",
  ),
  DummyFood(
    name: "Beef Rendang",
    shortDescription: "Enjoy slow‑cooked spiced beef!",
    fullDescription: "Tender beef slow-cooked for hours in coconut milk and a paste of mixed spices (ginger, turmeric, lemongrass, galangal, chili) until the sauce caramelizes and coats the meat.",
    price: 15.0,
    isVeg: false,
    spicy: 2,
    image: "assets/4.png",
  ),
  DummyFood(
    name: "Roti Canai with Curry",
    shortDescription: "Dip crispy flatbread now!",
    fullDescription: "A popular Malaysian flatbread that is crispy on the outside and soft on the inside. Served with a side of dhal (lentil curry) or chicken curry for dipping.",
    price: 13.0,
    isVeg: true,
    spicy: 1,
    image: "assets/5.png",
  ),
];

/// -----------------------------
/// Banner Slider Widget
/// -----------------------------
class HomeBannerSlider extends StatelessWidget {
  const HomeBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = [
      'assets/conceptArt2.png',
      'assets/conceptArt1.png',
      
    ];

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: banners.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              banners[index],
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

/// -----------------------------
/// Home Screen
/// -----------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset(
              'assets/10.png',
              scale: 14,
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'FoodKuala',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    ),
                    icon: const Icon(CupertinoIcons.cart),
                  ),
                  if (state.itemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${state.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),

      /// -----------------------------
      /// BODY
      /// -----------------------------
      body: CustomScrollView(
        slivers: [
          /// 🔥 Deals Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Hot Deals',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Icon(CupertinoIcons.chevron_right),
                ],
              ),
            ),
          ),

          /// 🔥 Horizontal Banner Slider (SCROLLS WITH CONTENT)
          const SliverToBoxAdapter(
            child: HomeBannerSlider(),
          ),

          /// 🧩 Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),

          /// 🍕 Food Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final food = dummyFoods[i];

                  return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(food),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Image.asset(
                                food.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        food.isVeg ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    food.isVeg ? 'VEG' : 'NON-VEG',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    food.spicy == 1
                                        ? '🌶 BLAND'
                                        : food.spicy == 2
                                            ? '🌶 BALANCE'
                                            : '🌶 SPICY',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800,
                                      color: food.spicy == 1
                                          ? Colors.green
                                          : food.spicy == 2
                                              ? Colors.orange
                                              : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              food.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              food.shortDescription,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "RM ${food.price.toStringAsFixed(2)}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    context.read<CartBloc>().add(
                                          AddToCart(
                                            CartItem(
                                              food: food,
                                              id: '',
                                              name: '',
                                              price: food.price,
                                              image: '',
                                            ),
                                          ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('${food.name} added to cart'),
                                        duration:
                                            const Duration(seconds: 1),
                                        behavior:
                                            SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.add_circled_solid,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
                childCount: dummyFoods.length,
              ),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 9 / 16,
              ),
            ),
          ),

          /// bottom spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),

    );
  }
}


