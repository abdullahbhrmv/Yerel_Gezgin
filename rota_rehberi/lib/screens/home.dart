import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:rota_rehberi/screens/accommodation.dart';
import 'package:rota_rehberi/screens/create_post.dart';
import 'package:rota_rehberi/screens/profile.dart';
import 'package:rota_rehberi/widgets/MapWidget.dart';
import 'package:rota_rehberi/widgets/routes_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser;

  late MapController mapController;

  bool showMap = false;

  @override
  void initState() {
    super.initState();
    // Kullanıcı konumuyla MapController'ı başlat
    mapController = MapController(
      initMapWithUserPosition: const UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ana Sayfa",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          // Harita açıkken geri dönüş ikonu
          if (showMap)
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  showMap = false;
                });
              },
            ),
          IconButton(
            icon: const Icon(
              Icons.map,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                showMap = true;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: showMap
            ? MapWidget(mapController: mapController)
            : const RoutesListWidget(),
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menü',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.hotel,
                color: Colors.blue), // İkon rengini beyaz yapar
            title: const Text('Konaklama Yerleri'),
            onTap: () {
              _showAccommodationPlaces();
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add,
                color: Colors.blue), // İkon rengini beyaz yapar
            title: const Text('Rota Oluştur'),
            onTap: () {
              _showCreatePost();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person,
                color: Colors.blue), // İkon rengini beyaz yapar
            title: const Text('Profil'),
            onTap: () {
              _showProfile();
            },
          ),
        ],
      ),
    );
  }

  void _showAccommodationPlaces() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccommodationPage(),
      ),
    );
  }

  void _showProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void _showCreatePost() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddRoute("", "", ""),
      ),
    );
  }
}
