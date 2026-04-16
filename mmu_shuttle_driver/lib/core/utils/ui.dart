import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Uint8List> createBusMarkerBitmap({double size = 120.0}) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final radius = (size / 2) - 4;

  final Paint shadowPaint = Paint()..color = Colors.black.withOpacity(0.2);
  canvas.drawCircle(Offset(size / 2, size / 2 + 3), radius, shadowPaint);

  final Paint paint = Paint()
    ..color =
        const Color(0xFF113A9F) 
    ..style = PaintingStyle.fill;
  canvas.drawCircle(Offset(size / 2, size / 2), radius, paint);

  final textPainter = TextPainter(textDirection: ui.TextDirection.ltr);
  textPainter.text = TextSpan(
    text: String.fromCharCode(Icons.directions_bus.codePoint),
    style: TextStyle(
      fontSize: radius * 1.2,
      fontFamily: Icons.directions_bus.fontFamily,
      package: Icons.directions_bus.fontPackage,
      color: Colors.white,
    ),
  );
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
  );

  final ui.Picture picture = pictureRecorder.endRecording();
  final ui.Image image = await picture.toImage(size.toInt(), size.toInt());
  final ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  return byteData!.buffer.asUint8List();
}
