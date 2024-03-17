import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String lastName;
  final List<String>
      likedPosts; // Assuming liked posts are represented as strings

  ProfilePage(
      {required this.userName,
      required this.lastName,
      required this.likedPosts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color(0xFFEED4C8),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Merhaba, $userName $lastName!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Beğenilen Gönderiler:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFADA39F)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: likedPosts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(likedPosts[index]),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Logout logic
              },
              child: const Text('Log out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEED4C8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
