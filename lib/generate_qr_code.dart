import 'package:flutter/material.dart';
import 'package:qr_code/qr_image.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter QR Code'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your URL',
                hintText: 'https://example.com',
              ),
            ),
          ),
          // Tombol untuk menavigasi ke halaman pembuatan QR Code dengan validasi URL
          ElevatedButton(
            onPressed: () {
              final String input = _controller.text.trim();

              // Cek apakah input kosong
              if (input.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Input cannot be empty!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              // Cek apakah input diawali dengan http:// atau https://
              else if (!input.startsWith('http://') &&
                  !input.startsWith('https://')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Invalid URL! Must start with http:// or https://',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                // Lanjut ke halaman QR Code jika input benar-benar URL yang valid
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRImage(_controller)),
                );
              }
            },
            child: const Text('GENERATE QR CODE'),
          ),
        ],
      ),
    );
  }
}
