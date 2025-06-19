import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_images.dart';

class IsolateDialog extends StatefulWidget {
  const IsolateDialog({super.key});

  @override
  State<IsolateDialog> createState() => _IsolateDialogState();
}

class _IsolateDialogState extends State<IsolateDialog> {
  Uint8List? _originalImage;
  Uint8List? _compressedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadImageAsset();
  }

  Future<void> _loadImageAsset() async {
    final byteData = await rootBundle.load(AppImages.onboarding);
    setState(() {
      _originalImage = byteData.buffer.asUint8List();
    });
  }

  Future<void> _compressWithIsolate() async {
    if (_originalImage == null) return;

    setState(() => _isLoading = true);

    try {
      final compressed = await _startIsolateCompression(_originalImage!);
      setState(() => _compressedImage = compressed);
    } catch (_) {
      // do nothing
    }

    setState(() => _isLoading = false);
  }

  Future<Uint8List> _startIsolateCompression(Uint8List imageData) async {
    final responsePort = ReceivePort();

    await Isolate.spawn(_isolateEntry, responsePort.sendPort);

    final isolateSendPort = await responsePort.first as SendPort;

    final resultPort = ReceivePort();
    isolateSendPort.send([imageData, resultPort.sendPort]);

    return await resultPort.first as Uint8List;
  }

  static void _isolateEntry(SendPort mainSendPort) async {
    final port = ReceivePort();
    mainSendPort.send(port.sendPort);

    await for (final message in port) {
      final Uint8List input = message[0];
      final SendPort replyTo = message[1];

      final result = _compressImage(input);
      replyTo.send(result);
    }
  }

  static Uint8List _compressImage(Uint8List image) {
    int maxInBytes = (0.5 * 1024 * 1024).ceil();
    Uint8List resizedData = Uint8List.fromList(image);

    imglib.Image? img = imglib.decodeImage(image);
    int size = image.lengthInBytes;
    int quality = 100;

    while (size > maxInBytes && quality > 10) {
      quality = (quality - (quality * 0.1)).toInt();
      int width = img!.width - (img.width * 0.1).toInt();
      imglib.Image resized = imglib.copyResize(
        img,
        width: width,
        maintainAspect: true,
      );
      resizedData = Uint8List.fromList(
        imglib.encodeJpg(resized, quality: quality),
      );
      size = resizedData.lengthInBytes;
      img = resized;
    }

    debugPrint("size after: $size bytes");

    return resizedData;
  }

  String _formatBytes(int bytes) {
    return (bytes / (1024 * 1024)).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Isolate Compression Example'),
          const SizedBox(height: 16),
          if (_originalImage != null)
            _ImageWithSize(
              label: 'Original Image',
              image: Image.asset(AppImages.onboarding, height: 200),
              sizeInBytes: _originalImage!.lengthInBytes,
              formatBytes: _formatBytes,
            ),
          const SizedBox(height: 16),
          if (_compressedImage != null)
            _ImageWithSize(
              label: 'Compressed Image',
              image: Image.memory(_compressedImage!, height: 200),
              sizeInBytes: _compressedImage!.lengthInBytes,
              formatBytes: _formatBytes,
            ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_compressedImage != null) {
                        Navigator.pop(context);
                      } else {
                        await _compressWithIsolate();
                      }
                    },
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor.primary,
                      ),
                    )
                  : Text(
                      _compressedImage != null
                          ? 'Close'
                          : 'Compress using isolate',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageWithSize extends StatelessWidget {
  final String label;
  final Widget image;
  final int sizeInBytes;
  final String Function(int) formatBytes;

  const _ImageWithSize({
    required this.label,
    required this.image,
    required this.sizeInBytes,
    required this.formatBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image,
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '$label:\n${formatBytes(sizeInBytes)} MB',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
