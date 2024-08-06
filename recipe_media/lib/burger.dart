import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burger Recipe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BurgerRecipeScreen(),
    );
  }
}

class BurgerRecipeScreen extends StatelessWidget {
  const BurgerRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEAE2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFFFEAE2),
        padding: const EdgeInsets.all(16.0),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 200, // Space for an image
                child: Center(
                  child: Image(
                    image:AssetImage('assets/images/burger1.png'),
                  ),
                ),
              ),
              Text(
                'Burger Recipe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Calories: Approximately 500 per serving',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Ingredients:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- 1 pound ground beef\n'
                '- 1/2 teaspoon salt\n'
                '- 1/2 teaspoon black pepper\n'
                '- 1/2 teaspoon garlic powder\n'
                '- 1/2 teaspoon onion powder\n'
                '- 4 hamburger buns\n'
                '- 4 slices cheddar cheese\n'
                '- Lettuce leaves\n'
                '- Tomato slices\n'
                '- Pickles\n'
                '- Ketchup\n'
                '- Mustard\n'
                '- Mayonnaise\n',
              ),
              SizedBox(height: 16),
              Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Preheat your grill to medium-high heat.\n'
                '2. In a large bowl, mix the ground beef with salt, pepper, garlic powder, and onion powder until well combined.\n'
                '3. Divide the mixture into 4 equal portions and shape each portion into a patty.\n'
                '4. Place the patties on the preheated grill and cook for about 4-5 minutes per side, or until they reach your desired level of doneness.\n'
                '5. During the last minute of cooking, place a slice of cheddar cheese on each patty and allow it to melt.\n'
                '6. Toast the hamburger buns on the grill for about 1-2 minutes, or until lightly browned.\n'
                '7. Assemble the burgers by placing each patty on the bottom half of a bun, followed by lettuce, tomato, pickles, and your choice of condiments.\n'
                '8. Cover with the top half of the bun and serve immediately.\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
