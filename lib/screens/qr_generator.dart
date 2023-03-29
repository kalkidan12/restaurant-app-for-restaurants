import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:gallery_saver/gallery_saver.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QRGenerator extends StatefulWidget {
  final String? textQrCode;

  const QRGenerator({Key? key, this.textQrCode}) : super(key: key);

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final GlobalKey globalKey = GlobalKey();

  Future<void> converQrCodeToImage() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File("$directory/qrCode.png");
    await imgFile.writeAsBytes(pngBytes);
    await Share.shareFiles([imgFile.path], text: "Supereme Order");
  }

  bool imageSavedStatus = false;
  Future<void> saveQrImage() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File("$directory/qrCode.png");
    await imgFile.writeAsBytes(pngBytes);
    // final success = await GallerySaver.saveImage(imgFile.path);
    final result = await GallerySaver.saveImage(imgFile.path);
    if (result!) {
      imageSavedStatus = result;
      final snackBar = SnackBar(
        content: const Text('Image saved to gallery!'),
        backgroundColor: (Color.fromARGB(255, 60, 173, 254)),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      imageSavedStatus = result;
      final snackBar = SnackBar(
        content: const Text('Unable to save image!'),
        backgroundColor: (Color.fromARGB(255, 60, 173, 254)),
        action: SnackBarAction(
          textColor: Colors.red,
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final List<Map<String, dynamic>> data = [
    {'RestaurantID': '', 'TableID': 'TID546374'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table QR code"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: "${widget.textQrCode}", //data.toString(),
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
                gapless: true,
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text("Error"),
                  );
                },
              ),
            )),
            const SizedBox(height: 10),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => converQrCodeToImage(),
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10),
                          Text(
                            "Share",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => saveQrImage(),
                      child: Row(
                        children: [
                          Icon(Icons.save,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10),
                          Text(
                            "Save",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
