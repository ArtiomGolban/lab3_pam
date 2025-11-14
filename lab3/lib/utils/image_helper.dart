import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildCachedImage(
  String path, {
  BoxFit fit = BoxFit.cover,
  double? width,
  double? height,
  BorderRadius? borderRadius,
}) {
  final placeholder = Container(
    width: width,
    height: height,
    color: const Color(0xFFECECEC),
    child: const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
  );

  final errorWidget = Container(
    width: width,
    height: height,
    color: const Color(0xFFECECEC),
    child: const Icon(Icons.broken_image, size: 24, color: Colors.grey),
  );

  // Quick helper to clip if borderRadius provided
  Widget _maybeClip(Widget w) {
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: w);
    }
    return w;
  }

  if (path.isEmpty) return _maybeClip(errorWidget);

  // Local asset (non-http)
  if (!path.startsWith('http')) {
    // asset SVG
    if (path.toLowerCase().contains('.svg')) {
      try {
        final svg = SvgPicture.asset(
          path,
          fit: fit,
          width: width,
          height: height,
          placeholderBuilder: (_) => placeholder,
        );
        return _maybeClip(svg);
      } catch (_) {
        return _maybeClip(errorWidget);
      }
    }

    // raster asset
    final image = Image.asset(path, fit: fit, width: width, height: height, errorBuilder: (_, __, ___) => errorWidget);
    return _maybeClip(image);
  }

  // Network path
  final lower = path.toLowerCase();

  // data URI with SVG (data:image/svg+xml;base64,...) - attempt to render using SvgPicture.network will still work
  if (lower.contains('.svg') || lower.startsWith('data:image/svg')) {
    // Use flutter_svg to render remote SVGs
    final svg = SvgPicture.network(
      path,
      fit: fit,
      width: width,
      height: height,
      placeholderBuilder: (_) => placeholder,
    );

    return _maybeClip(svg);
  }

  // Raster network image: cached network image with error handling
  final cached = CachedNetworkImage(
    imageUrl: path,
    fit: fit,
    width: width,
    height: height,
    placeholder: (_, __) => placeholder,
    errorWidget: (_, __, ___) => errorWidget,
  );

  return _maybeClip(cached);
}
