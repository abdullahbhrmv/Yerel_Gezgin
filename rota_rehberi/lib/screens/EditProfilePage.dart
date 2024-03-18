import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  final Future<void> Function(String, String, String, String) updateProfile;

  const EditProfilePage({Key? key, required this.updateProfile, required String initialName, required String initialBio, required String initialSurname}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _nameController.text = _user?.displayName?.split(' ').first ?? '';
    _surnameController.text = _user?.displayName?.split(' ').last ?? '';
    // Diğer bilgileri Firebase'den alabilir veya varsayılan değerler atayabilirsiniz.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profili Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'İsim'),
            ),
            TextFormField(
              controller: _surnameController,
              decoration: const InputDecoration(labelText: 'Soyisim'),
            ),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Profil bilgilerini güncelle
                widget.updateProfile(
                  _nameController.text.trim(),
                  _surnameController.text.trim(),
                  _bioController.text.trim(),
                  '${_nameController.text.trim()} ${_surnameController.text.trim()}', // Kullanıcı adı için isim ve soyisim birleştirilerek gönderiliyor
                );
                // Profil sayfasına geri dön
                Navigator.pop(context);
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
