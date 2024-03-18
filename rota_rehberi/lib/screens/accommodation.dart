import 'package:flutter/material.dart';

class AccommodationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konaklama Yerleri'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Konaklama Yerleri İçeriği'),
          ],
        ),
      ),
    );
  }
}
