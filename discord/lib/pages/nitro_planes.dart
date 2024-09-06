import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: NitroPlansScreen(),
    );
  }
}

class NitroPlansScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planes de Nitro'),
        backgroundColor: Colors.deepPurple,
      ),
      body: NitroPlansContent(),
    );
  }
}

class NitroPlansContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlanItem(
            title: 'Nitro Mensual',
            price: '\$9.99 / mes',
            description: 'Beneficios completos de Nitro mensualmente.',
            pdfUrl: 'https://www.uneweb.com/tutoriales/JAVA/java.%20pdf.pdf',
          ),
          PlanItem(
            title: 'Nitro Anual',
            price: '\$99.99 / año',
            description: 'Beneficios completos de Nitro con descuento anual.',
            pdfUrl: 'https://www.uneweb.com/tutoriales/JAVA/java.%20pdf.pdf',
          ),
          PlanItem(
            title: 'Nitro Clásico Mensual',
            price: '\$4.99 / mes',
            description: 'Beneficios básicos de Nitro mensualmente.',
            pdfUrl: 'https://www.uneweb.com/tutoriales/JAVA/java.%20pdf.pdf',
          ),
          PlanItem(
            title: 'Nitro Clásico Anual',
            price: '\$49.99 / año',
            description: 'Beneficios básicos de Nitro con descuento anual.',





            
            pdfUrl: 'https://www.uneweb.com/tutoriales/JAVA/java.%20pdf.pdf',
          ),
        ],
      ),
    );
  }
}

class PlanItem extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final String pdfUrl;

  PlanItem({
    required this.title,
    required this.price,
    required this.description,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
            ),
          );
        },
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  PdfViewerScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista de PDF'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SfPdfViewer.network(
        pdfUrl,
        // Configuración adicional opcional
        // Ejemplo: configuración de opciones de visualización
        // SfPdfViewerConfigurations(
        //   pageSpacing: 4.0,
        //   scrollDirection: PdfScrollDirection.vertical,
        // ),
      ),
    );
  }
}
