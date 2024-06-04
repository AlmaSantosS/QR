import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String? _qrInfo = 'QrNova';
  bool camState = false;

  qrCallback(String? code) async {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
    if (code != null) {
      await _saveURL(code);
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  Future<void> _saveURL(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedURL', url);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('URL guardada')),
    );
  }

  Future<void> _loadURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedURL = prefs.getString('savedURL');
    if (savedURL != null) {
      setState(() {
        _qrInfo = savedURL;
      });
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('URL copiada al portapapeles')),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
    _loadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            camState = !camState;
          });
        },
        child: const Icon(Icons.camera),
      ),
      body: camState
          ? Center(
              child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Code:",
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  if (_qrInfo != null && _qrInfo != 'QrNova')
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _launchURL(_qrInfo!),
                          child: Text(
                            _qrInfo!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _copyToClipboard(_qrInfo!),
                          child: Text('Copiar URL'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _saveURL(_qrInfo!),
                          child: Text('Guardar URL'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
