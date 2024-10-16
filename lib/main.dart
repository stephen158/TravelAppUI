import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MaterialApp(
  home: TravelAppUI(),
  debugShowCheckedModeBanner: false,
));

class TravelAppUI extends StatefulWidget {
  @override
  _TravelAppUIState createState() => _TravelAppUIState();
}

class _TravelAppUIState extends State<TravelAppUI> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Map<String, dynamic>> locations = [
    {'name': 'India', 'image': 'assets/images/india.jpg'},
    {'name': 'Moscow', 'image': 'assets/images/china.jpg'},
    {'name': 'USA', 'image': 'assets/images/paris.jpg'},
  ];

  List<Map<String, dynamic>> filteredLocations = [];

  List<Map<String, dynamic>> mostViewed = [
    {'price': '\$90 / Night', 'title': 'Carinthia Lake see Breakfast', 'image': 'assets/images/house4.jpg', 'isFavorite': false},
    {'price': '\$300 / Night', 'title': 'Carinthia Lake see Breakfast', 'image': 'assets/images/house5.jpg', 'isFavorite': false},
    {'price': '\$240 / Night', 'title': 'Carinthia Lake see Breakfast', 'image': 'assets/images/house3.jpg', 'isFavorite': false},
  ];

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
  }

  void _filterLocations(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        filteredLocations = locations;
      });
    } else {
      setState(() {
        _isSearching = true;
        filteredLocations = locations
            .where((location) => location['name']
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _toggleFavorite(int index) {
    setState(() {
      mostViewed[index]['isFavorite'] = !mostViewed[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore the world! By',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Travelling ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Where did you go?',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: _filterLocations,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Icon(Icons.tune),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                'Popular Locations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: screenHeight * 0.2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: filteredLocations.map((location) {
                    return locationCard(location['name'], location['image']);
                  }).toList(),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Recommended',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: screenHeight * 0.30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    recommendedCard('\$120 / Night', 'Carinthia Lake see Breakfast...', 'assets/images/house1.jpg'),
                    recommendedCard('\$400 / Night', 'Carinthia Lake see Breakfast...', 'assets/images/house2.jpg'),
                    recommendedCard('\$240 / Night', 'Carinthia Lake see Breakfast...', 'assets/images/house3.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Container(
                margin: EdgeInsets.all(10),
                width: 500,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/images/ad.jpg',
                      fit: BoxFit.cover,
                      //width: 500,
                      ),
                    ),
                   Positioned(
                     left: 170,
                     top: 50,
                     child: Text('Hosting fee for ',style: TextStyle(color: Colors.white,fontSize: 25),),),
                    Positioned(
                      left: 180,
                      top: 80,
                      child: Text('as low as 1%',style: TextStyle(color: Colors.white,fontSize: 25),),),
                    SizedBox(height: 5,),
                    Positioned(
                      left: 180,
                      top: 140,
                      child: Text('Hosting fee for ',style: TextStyle(color: Colors.white,fontSize: 18,backgroundColor: Colors.red),),),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Text(
                'Most Viewed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                child: ListView.builder(
                  reverse: true, // Scroll up-to-bottom
                  shrinkWrap: true, // Ensure the ListView only takes required space
                  physics: ClampingScrollPhysics(), // Prevent scroll beyond list size
                  itemCount: mostViewed.length,
                  itemBuilder: (context, index) {
                    return viewedCard(
                      mostViewed[index]['price'],
                      mostViewed[index]['title'],
                      mostViewed[index]['image'],
                      mostViewed[index]['isFavorite'],
                      index,
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

  Widget locationCard(String location, String imagePath) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(10),
      width: 160,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.60,
              height: screenHeight * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.04,
            left: screenWidth * 0.13,
            child: Text(
              location,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recommendedCard(String price, String title, String imagePath) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: 200,
      margin: EdgeInsets.all( 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.5,
              height: screenHeight * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                price,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.star, size: 16, color: Colors.red),
              Text('5')
            ],
          ),
          SizedBox(height: 4,),
          Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 4),
          Text('Private room / 4 beads')
        ],
      ),
    );
  }

  Widget viewedCard(String price, String title, String imagePath, bool isFavorite, int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                width: screenWidth * 0.9,
                height: screenHeight * 0.3,
                fit: BoxFit.cover,
              ),
            ),
              Positioned(
                left: screenWidth * 0.72,
                top: screenHeight * 0.02,
                child:
              Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child:Container(
                        color: Colors.white,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(index),
                    ),
                  ]
              ),),
           ]
          ),

          SizedBox(height: 8),
          Row(
            children: [
              Text(
                price,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.star, size: 16, color: Colors.red),
                  Text(' 5'),
                ],
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
          Text('Private room / 4 beds'),

        ],
      ),
    );
  }
}