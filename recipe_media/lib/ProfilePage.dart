// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:recipe_media/CreateNewReceipe.dart';
import 'package:recipe_media/HomeScreen.dart';
import 'package:recipe_media/SupabaseFunctions.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Stream<List<Map<String, dynamic>>> _data;
  late Stream<List<Map<String, dynamic>>> response;
  late Future<int> a;

// Future<int> getData() async {
//       print("TEST BELOW");
//       a = response.length;
//       final result = await getData();
//   return a;
// }

  @override
  void initState() {
    super.initState();
    _data = Supabase.instance.client.from(tableName).stream(
      primaryKey: ["id"],
    );
    print("TEST BELOW");
    response = Supabase.instance.client
        .from('userRecipe_duplicate')
        .stream(primaryKey: ["id"]);
    // print(result);
  }

  Future<String> noOfRecipes() async {
    try {
      final response = await Supabase.instance.client
          .from('userRecipe_duplicate')
          .stream(primaryKey: ["id"]).toList();
    } catch (e) {
      print(e);
    }
    return 'test';
  }

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Profile',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  // backgroundImage: AssetImage('assets/images/profile_picture.png'), // replace with your image asset
                ),
                SizedBox(height: 16),
                Text(
                  getCurrentUserName(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Food Enthusiast',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        StreamBuilder<List<Map<String, dynamic>>>(
                          stream: response,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final notes = snapshot.data!;
                            return Text(
                              notes.length.toString(),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        Text('Recipes',
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: 16),
                Text(
                  'Mastering the trades!',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 16),
                // SizedBox(height: 24),
                Divider(color: Colors.orange, thickness: 1),
                SizedBox(height: 16),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _data,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final notes = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return ProfileCard(context, note);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Stack(clipBehavior: Clip.none, children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.grey,
                currentIndex: 1,
                onTap: (selectedIndex) {
                  if (selectedIndex == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  }
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Center(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.deepOrange,
                child: IconButton(
                  icon: Icon(Icons.add, size: 40, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateNewRecipe()),
                    );
                  },
                ),
              ),
            ),
          ),
        ]));
  }
}

class RecipeCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String likes;
  final String comments;

  const RecipeCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.orange, size: 16),
                      SizedBox(width: 4),
                      Text(likes,
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(width: 16),
                      Icon(Icons.comment, color: Colors.orange, size: 16),
                      SizedBox(width: 4),
                      Text(comments,
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
