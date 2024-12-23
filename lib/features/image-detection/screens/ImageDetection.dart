import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img; // For image preprocessing
import 'dart:io';

class ImageDetection extends StatefulWidget {
  final String imagePath;

  const ImageDetection({super.key, required this.imagePath});

  @override
  _ImageDetectionState createState() => _ImageDetectionState();
}

class _ImageDetectionState extends State<ImageDetection> {
  late String imagePath;
  String result = "No result";

  late Interpreter _interpreter;
  List<String> _labels = [];

  @override
  void initState() {
    super.initState();
    imagePath = widget.imagePath;
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model/sampah.tflite');
      await _loadLabels();
      print('Model berhasil dimuat');
      _runModelOnImage(File(imagePath)); // Run model when the image is loaded
    } catch (e) {
      print('Gagal memuat model: $e');
    }
  }

  Future<void> _loadLabels() async {
    try {
      final labelsData = await DefaultAssetBundle.of(context)
          .loadString('assets/labels/labels.txt');
      setState(() {
        _labels = labelsData.split('\n').map((e) => e.trim()).toList();
      });
    } catch (e) {
      print('Gagal memuat label: $e');
    }
  }

  Future<void> _runModelOnImage(File imageFile) async {
    try {
      final rawImage = imageFile.readAsBytesSync();
      img.Image? oriImage = img.decodeImage(rawImage);
      if (oriImage == null) {
        setState(() {
          result = "Gagal memproses gambar.";
        });
        return;
      }
      img.Image resizedImage =
          img.copyResize(oriImage, width: 224, height: 224);

      var input = List.generate(
        1,
        (batch) => List.generate(
          224,
          (y) => List.generate(224, (x) => List.filled(3, 0.0)),
        ),
      );

      for (int y = 0; y < 224; y++) {
        for (int x = 0; x < 224; x++) {
          final pixel = resizedImage.getPixel(x, y);
          input[0][y][x][0] = pixel.r / 255.0;
          input[0][y][x][1] = pixel.g / 255.0;
          input[0][y][x][2] = pixel.b / 255.0;
        }
      }

      var output = List.generate(1, (_) => List.filled(2, 0.0));

      _interpreter.run(input, output);

      var probabilities = output[0];

      int predictedIndex = probabilities.indexWhere(
        (e) => e == probabilities.reduce((a, b) => a > b ? a : b),
      );

      setState(() {
        result =
            "${_labels[predictedIndex]} (${probabilities[predictedIndex].toStringAsFixed(2)})";
      });
    } catch (e) {
      print('Error saat menjalankan model: $e');
      setState(() {
        result = "Error saat menjalankan model.";
      });
    }
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  // Fungsi untuk membuka dialog pemilihan gambar
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.8),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.white),
                title:
                    Text('Take a Photo', style: TextStyle(color: Colors.white)),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo, color: Colors.white),
                title: Text('Pick from Gallery',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk memilih gambar dari galeri atau kamera
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
      _runModelOnImage(
          File(imagePath)); // Lakukan prediksi setelah gambar dipilih
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769),
        title: const Text(
          'Image Detection',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: imagePath.isNotEmpty
                  ? Container(
                      width: 350,
                      height: 550,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const Text(
                      'No image selected',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              result.isEmpty ? 'No Prediction Yet' : 'Prediction: $result',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showImageSourceDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006769), // Background color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                elevation: 10,
              ),
              child: const Text(
                'Select Image',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
