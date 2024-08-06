import 'package:flutter/material.dart';
import 'package:recipe_media/CreateNewReceipe.dart';
import 'package:recipe_media/Functions.dart';
import 'package:recipe_media/supabaseFunctions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ViewRecipe(),
    );
  }
}

class ViewRecipe extends StatefulWidget {
  const ViewRecipe({super.key});

  @override
  State<ViewRecipe> createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  String? _storedString;
  @override
  void initState() {
    super.initState();
    _loadString();
    // _data = supabase.from("$tableName:title=eq.${recipeDirectGet()}").stream(primaryKey: ["id"]);
  }

  Future<void> _loadString() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedString = prefs.getString('recipeName');
    });
  }
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
      body: RecipeDetails(tableName, _storedString),);
  }
}