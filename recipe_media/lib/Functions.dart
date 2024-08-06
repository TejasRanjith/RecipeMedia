import 'package:shared_preferences/shared_preferences.dart';

Future<void> recipeDirectAdd(Map<String, dynamic> note) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("recipeName", note['title']);

}

Future<String?> recipeDirectGet() async {
  final prefs = await SharedPreferences.getInstance();
  print(prefs.getString("recipeName"));
  return prefs.getString("recipeName");
}

Future<void> _loadString() async {
    final prefs = await SharedPreferences.getInstance();
    (() {
      String? _storedString = prefs.getString('my_key');
      return _storedString;
    });
  }

recipeDirectDelete() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("recipeName");
}


Future<void> addDataTO(bool isLogedIn) async{

  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("isUserLogedIn", isLogedIn);

}

Future<bool> getData() async{

final prefs = await SharedPreferences.getInstance();
bool? data = prefs.getBool("isUserLogedIn");
if(data==null){
data=false;}

return data;
} 