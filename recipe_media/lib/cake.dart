import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Black Forest Cake Recipe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BlackForestCakeScreen(),
    );
  }
}

class BlackForestCakeScreen extends StatelessWidget {
  const BlackForestCakeScreen({super.key});

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
                    image: AssetImage('assets/images/cake1.png'),
                  ),
                ),
              ),
              Text(
                'Black Forest Cake Recipe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Calories: Approximately 350 per serving',
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
                '- 1 3/4 cups all-purpose flour\n'
                '- 2 cups granulated sugar\n'
                '- 3/4 cup unsweetened cocoa powder\n'
                '- 1 1/2 teaspoons baking powder\n'
                '- 1 1/2 teaspoons baking soda\n'
                '- 1 teaspoon salt\n'
                '- 2 large eggs\n'
                '- 1 cup whole milk\n'
                '- 1/2 cup vegetable oil\n'
                '- 2 teaspoons vanilla extract\n'
                '- 1 cup boiling water\n'
                '- 1 can (21 ounces) cherry pie filling\n'
                '- 3 cups heavy whipping cream\n'
                '- 1/3 cup powdered sugar\n'
                '- 1/4 cup grated dark chocolate\n',
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
                '1. Preheat oven to 350°F (175°C). Grease and flour two 9-inch round baking pans.\n'
                '2. In a large bowl, stir together flour, sugar, cocoa, baking powder, baking soda, and salt.\n'
                '3. Add eggs, milk, oil, and vanilla; beat on medium speed for 2 minutes. Stir in boiling water (batter will be thin).\n'
                '4. Pour batter into prepared pans and bake for 30 to 35 minutes or until a toothpick inserted in the center comes out clean.\n'
                '5. Cool for 10 minutes; remove from pans to wire racks. Cool completely.\n'
                '6. Split each cake layer horizontally into two layers. Reserve 1/2 cup cherry pie filling; set aside.\n'
                '7. Beat the whipping cream and powdered sugar in a chilled medium bowl until stiff peaks form.\n'
                '8. Place one cake layer on a serving plate; spread with 1 cup whipped cream and top with 1/3 of the remaining cherry pie filling. Repeat layers.\n'
                '9. Top with the remaining cake layer. Frost sides and top with remaining whipped cream. Decorate with reserved cherry pie filling and grated chocolate.\n'
                '10. Refrigerate until ready to serve.\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
