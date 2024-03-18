import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoutesListWidget extends StatelessWidget {
  const RoutesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rota Listesi',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('routes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Bir hata oluştu.'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Henüz rota eklenmemiş.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var route = snapshot.data!.docs[index];
              return ListTile(
                title: Text(route['route_name']),
                subtitle: Text(route['route_location']),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Rota Sil'),
                        content: const Text('Silmek istediğinizden emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false); // Hayır'a basıldığında kapat
                            },
                            child: const Text('Hayır'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Evet'e basıldığında sil
                              FirebaseFirestore.instance.collection('routes').doc(route.id).delete();
                              Navigator.pop(context, true);
                            },
                            child: const Text('Evet'),
                          ),
                        ],
                      ),
                    ).then((confirmed) {
                      if (confirmed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Rota başarıyla silindi.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    });
                  },
                ),
                onTap: () {
                  // Rota detaylarını göstermek için AlertDialog göster
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(route['route_name']),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Rota Konumu: ${route['route_location']}'),
                          Text('Rota Detayı: ${route['route_details']}'),
                          // Diğer rota bilgilerini buraya ekleyebilirsiniz
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Tamam'a basıldığında kapat
                          },
                          child: const Text('Tamam'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
