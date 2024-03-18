// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rota_rehberi/screens/EditProfilePage.dart';
import 'package:rota_rehberi/screens/signin.dart'; // Giriş sayfasının import edildiği yer

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  late String _username;
  late String _name;
  late String _surname;
  late String _bio;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _username = _user?.displayName ??
        'Kullanıcı Adı'; // Firebase'den kullanıcı adını al
    _name = _user?.displayName?.split(' ').first ?? '';
    _surname = _user?.displayName?.split(' ').last ?? '';
    _bio = ''; // Burada kullanıcının bio bilgisini Firebase'den alabilirsiniz.
  }

  Future<void> _updateProfile(
      String newName, String newSurname, String newBio, String newUsername) async {
    try {
      String newDisplayName = '$newName $newSurname';
      await _user?.updateDisplayName(newDisplayName);
      setState(() {
        _name = newName;
        _surname = newSurname;
        _bio = newBio;
        _username = newUsername;
      });
    } catch (error) {
      // print('Profil güncelleme hatası: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil bilgileri güncellenirken bir hata oluştu.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _signOutAndNavigateToSignIn() async {
    try {
      await _auth.signOut();
      // Kullanıcıyı giriş sayfasına yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    } catch (error) {
      // print('Çıkış yaparken bir hata oluştu: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Çıkış yaparken bir hata oluştu.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Çıkış Yap'),
                  content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // AlertDialog'ı kapat
                      },
                      child: const Text('Hayır'),
                    ),
                    TextButton(
                      onPressed: () {
                        _signOutAndNavigateToSignIn(); // Çıkış yap ve giriş sayfasına git
                      },
                      child: const Text('Evet'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _user != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      _user!.photoURL ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _username,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$_name $_surname',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    _bio,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Profili düzenleme sayfasına git
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                    updateProfile: _updateProfile,
                                    initialName: _name,
                                    initialSurname: _surname,
                                    initialBio: _bio,
                                  ))).then((value) {
                        // Profil sayfasını yenile
                        setState(() {});
                      });
                    },
                    child: const Text('Profili Düzenle'),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
