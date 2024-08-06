import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recipe_media/HomeScreen.dart';

void main() {
  runApp(GordonRamsayApp());
}

class GordonRamsayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gordon Ramsay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GordonRamsayHomePage(),
    );
  }
}

class GordonRamsayHomePage extends StatelessWidget {
  final List<Map<String, String>> awards = [
    {
      'title': '3 Michelin stars for Restaurant Gordon Ramsay, London',
      'image': 'assets/images/michelin_stars.jpg',
    },
    {
      'title': 'Officer of the Order of the British Empire (OBE)',
      'image': 'assets/images/obe.jpg',
    },
    {
      'title': '3 Times Catey Award for "Independent Restaurateur of the Year" winner',
      'image': 'assets/images/catey_award.jpg',
    },
    {
      'title': '"Best Chef in the UK" by the Food and Drink Awards',
      'image': 'assets/images/best_chef.jpg',
    },
    {
      'title': 'Forbes Celebrity 100 list multiple times',
      'image': 'assets/images/forbes.jpg',
    },
  ];

  final List<Map<String, String>> restaurants = [
    {
      'name': 'Restaurant Gordon Ramsay, London',
      'image': 'assets/images/restaurant_gordon_ramsay.jpg',
    },
    {
      'name': 'Pétrus, London',
      'image': 'assets/images/petrus.jpg',
    },
    {
      'name': 'Savoy Grill, London',
      'image': 'assets/images/savoy_grill.jpg',
    },
    {
      'name': 'Maze, London',
      'image': 'assets/images/maze.jpg',
    },
    {
      'name': 'Gordon Ramsay at The London, New York City',
      'image': 'assets/images/the_london.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEAE2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Container(
        color: Color.fromRGBO(255, 236, 227, 1.0),
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Image.asset(
                    'assets/images/hells.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: CircleAvatar(
                      radius: 50,
                      child: Image(image: AssetImage("assets/images/chef.png"),fit: BoxFit.contain,),
                    ),
                  ),
                ],
              ),
              Center(child: SizedBox(height: 16)),
              Text(
                'Gordon Ramsay',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange[600]
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Experience',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Gordon Ramsay is a world-renowned chef, restaurateur, and television personality. He has been awarded 16 Michelin stars in total and currently holds 7. He has a global empire of restaurants and has hosted numerous TV shows, including "Hell\'s Kitchen", "MasterChef", and "Kitchen Nightmares".',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Awards',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: awards.map((award) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(award['image']!),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              award['title']!,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. "Kitchen Confidential" by Anthony Bourdain.\n'
                '2. "The Professional Chef" by The Culinary Institute of America.\n'
                '3. "Larousse Gastronomique".\n'
                '4. "The French Laundry Cookbook" by Thomas Keller.\n'
                '5. "Culinary Artistry" by Andrew Dornenburg and Karen Page.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Famous Restaurants',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 250.0, // Set a fixed height for the horizontal ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 300.0, // Set a fixed width for each restaurant item
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              restaurants[index]['image']!,
                              fit: BoxFit.fill,
                              width: 300,
                              height: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                restaurants[index]['name']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
