import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextScanAndSpeakPage extends StatefulWidget {
  @override
  _TextScanAndSpeakPageState createState() => _TextScanAndSpeakPageState();
}

class _TextScanAndSpeakPageState extends State<TextScanAndSpeakPage> {
  File? image;
  String scannedText = '';
  bool isLoading = false;

  final ImagePicker picker = ImagePicker();
  final FlutterTts flutterTts = FlutterTts();

  // Future pickImageAndScan() async {
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile == null) return;
  //
  //   setState(() {
  //     isLoading = true;
  //     image = File(pickedFile.path);
  //   });
  //
  //   final inputImage = InputImage.fromFile(image!);
  //   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  //   final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
  //
  //   setState(() {
  //     scannedText = recognizedText.text;
  //     isLoading = false;
  //   });
  //
  //   await textRecognizer.close();
  // }
  Future pickImageAndScan() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      isLoading = true;
      image = File(pickedFile.path);
      scannedText = '';
    });

    final inputImage = InputImage.fromFile(image!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    print("🔍 Full Text: ${recognizedText.text}");
    for (final block in recognizedText.blocks) {
      for (final line in block.lines) {
        print("📄 ${line.text}");
      }
    }

    setState(() {
      scannedText = recognizedText.text;
      isLoading = false;
    });

    await textRecognizer.close();
  }

  Future speakText() async {
    if (scannedText.isEmpty) return;

    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(scannedText);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Scanner & Speaker")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImageAndScan,
              child: Text("Pick Image and Scan"),
            ),
            SizedBox(height: 16),
            image != null ? Image.file(image!, height: 200) : Text("No image selected"),
            SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
              child: SingleChildScrollView(
                child: Text(
                  scannedText.isEmpty ? 'Scanned text will appear here' : scannedText,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: speakText,
              icon: Icon(Icons.volume_up),
              label: Text("Read Text Aloud"),
            ),
          ],
        ),
      ),
    );
  }
}
