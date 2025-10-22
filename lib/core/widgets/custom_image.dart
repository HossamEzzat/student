import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.path, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.size,
    this.borderRadius,
  });

  final String path;
  final BoxFit? fit;
  final Color? color;
  final double? width, height, radius, size;
  final BorderRadiusGeometry? borderRadius;
  static ImageProvider provider(String path) {
    final type = _getType(path);
    switch (type) {
      case 'asset':
        return AssetImage(path);
      case 'web':
        return NetworkImage(path);
      case 'base64':
        return MemoryImage(base64Decode(_extractBase64Data(path)));
      default:
        throw Exception('Unsupported image type');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? getColor() => color;

    double? getSize() => size;

    final type = _getType(path);

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 1),
      child: Builder(
        builder: (_) {
          switch (type) {
            case 'asset':
              return Image.asset(
                path,
                fit: fit,
                width: getSize()?.sp ?? width,
                color: getColor(),
                height: getSize()?.sp ?? height,
              );
            case 'web':
              return Image.network(
                path,
                fit: fit,
                width: getSize()?.sp ?? width,
                color: getColor(),
                height: getSize()?.sp ?? height,
              );

            case 'base64':
              return Image.memory(
                base64Decode(_extractBase64Data(path)),
                fit: fit,
                width: getSize()?.sp ?? width,
                height: getSize()?.sp ?? height,
              );

            default:
              return _errorWidget();
          }
        },
      ),
    );
  }

  Widget _errorWidget() {
    return const Icon(Icons.error, color: Colors.red);
  }

  static String _getType(String path) {
    if (path.startsWith('http')) return 'web';
    if (path.startsWith('assets/')) return 'asset';
    if (path.startsWith('data:image/')) return 'base64';
    return 'unsupported';
  }

  static String _extractBase64Data(String base64String) {
    return base64String.split(',').last;
  }
}
