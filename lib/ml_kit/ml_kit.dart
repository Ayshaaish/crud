import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ImageTextScanner extends StatefulWidget {
  @override
  State<ImageTextScanner> createState() => _ImageTextScannerState();
}

class _ImageTextScannerState extends State<ImageTextScanner> {
  File? image;
  String scannedText = '';
  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  Future<void> processImage(XFile imageFile) async {
    setState(() {
      image = File(imageFile.path);
      scannedText = '';
      isLoading = true;
    });

    final inputImage = InputImage.fromFile(image!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      scannedText = recognizedText.text;
      isLoading = false;
    });

    textRecognizer.close();
  }

  Future<void> pickFromGallery() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await processImage(pickedFile);
    }
  }

  Future<void> captureFromCamera() async {
    final XFile? capturedFile = await picker.pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      await processImage(capturedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Text from Image')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: pickFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: captureFromCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            image != null
                ? Image.file(image!, height: 250)
                : const Text('No image selected'),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
              child: SingleChildScrollView(
                child: Text(
                  scannedText.isEmpty ? 'Scanned text will appear here' : scannedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
