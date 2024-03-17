import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageDownloadWidget extends StatelessWidget {
  final String imageUrl;

  ImageDownloadWidget({required this.imageUrl});

  Future<void> _downloadImage() async {
    final response = await http.get(Uri.parse(imageUrl));
    final blob = html.Blob([response.bodyBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "image.png");

    // Append anchor to document body and simulate a click
    html.document.body?.append(anchor);
    anchor.click();

    // Clean up after download
    html.Url.revokeObjectUrl(url);
    anchor.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _downloadImage,
      child: const Text('Download'),
    );
  }
}

// Example usage:
// Inside your widget tree, use ImageDownloadWidget like this:
// ImageDownloadWidget(imageUrl: 'your_image_url_here')
