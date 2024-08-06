// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_media/Functions.dart';
import 'package:recipe_media/HomeScreen.dart';
// import 'package:recipe_media/HomeScreen.dart';
import 'package:recipe_media/ViewRecipe.dart';
import 'package:recipe_media/supabaseFunctions.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://umncqlsqzzhvwpeuegok.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVtbmNxbHNxenpodndwZXVlZ29rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEyMzg1MDgsImV4cCI6MjAzNjgxNDUwOH0.htVdbfNfffnHdAnUGMxJDaRfKxR2_AYBlIxfKXqvxSg';
String tableName = "userRecipe_duplicate";

Future<void> main() async {
  // await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(MyApp());
}

// Get a reference your Supabase client
// final supabase = SupabaseClient(supabaseUrl, supabaseKey);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateNewRecipe(),
    );
  }
}

class CreateNewRecipe extends StatefulWidget {
  const CreateNewRecipe({super.key});

  @override
  _CreateNewRecipeState createState() => _CreateNewRecipeState();
}

class _CreateNewRecipeState extends State<CreateNewRecipe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController kcalController = TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  List<TextEditingController> ingredientControllers = [];
  List<TextEditingController> stepControllers = [];

  bool isVeg = false;
  bool isNonVeg = false;
  XFile? pickedImage;
 
  bool imagePicked = true;   



  
  

  // Future<Image> extractImageFromBlob(Uint8List blobData) async {
  // // Decode the image data
  // final image = img.decodeImage(blobData);
  // // return null;
// }

  // Future<String?> uploadImage(String bytes) async {

  //   print('$bytes -- bytes');
  //   final filename = pickedImage!.name;
  //   final extension = filename.split('.').last;
  //   final mimeTypes = {
  //     'jpg': 'image/jpeg',
  //     'jpeg': 'image/jpeg',
  //     'png': 'image/png',
  //     'gif': 'image/gif',
  //     'bmp': 'image/bmp',
  //     'webp': 'image/webp',
  //   };

  //   // Determine MIME type based on extension
  //   final mimeType = mimeTypes[extension.toLowerCase()];

  //   // Handle cases where extension is not found
  //   if (mimeType == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Unable to determine MIME type')),
  //     );
  //     return null;
  //   }

  //   // Upload to Supabase storage
  //   // final response = await supabase.storage
  //   //     .from('images') // Replace 'images' with your bucket name
  //   //     .uploadBinary(filename, bytes, fileOptions: FileOptions(
  //   //   cacheControl: '3600',
  //   //   contentType: mimeType,
  //   // ));
  //   // print(response+"HIIIII");
  //   // if (response != null) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(content: Text('Upload failed: ${response}')),
  //   //   );
  //   //   return null;
  //   // } else {
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     const SnackBar(content: Text('Upload successful!')),
  //   //   );
  //   //   return response;
  //   // }
  // }
 @override
  void initState() {
    super.initState();
    imageUrlController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    imageUrlController.removeListener(_updateButtonState);
    imageUrlController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {});
  }
  void addIngredient() {
    setState(() {
      ingredientControllers.add(TextEditingController());
    });
  }

  void addStep() {
    setState(() {
      stepControllers.add(TextEditingController());
    });
  }
// void checkImagePickedStatus() async {
  
//    Pickedimage(false);
//   bool a = await Ispickedimage();
//   imagePicked=a;
// }
 
 

  Future<bool?> showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible:
          false, // Dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Proceed'),
          content: Text('Are you sure you want to save?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Returns false when "No" button is pressed
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Returns true when "Yes" button is pressed
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
        ],
      ),
      backgroundColor: Color.fromRGBO(255, 183, 178, 1.0), // Light pink background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Post",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Upload Cover Picture",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: imageUrlController,
                  decoration: InputDecoration(
                    labelText: "Image Name",
                    labelStyle: TextStyle(color: Colors.brown),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                ),
                ElevatedButton( onPressed : imageUrlController.text.isEmpty && imagePicked
                      ? null
                      : () { pickImage(imageUrlController.text);setState(() {
                        imagePicked=false;
                      });},
                  child: Text(imagePicked ? 'Pick a image' : 'Finished Picking'),),
                SizedBox(height: 16),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(color: Colors.brown),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: Colors.brown),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: kcalController,
                        decoration: InputDecoration(
                          labelText: "kcal",
                          labelStyle: TextStyle(color: Colors.brown),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter kcal';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: prepTimeController,
                        decoration: InputDecoration(
                          labelText: "Preparation time",
                          labelStyle: TextStyle(color: Colors.brown),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter preparation time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text("Non-Veg"),
                        value: isNonVeg,
                        onChanged: (bool? value) {
                          setState(() {
                            isNonVeg = value ?? false;
                            if (isNonVeg)
                              isVeg = false; // Ensure only one is selected
                          });
                        },
                        activeColor: Colors.orange,
                        checkColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text("Veg"),
                        value: isVeg,
                        onChanged: (bool? value) {
                          setState(() {
                            isVeg = value ?? false;
                            if (isVeg)
                              isNonVeg = false; // Ensure only one is selected
                          });
                        },
                        activeColor: Colors.orange,
                        checkColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                Column(
                  children: ingredientControllers
                      .map((controller) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an ingredient';
                        }
                        return null;
                      },
                    ),
                  ))
                      .toList(),
                ),
                SizedBox(height: 8),
                TextButton.icon(
                  onPressed: addIngredient,
                  icon: Icon(Icons.add, color: Colors.orange),
                  label: Text(
                    "Add Ingredient",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Steps",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                Column(
                  children: stepControllers
                      .map((controller) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a step';
                        }
                        return null;
                      },
                    ),
                  ))
                      .toList(),
                ),
                SizedBox(height: 8),
                TextButton.icon(
                  onPressed: addStep,
                  icon: Icon(Icons.add, color: Colors.orange),
                  label: Text(
                    "Add Step",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool? confirmed =
                                await showLogoutConfirmationDialog(context);
                            if (confirmed == true) {
                        addDataDB(
                          ingredientControllers,
                          stepControllers,
                          titleController,
                          descriptionController,
                          kcalController,
                          prepTimeController,
                          imageUrlController,
                          tableName,
                          // isVeg,
                        );
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                        
                            }
                      }
                    },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Create Post",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
