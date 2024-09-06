import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _scanResult = 'No result';

  Future<void> scanQRCode() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        _scanResult = qrCode != '-1' ? qrCode : 'Failed to get scan result';
      });
    } catch (e) {
      setState(() {
        _scanResult = 'Failed to get scan result: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Scan result: $_scanResult'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanQRCode,
              child: Text('inicar scaner QR '),
            ),
          ],
        ),
      ),
    );
  }
}
