import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter QR Code'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: QrImageView(
          data: controller.text,
          size: 280,
          // Properti embeddedImageStyle dapat digunakan jika ingin
          // menyisipkan gambar/logo dari folder asset
          embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(100, 100)),
        ),
      ),
    );
  }
}
