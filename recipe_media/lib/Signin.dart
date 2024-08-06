import 'package:flutter/material.dart';
import 'package:recipe_media/Functions.dart';
import 'package:recipe_media/HomeScreen.dart';
import 'package:recipe_media/LoginPage.dart';
import 'package:recipe_media/SupabaseFunctions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  _SigninState createState() => _SigninState();
}

final supabase = Supabase.instance.client;

class _SigninState extends State<Signin> {
  bool isLoading = false;
  final TextEditingController userNamecmd = TextEditingController();
  final TextEditingController emailcmd = TextEditingController();
  final TextEditingController mobilecmd = TextEditingController();
  final TextEditingController passWordcmd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool select = true;
  bool agreeToTerms = false;
  Future<bool> isLogedIn = getData();
  String? registerVerify(String? value, statement) {
    if (value == null || value.isEmpty) {
      return '$statement';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/signin.png'),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(251, 109, 59, 1.0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Create new account",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(251, 109, 59, 1.0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userNamecmd,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              prefixIcon: const Icon(Icons.person,
                                  color: Colors.orange),
                              hintText: "Username",
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
                              return registerVerify(
                                  value, "Please enter a valid username");
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                              controller: emailcmd,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                prefixIcon: const Icon(Icons.email,
                                    color: Colors.orange),
                                hintText: "Email",
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
                                return registerVerify(
                                    value, "Please enter a valid email");
                              }),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: mobilecmd,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              prefixIcon:
                                  const Icon(Icons.phone, color: Colors.orange),
                              hintText: "Mobile number",
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
                              return registerVerify(
                                  value, "Please enter a valid mobile number");
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: select,
                            controller: passWordcmd,
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
                              return registerVerify(
                                  value, "Please enter a valid password");
                            },
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await SignUp(
                                context,
                                emailcmd.text,
                                passWordcmd.text,
                                mobilecmd.text,
                                userNamecmd.text,
                                );
                              setState(() {
                                isLoading = false;
                              });
                              if (_formKey.currentState!.validate() &&
                                  agreeToTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content:
                                        Text("Please Verify your account in Gmail."),
                                  ),
                                );
                                // addDataTO(true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              } else if (!agreeToTerms) {
                                addDataTO(false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "You must agree to the terms and conditions to sign up.")),
                                );
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
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: agreeToTerms,
                                onChanged: (bool? value) {
                                  setState(() {
                                    agreeToTerms = value ?? false;
                                  });
                                },
                              ),
                              const Text(
                                "I agree to the ",
                                style: TextStyle(
                                    color: Color.fromRGBO(251, 109, 59, 1.0)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          "THESE ARE THE TERMS AND CONDITIONS"),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Terms and Conditions",
                                  style: TextStyle(
                                    color: Color.fromRGBO(251, 109, 59, 1.0),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
