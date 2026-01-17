// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
// import 'package:food_app/screens/home/blocs/get_food_bloc/get_food_bloc.dart';
// import 'package:food_app/screens/home/views/details_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//         title: Row(
//           children: [
//             Image.asset('assets/8.png', scale: 14),
//             const SizedBox(width: 8),
//             const Text(
//               'FOOD',
//               style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.cart)),
//           IconButton(
//             onPressed: () {
//               context.read<SignInBloc>().add(SignOutRequired());
//             },
//             icon: Icon(CupertinoIcons.arrow_right_to_line),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BlocBuilder<GetFoodBloc, GetFoodState>(
//           builder: (context, state) {
//             if(state is GetFoodSuccess) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 9 / 16,
//               ),
//               itemCount: state.foods.length,
//               itemBuilder: (context, int i) {
//                 return Material(
//                   elevation: 3,
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(20),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute<void>(
//                           builder: (BuildContext context) => DetailsScreen(
//                                 state.foods[i]
//                               ),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /*Image.network(state.foods[i].picture)*/
//                         Image.asset('assets/2.png'),  //image.asset
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: 
//                                     state.foods[i].isVeg
//                                       ? Colors.green
//                                       : Colors.red,
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 4,
//                                     horizontal: 8,
//                                   ),
//                                   child: Text(
//                                     state.foods[i].isVeg
//                                       ? 'ViGI'
//                                       : 'NON-ViGI',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 10,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.green.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 4,
//                                     horizontal: 8,
//                                   ),
//                                   child: Text(
//                                     state.foods[i].spicy == 1
//                                       ? '🌶BLAND'
//                                       : state.foods[i].spicy == 2
//                                         ? '🌶BALANCE'
//                                         : '🌶SPICY',
//                                     style: TextStyle(
//                                       color:state.foods[i].spicy == 1
//                                       ? Colors.green
//                                       : state.foods[i].spicy == 2
//                                         ? Colors.orange
//                                         : Colors.redAccent,
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 10,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Text(
//                             /*state.foods[i].name*/
//                             'Chessy Marvel',
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Text(
//                             /*state.foods[i].description*/
//                             'A delicious cheese pizza topped with fresh mozzarella.',
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.grey.shade500,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Row(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     /*"\$${state.foods[i].price}.00"*/
//                                     "\$12.00",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Theme.of(
//                                         context,
//                                       ).colorScheme.primary,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     "\$15.00",
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey.shade500,
//                                       fontWeight: FontWeight.w700,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(CupertinoIcons.add_circled_solid),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//             } else if(state is GetFoodLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return Center(
//                 child: Text(
//                   'An Error has Occured....'
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'details_screen.dart';
//=================================================================================
import 'package:flutter_bloc/flutter_bloc.dart';
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
}


/// -----------------------------
/// Dummy Food Data (10 items)
/// Change image paths as you want
/// -----------------------------
final List<DummyFood> dummyFoods = [
  DummyFood(
    name: "Cheesy Marvel",
    shortDescription: "Loaded cheese pizza with mozzarella",
    fullDescription:
        "Cheesy Marvel is a cheese-lover’s dream. Built on a hand-tossed crust, "
        "it features a rich tomato base, premium mozzarella, cheddar blend, "
        "and a golden-baked finish that melts perfectly with every bite.",
    price: 12.0,
    isVeg: true,
    spicy: 1,
    image: "assets/1.png",
  ),

  DummyFood(
    name: "Spicy Beast",
    shortDescription: "Hot & spicy chicken delight",
    fullDescription:
        "Spicy Beast brings the heat with marinated chicken, fiery chili sauce, "
        "crushed red peppers, and melted cheese. Designed for spice lovers who "
        "enjoy bold flavors and a strong kick.",
    price: 14.0,
    isVeg: false,
    spicy: 3,
    image: "assets/2.png",
  ),

  DummyFood(
    name: "Veggie Crunch",
    shortDescription: "Fresh vegetables on crispy base",
    fullDescription:
        "Veggie Crunch combines garden-fresh bell peppers, olives, onions, "
        "sweet corn, and herbs on a crispy base. Light, refreshing, and full "
        "of natural flavors.",
    price: 10.0,
    isVeg: true,
    spicy: 2,
    image: "assets/3.png",
  ),

  DummyFood(
    name: "BBQ Blast",
    shortDescription: "Smoky BBQ chicken overload",
    fullDescription:
        "BBQ Blast is topped with smoky barbecue chicken, caramelized onions, "
        "and a tangy BBQ drizzle. Slow-cooked flavors make every slice rich "
        "and satisfying.",
    price: 15.0,
    isVeg: false,
    spicy: 2,
    image: "assets/4.png",
  ),

  DummyFood(
    name: "Paneer Power",
    shortDescription: "Indian paneer fusion pizza",
    fullDescription:
        "Paneer Power blends soft paneer cubes with Indian spices, capsicum, "
        "onions, and creamy cheese. A perfect fusion of Indian taste and "
        "classic pizza style.",
    price: 13.0,
    isVeg: true,
    spicy: 1,
    image: "assets/5.png",
  ),

  DummyFood(
    name: "Pepperoni King",
    shortDescription: "Classic pepperoni perfection",
    fullDescription:
        "Pepperoni King delivers bold, meaty flavor with premium pepperoni "
        "slices, mozzarella cheese, and a crispy crust. Simple, classic, "
        "and always satisfying.",
    price: 16.0,
    isVeg: false,
    spicy: 2,
    image: "assets/6.png",
  ),

  DummyFood(
    name: "Farm Fresh",
    shortDescription: "Organic veggies & herbs",
    fullDescription:
        "Farm Fresh is made with organic vegetables, fresh basil, olives, "
        "and light cheese. A healthy and aromatic option for clean eaters.",
    price: 11.0,
    isVeg: true,
    spicy: 1,
    image: "assets/1.png",
  ),

  DummyFood(
    name: "Fire Storm",
    shortDescription: "Extreme spicy chicken pizza",
    fullDescription:
        "Fire Storm is not for the faint-hearted. Packed with spicy chicken, "
        "hot sauce, jalapeños, and chili flakes for a blazing-hot experience.",
    price: 17.0,
    isVeg: false,
    spicy: 3,
    image: "assets/2.png",
  ),

  DummyFood(
    name: "Cheese Volcano",
    shortDescription: "Cheese bursting lava crust",
    fullDescription:
        "Cheese Volcano features a molten cheese-filled crust that erupts "
        "with flavor. Rich, creamy, and indulgent from the first bite.",
    price: 18.0,
    isVeg: true,
    spicy: 2,
    image: "assets/3.png",
  ),

  DummyFood(
    name: "Meat Feast",
    shortDescription: "All-meat loaded madness",
    fullDescription:
        "Meat Feast is stacked with chicken, beef, sausage, and pepperoni. "
        "High-protein, heavy, and made for serious meat lovers.",
    price: 20.0,
    isVeg: false,
    spicy: 3,
    image: "assets/4.png",
  ),
];


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
            Image.asset('assets/8.png', scale: 14),
            const SizedBox(width: 8),
            const Text(
              'FOOD',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
          ],
        ),
        //=====================================================================
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(CupertinoIcons.cart),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       context.read<SignInBloc>().add(SignOutRequired());
        //     },
        //     icon: const Icon(CupertinoIcons.arrow_right_to_line),
        //   ),
        // ],
        //====================================================
        actions: [
            // Cart icon with badge
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                      icon: const Icon(CupertinoIcons.cart),
                    ),
                    if (state.itemCount > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: Text('${state.itemCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ),
                  ],
                );
              },
            ),
            //======================================================================
            // IconButton(
            //     onPressed: () {
            //       context.read<CartBloc>().add(
            //         AddToCart(food: state.foods[i]),
            //       );
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('${state.foods[i].name} added to cart'),
            //           duration: const Duration(seconds: 1),
            //           behavior: SnackBarBehavior.floating,
            //         ),
            //       );
            //     },
            //     icon: const Icon(CupertinoIcons.add_circled_solid),
            //   ),
            //===========================================================
            GestureDetector(
              onTap: () {
                //context.read<CartBloc>().add(AddToCart(CartItem(food: state.foods[i])));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(/*${food.name}*/ 'Order added to cart'), duration: const Duration(seconds: 1)),
                );
              },
              child: Icon(CupertinoIcons.add_circled_solid, color: Theme.of(context).colorScheme.primary),
            ),

          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 9 / 16,
          ),
          itemCount: dummyFoods.length,
          itemBuilder: (context, i) {
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
                    // 🔥 FIX: Flexible image
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: food.isVeg ? Colors.green : Colors.red,
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
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
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
                                fontSize: 10,
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            "\$${food.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            CupertinoIcons.add_circled_solid,
                            color: Theme.of(context).colorScheme.primary,
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
        ),
      ),
    );
  }
}
