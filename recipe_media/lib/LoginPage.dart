import 'package:flutter/material.dart';
import 'package:recipe_media/Functions.dart';
import 'package:recipe_media/HomeScreen.dart';
import 'package:recipe_media/Signin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bool select = true;
const String correctPass = "12345";
const String correctUser = "hi";
final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool verify() {
    if (correctUser == userNameController.text &&
        correctPass == passwordController.text) {
      addDataTO(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      return true;
    } else {
      addDataTO(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Invalid Username and Password, Please try again.")),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.52,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/login.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.deepOrange[400],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepOrange[400],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              prefixIcon: const Icon(Icons.portrait,
                                  color: Colors.orange),
                              hintText: "Username or email id",
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent[700],
                                  fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid username';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            obscureText: select,
                            controller: passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.orange),
                              suffixIcon: IconButton(
                                icon: select
                                    ? const Icon(Icons.visibility_off_sharp,
                                        color: Colors.orange)
                                    : const Icon(Icons.visibility,
                                        color: Colors.orange),
                                onPressed: () {
                                  setState(() {
                                    select = !select;
                                  });
                                },
                              ),
                              hintText: "Password",
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent[700],
                                  fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await authentication(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            addDataTO(true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signin()),
                            );
                          },
                          child: Text(
                            "Not a user? Sign up now",
                            style: TextStyle(color: Colors.deepOrange[400]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> authentication(BuildContext context) async {
    final sm = ScaffoldMessenger.of(context);
    try {
      final authResponse =
          await supabase.auth.signInWithPassword(
        password: passwordController.text,
        email: userNameController.text,
      );
      addDataTO(true);
      final authSubscription = supabase
          .auth.onAuthStateChange
          .listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;
    
        if (event == AuthChangeEvent.signedIn) {
          sm.showSnackBar(
            SnackBar(
              content: Text(
                  'Logged in as ${authResponse.user!.email}'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen()),
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
}
