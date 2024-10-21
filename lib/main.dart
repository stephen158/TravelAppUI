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
    {'name': 'India', 'image': 'https://www.tamilnadutourism.tn.gov.in/img/pages/mobile/kanyakumari-1655354775_70ffcca22ad83db7094c.webp'},
    {'name': 'Paris', 'image': 'https://www.usnews.com/object/image/00000180-6260-d187-a5cb-fefd67170001/eiffel-tower-outro-stock.jpg?update-time=1650917926219&size=responsive640'},
    {'name': 'China', 'image': 'https://www.jodogoairportassist.com/main/assets/images/blog/main-image/top-10-tourist-places-to-visit-in-china.webp'},
  ];

  List<Map<String, dynamic>> filteredLocations = [];

  List<Map<String, dynamic>> mostViewed = [
    {'price': '\$90 / Night', 'title': 'Carinthia Lake see Breakfast', 'image': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGJlYXV0aWZ1bCUyMGhvdXNlfGVufDB8fDB8fHww', 'isFavorite': false},
    {'price': '\$300 / Night', 'title': 'Carinthia Lake see Breakfast', 'image': 'https://media.istockphoto.com/id/1255835530/pl/zdj%C4%99cie/nowoczesna-niestandardowa-strona-zewn%C4%99trzna-domu-podmiejskiego.jpg?s=612x612&w=0&k=20&c=TwkvEhZv_lYbd_xVvJcqXDy7ftXe5S9e4nvqyhLA0XQ=', 'isFavorite': false},
    {'price': '\$240 / Night', 'title': 'Carinthia Lake see Breakfast', 'image': 'https://i.pinimg.com/564x/fe/29/8a/fe298a70a49d93f50c62ae40c5ecce3a.jpg', 'isFavorite': false},
  ];

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
  }

  void _filterLocations(String query) {
    if (query.isEmpty) {
        _isSearching = false;
        filteredLocations = locations;

    } else {
        _isSearching = true;
        filteredLocations = locations
            .where((location) => location['name']
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
    }
  }

  void _toggleFavorite(int index) {
      mostViewed[index]['isFavorite'] = !mostViewed[index]['isFavorite'];
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
                height: screenHeight * 0.25,
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
                    recommendedCard('\$120 / Night', 'Carinthia Lake see Breakfast...', 'https://media.istockphoto.com/id/1026205392/photo/beautiful-luxury-home-exterior-at-twilight.jpg?s=612x612&w=0&k=20&c=HOCqYY0noIVxnp5uQf1MJJEVpsH_d4WtVQ6-OwVoeDo='),
                    recommendedCard('\$400 / Night', 'Carinthia Lake see Breakfast...', 'https://img.freepik.com/free-photo/photorealistic-house-with-wooden-architecture-timber-structure_23-2151302742.jpg?semt=ais_hybrid'),
                    recommendedCard('\$240 / Night', 'Carinthia Lake see Breakfast...', 'https://media.istockphoto.com/id/1368330586/photo/front-porch-and-entrance-to-new-home.jpg?s=612x612&w=0&k=20&c=h13209WqKTjXDnqNbcnQMMJo6evzmvzNeQlClRdL-jk='),
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
                      child: Image.network('https://media.istockphoto.com/id/1030155158/photo/closeup-image-of-a-hand-holding-a-blue-cup-of-hot-coffee-with-smoke-on-wooden-table-in-cafe.jpg?s=612x612&w=0&k=20&c=Hpmm7nKU-TDQrsXbNcXTp8XU5-6LLsGy3bSjwooX1nQ=',
                      fit: BoxFit.cover,
                      //width: 500,
                      ),
                    ),
                   Positioned(
                     right: 170,
                     top: 50,
                     child: Text('Hosting fee for ',style: TextStyle(color: Colors.white,fontSize: 25),),),
                    Positioned(
                      right: 190,
                      top: 80,
                      child: Text('as low as 1%',style: TextStyle(color: Colors.white,fontSize: 25),),),
                    SizedBox(height: 5,),
                    Positioned(
                      right: 210,
                      top: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Become a Host ',
                                style: TextStyle(color: Colors.white,fontSize: 15,),),
                            )),
                      ),),
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
            child: Image.network(
              imagePath,
              width: screenWidth * 0.4,
              height: screenHeight * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.02,
            left: screenWidth * 0.13,
            child: Text(
              location,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
            child: Image.network(
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
              child: Image.network(
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