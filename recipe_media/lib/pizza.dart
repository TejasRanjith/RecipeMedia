import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Recipe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PizzaRecipeScreen(),
    );
  }
}

class PizzaRecipeScreen extends StatelessWidget {
  const PizzaRecipeScreen({super.key});

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
                    image: AssetImage('assets/images/pizza1.png'),
                  ),
                ),
              ),
              Text(
                'Pizza Recipe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Calories: Approximately 285 per slice',
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
                '- 1 1/2 cups warm water (110°F)\n'
                '- 1 packet active dry yeast\n'
                '- 3 1/2 cups all-purpose flour\n'
                '- 2 tablespoons olive oil\n'
                '- 2 teaspoons salt\n'
                '- 1 teaspoon sugar\n'
                '- 1/2 cup pizza sauce\n'
                '- 2 cups shredded mozzarella cheese\n'
                '- Toppings of your choice (pepperoni, bell peppers, onions, mushrooms, etc.)\n',
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
                '1. Preheat your oven to 475°F (245°C).\n'
                '2. In a small bowl, combine the warm water and yeast. Let it sit for about 5 minutes until it becomes frothy.\n'
                '3. In a large bowl, mix the flour, salt, and sugar. Add the yeast mixture and olive oil, and stir until the dough comes together.\n'
                '4. Knead the dough on a floured surface for about 5-7 minutes until smooth and elastic.\n'
                '5. Place the dough in a greased bowl, cover with a damp cloth, and let it rise in a warm place for about 1 hour, or until it has doubled in size.\n'
                '6. Punch down the dough and divide it into two equal portions. Roll out each portion into a 12-inch circle.\n'
                '7. Place the rolled-out dough onto a pizza stone or a baking sheet lined with parchment paper.\n'
                '8. Spread the pizza sauce over the dough, leaving a small border around the edges. Sprinkle with mozzarella cheese and add your favorite toppings.\n'
                '9. Bake in the preheated oven for 12-15 minutes, or until the crust is golden and the cheese is bubbly and slightly browned.\n'
                '10. Remove from the oven, let it cool for a few minutes, slice, and serve.\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
