import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rota Rehberi',
      theme: ThemeData(
        primaryColor: const Color(0xFFEED4C8),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFEED4C8),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LikePost> likePosts = [];
  final picker = ImagePicker();

  void _navigateToPostPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(),
      ),
    );
    if (result != null) {
      setState(() {
        likePosts.add(result);
      });
    }
  }

  void _likePost(int index) {
    setState(() {
      likePosts[index].isLiked = !likePosts[index].isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rota Rehberi"),
        backgroundColor: const Color(0xFFEED4C8),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to ProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userName: 'Isim',
                    lastName: 'Soyisim',
                    likedPosts: [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: likePosts.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(likePosts[index].content),
                leading: likePosts[index].image != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(likePosts[index].image!),
                      )
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        likePosts[index].isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: likePosts[index].isLiked ? Colors.red : null,
                      ),
                      onPressed: () {
                        _likePost(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToPostPage,
        label: const Text("Post Oluştur"),
        icon: const Icon(Icons.create),
      ),
    );
  }
}

class LikePost {
  final String content;
  final File? image;
  bool isLiked;

  LikePost(this.content, this.image, {this.isLiked = false});
}

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _textController = TextEditingController();

  void _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {}
  }

  void _post() {
    String text = _textController.text;
    Navigator.pop(context, LikePost(text, _image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Oluşturma"),
        backgroundColor: const Color(0xFFEED4C8),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'İçerik',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          _image == null
              ? ElevatedButton.icon(
                  onPressed: _getImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Resim Ekle"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEED4C8),
                  ),
                )
              : Image.file(_image!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _post,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEED4C8)),
            child: const Text("Paylaş"),
          ),
        ],
      ),
    );
  }
}
