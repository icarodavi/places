import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  const ImageInput(this.onSelectedImage, {Key? key}) : super(key: key);
  final Function onSelectedImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    // print(_storedImage);
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectedImage(savedImage);
  }

  _cleanPicture() {
    setState(() {
      _storedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            width: 180,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            alignment: Alignment.center,
            child: _storedImage != null
                ? Image.file(
                    _storedImage as File,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Text('Sem imagem'),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            TextButton(
              onPressed: _takePicture,
              child: Row(
                children: const [
                  Icon(Icons.camera),
                  SizedBox(width: 10),
                  Text('Tirar foto'),
                ],
              ),
            ),
            // const SizedBox(width: 10),
            TextButton(
              onPressed: _cleanPicture,
              child: Row(
                children: const [
                  Icon(Icons.delete),
                  SizedBox(width: 10),
                  Text('Limpar foto'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
