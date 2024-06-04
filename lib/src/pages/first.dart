import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:esqrcode/src/account/login.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  TextEditingController title = TextEditingController();
  var code = '';
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de QR', style: TextStyle(color: Colors.white)),
        backgroundColor: ui.Color.fromARGB(255, 99, 203, 255),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: title,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Introduce el código',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: ui.Color.fromARGB(255, 99, 203, 255),
                onPressed: () {
                  setState(() {
                    code = title.text;
                  });
                },
                child: Text(
                  "Generar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (code.isNotEmpty)
                Column(
                  children: [
                    RepaintBoundary(
                      key: globalKey,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(
                            errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                          ),
                          color: Colors.white,
                          data: code,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _captureAndSavePng,
                      icon: Icon(Icons.download),
                      label: Text("Descargar QR"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ui.Color.fromARGB(255, 241, 240, 247),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: Icon(Icons.arrow_back),
                label: Text("Regresar a Inicio de Sesión"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ui.Color.fromARGB(255, 253, 253, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndSavePng() async {
    try {
      // Agregar un pequeño retraso para permitir que el widget se repinte completamente
      await Future.delayed(Duration(milliseconds: 100));

      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final result = await ImageGallerySaver.saveImage(
            byteData.buffer.asUint8List(),
            name: "qr_code");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Código QR guardado exitosamente"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error al guardar el código QR"),
      ));
      print(e);
    }
  }
}
