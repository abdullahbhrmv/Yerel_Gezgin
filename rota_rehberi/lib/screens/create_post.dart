// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AddRoute extends StatefulWidget {
  const AddRoute(String a, String b, String c, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddRouteState createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Rota Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rota Adı:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Rota adını girin',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZğüşöçĞÜŞİÖÇ\s]')),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Rota Konumu:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                hintText: 'Rota konumunu girin',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Rota Detayları:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _detailsController,
              decoration: const InputDecoration(
                hintText: 'Rota detaylarını girin',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _addRoute(context);
              },
              child: const Text('Rota Oluştur'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addRoute(BuildContext context) async {
    final String name = _nameController.text;
    final String location = _locationController.text;
    final String details = _detailsController.text;

    if (name.isNotEmpty && location.isNotEmpty && details.isNotEmpty) {
      final CollectionReference routes =
          FirebaseFirestore.instance.collection('routes');

      await routes.add({
        'route_name': name,
        'route_location': location,
        'route_details': details,
      });

      // Başarılı bir şekilde oluşturulduğuna dair bir SnackBar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Rota başarılı bir şekilde oluşturuldu.'),
          duration: const Duration(seconds: 2), // SnackBar'ın süresi
          action: SnackBarAction(
            label: 'Tamam',
            onPressed: () {
              // SnackBar kapatıldığında inputları sıfırla
              _nameController.clear();
              _locationController.clear();
              _detailsController.clear();
            },
          ),
        ),
      );
    } else {
      // Alanlar boşsa kullanıcıya uyarı ver
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: const Text('Lütfen tüm alanları doldurun.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
}
