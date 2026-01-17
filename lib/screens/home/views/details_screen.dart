// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_repository/food_repository.dart';
// import '../../../components/macro.dart';

// class DetailsScreen extends StatelessWidget {
//   final Food food;
//   const DetailsScreen(this.food, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.width -(40),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: const[
//                 BoxShadow(
//                   color: Colors.grey,
//                   offset: Offset(3,3),
//                   blurRadius: 5
//                 )
//               ],
//               image: const DecorationImage(
//               image: AssetImage(
//                 'assets/1.png'
//               )
//               )
//             ),
//           ),
//           SizedBox(height: 30,),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: const[
//                 BoxShadow(
//                   color: Colors.grey,
//                   offset: Offset(3,3),
//                   blurRadius: 5
//                 )
//               ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             "Truffle Temptation Extravaganza",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold
//                             ),
//                           ),
//                         ),
//                          Expanded(
//                           flex: 1,
//                            child: Align(
//                             alignment: Alignment.centerRight,
//                              child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                                children: [
//                                  Text(
//                                   "\$12.00",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).colorScheme.primary
//                                   ),
//                                 ),
//                                 Text(
//                                   "\$15.00",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                     decoration: TextDecoration.lineThrough
//                                   ),
//                                 ),
//                                ],
//                              ),
//                            ),
//                          )
//                       ],
//                     ),
//                     const SizedBox(height: 12,),
//                     Row(
//                       children: [
//                         const MyMacroWidget(
//                           title: "Calories",
//                           value: 267,
//                           icon: FontAwesomeIcons.fire,
//                         ),
//                         const SizedBox(width: 10,),
//                         const MyMacroWidget(
//                           title: "Protein",
//                           value: 36,
//                           icon: FontAwesomeIcons.dumbbell,
//                         ),
//                         const SizedBox(width: 10,),
//                         const MyMacroWidget(
//                           title: "Fat",
//                           value: 21,
//                           icon: FontAwesomeIcons.oilWell,
//                         ),
//                         const SizedBox(width: 10,),
//                         const MyMacroWidget(
//                           title: "Carbs",
//                           value: 38,
//                           icon: FontAwesomeIcons.breadSlice,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 40,),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: TextButton(
//                         onPressed: (){

//                         },
//                         style: TextButton.styleFrom(
//                           elevation: 3.0,
//                           backgroundColor: Colors.black,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)
//                           )
//                         ),
//                         child: Text(
//                           "Buy Now",
//                           style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../components/macro.dart';
import 'home_screen.dart';

class DetailsScreen extends StatelessWidget {
  final DummyFood food;
  const DetailsScreen(this.food, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView( // ✅ allows long content
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // ---------------- IMAGE ----------------
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(food.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- INFO CARD ----------------
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------- TITLE & PRICE ----------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            food.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${food.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                              ),
                            ),
                            const Text(
                              "\$15.00",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration:
                                    TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ---------- MACROS ----------
                    Row(
                      children: const [
                        MyMacroWidget(
                          title: "Calories",
                          value: 267,
                          icon: FontAwesomeIcons.fire,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: "Protein",
                          value: 36,
                          icon: FontAwesomeIcons.dumbbell,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: "Fat",
                          value: 21,
                          icon: FontAwesomeIcons.oilWell,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: "Carbs",
                          value: 38,
                          icon: FontAwesomeIcons.breadSlice,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ---------- FULL DESCRIPTION ----------
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      food.fullDescription,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ---------- BUY BUTTON ----------
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

