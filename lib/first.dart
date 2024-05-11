import 'dart:typed_data';
import 'dart:ui' as ui;
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
  TextEditingController content = TextEditingController();
  var code = '';
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(35),
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: title,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: ' Code ',
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: const ui.Color.fromARGB(255, 175, 230, 255),
                onPressed: () {
                  setState(() {
                    code = title.text;
                  });
                },
                child:  const Text(
                  "Create",
                  style: TextStyle(
                    color: ui.Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                  ),
                ),
              ),
              if (code == '') Container() else RepaintBoundary(
                      key: globalKey,
                      child: Container(
                        color: Colors.black, // Establecer el color de fondo negro
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(
                            errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                          ),
                          color: Colors.white,
                          data: '$code',
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
               const SizedBox(height: 20),
              code == ''
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        _captureAndSavePng();
                      },
                      child: const  Text("Descargar QR"),
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
        print(result);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("QR Code saved successfully"),
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
