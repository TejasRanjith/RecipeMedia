import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_media/Functions.dart';
import 'package:recipe_media/ViewRecipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_media/HomeScreen.dart';
import 'dart:typed_data';

const supabaseUrl = 'https://umncqlsqzzhvwpeuegok.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVtbmNxbHNxenpodndwZXVlZ29rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEyMzg1MDgsImV4cCI6MjAzNjgxNDUwOH0.htVdbfNfffnHdAnUGMxJDaRfKxR2_AYBlIxfKXqvxSg';

class MySecureStorage implements GotrueAsyncStorage {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> store(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> retrieve(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<String?> getItem({required String key}) async {
    // You might not need this method specifically for signup.
    throw UnimplementedError();
  }

  @override
  Future<void> removeItem({required String key}) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> setItem({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}

final storage = MySecureStorage();
final init = Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey, authOptions: FlutterAuthClientOptions(
  pkceAsyncStorage: MySecureStorage(),
));
final supabase = SupabaseClient(supabaseUrl, supabaseKey, authOptions: AuthClientOptions(
  pkceAsyncStorage: storage,
));

Future<void> SignUp(BuildContext context,
    String email,
    String password,
    String mobile,
    String username) async {
  print('$email, $password, $mobile, $username');
  final sm = ScaffoldMessenger.of(context);
  try {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      // phone: mobile,
      data: {"username": username},
    );

    // final authSubscription = supabase.auth.onAuthStateChange.listen((data) {
    //   final AuthChangeEvent event = data.event;
    //   final Session? session = data.session;
    //   if (event == AuthChangeEvent.signedIn) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const HomeScreen()),
    //     );
    //   }
    // });

    // Unsubscribe from the listener when needed
    // ...
  } catch (error) {
    sm.showSnackBar(SnackBar(content: Text('Error: $error')));
    print(error);
  }
}

String logoutCurrentUser() {
  final supabase = Supabase.instance.client;
  supabase.auth.signOut();
  addDataTO(false);
  return 'Logged out';
}

String getCurrentUserName() {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user != null) {
    return user.userMetadata!['username'];
  } else {
    // Handle case where user is not logged in
    return 'empty_bruv';
  }
}

String getCurrentUserId() {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user != null) {
    return user.id;
  } else {
    // Handle case where user is not logged in
    return 'empty_bruv';
  }
}

final user = getCurrentUserId();
String imageUrl(String name) {
  try {
    return supabase.storage.from('images').getPublicUrl('$user+$name.png');
  } catch (e) {
    print(e);
    return 'https://via.placeholder.com/150';
  }
}

Padding ProfileCard(BuildContext context,Map<String, dynamic> note) {
  // Map<String, dynamic> note = {
  //   'title': 'title',
  //   'description': 'description',
  //   'kcal': 'kcal',
  //   'prepTime': 'prepTime',
  //   'imageName': 'imageName',
  // };
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        recipeDirectAdd(note);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewRecipe(),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                imageUrl(note['imageName']), // replace with your image asset
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note['title'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        note['description'],
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Text(
                      "${note['kcal']} kcal",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      note['prepTime'],
                      style: const TextStyle(fontSize: 14, color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void addDataDB(
  List<TextEditingController> ingredientControllers,
  List<TextEditingController> stepControllers,
  TextEditingController titleController,
  TextEditingController descriptionController,
  TextEditingController kcalController,
  TextEditingController prepTimeController,
  TextEditingController imageUrlController,
  String tableName,
  // bool isVeg,
) async {
  List<String> ingredients =
      ingredientControllers.map((controller) => controller.text).toList();
  List<String> steps =
      stepControllers.map((controller) => controller.text).toList();
  String ingredientsJsonArray =
      '[${ingredients.map((text) => '"$text"').join(', ')}]';
  String stepsJsonArray = '[${steps.map((text) => '"$text"').join(', ')}]';
  try {
    final response = await supabase.from('$tableName').insert({
      // 'recipeId': '${getCurrentUserId()}+${titleController.text}',
      'title': titleController.text,
      'description': descriptionController.text,
      'kcal': int.parse(kcalController.text),
      'prepTime': prepTimeController.text,
      'imageName': imageUrlController.text,
      'ingredients': ingredientsJsonArray,
      'steps': stepsJsonArray,
      // 'isVeg': isVeg,
    });
  } catch (e) {
    print(e);
  }
}

Future<void> pickImage(String name) async {
  final imagePicker = ImagePicker();
  final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  final Uint8List bytes = await image!.readAsBytes();
  final user = await getCurrentUserId();
  try {
    var response = await supabase.storage
        .from('images')
        .uploadBinary('$user+$name.png', bytes);
  } catch (e) {
    print(e);
  }
}

// Future<void> _loadString() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       String? _storedString = prefs.getString('my_key');
//       return _storedString;
//     });
//   }

StreamBuilder<List<Map<String, dynamic>>> RecipeDetails(String tableName,String? type) {
  late Stream<List<Map<String, dynamic>>> _data;
  
  // String type = recipeDirectGet();
  _data = supabase.from(tableName).select('*').eq('title', type!).asStream();
  print(_data);
  return StreamBuilder<List<Map<String, dynamic>>>(
    stream: _data,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
        }
        final notes = snapshot.data!;
        return ListView.builder(
           shrinkWrap: true,
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Container(
        color: const Color(0xFFFFEAE2),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 200, // Space for an image
                child: Center(
                  child: Image(
                    image: NetworkImage(imageUrl(note['imageName'])),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:18.0,left: 18.0),
                child: Text(
                  note['title'],
                  style:const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Calories: ${note['kcal']} kcal',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingredients:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                note['ingredients'].toString().replaceAll('[', ' ').replaceAll(']', '').replaceAll('"', '').replaceAll(',', '\n'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                note['steps'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll('"', '').replaceAll(',','\n' ),
              ),
            ],
          ),
        ),
      );
          },
        );
      },
    );
}

Future<void> authentication(
    BuildContext context, String pass, String email) async {
  final sm = ScaffoldMessenger.of(context);
  try {
    final authResponse = await supabase.auth.signInWithPassword(
      password: pass,
      email: email,
    );

    final authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn) {
        sm.showSnackBar(
          SnackBar(
            content: Text('Logged in as ${authResponse.user!.email}'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  } catch (error) {
    sm.showSnackBar(
      SnackBar(
        content: Text('Error logging in: $error'),
      ),
    );
  }
}
