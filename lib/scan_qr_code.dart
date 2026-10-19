import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String _barcode = 'No data available';
  final MobileScannerController _cameraController = MobileScannerController();

  // Fungsi untuk membuka halaman pemindai kamera
  void _openScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Scan QR Code'),
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
          ),
          body: Stack(
            children: [
              MobileScanner(
                controller: _cameraController,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcodeValue in barcodes) {
                    if (barcodeValue.rawValue != null) {
                      final scannedValue = barcodeValue.rawValue!;
                      _cameraController.stop();
                      Navigator.pop(context, scannedValue);
                      break;
                    }
                  }
                },
              ),
              // Kotak bingkai pemindai di tengah layar
              Positioned(
                top: 120,
                left: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // Teks petunjuk di bawah kotak
              const Positioned(
                top: 390,
                left: 0,
                right: 0,
                child: Text(
                  'Point your camera at the QR code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _barcode = value;
        });
      }
    });
  }

  // Fungsi untuk membuka URL di browser eksternal
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to open link: $urlString')),
      );
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isUrl =
        _barcode.startsWith('http://') || _barcode.startsWith('https://');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter QR Code'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _openScanner(context),
              child: const Text('Start Camera Scan'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Scan Results:\n$_barcode',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Tombol muncul jika hasil scan berupa link/URL
            if (isUrl) ...[
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => _launchURL(_barcode),
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Visit This Link'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
