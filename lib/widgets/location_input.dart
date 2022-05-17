import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    final staticImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: locationData.latitude as double,
        longitude: locationData.longitude as double);

    setState(() {
      _previewImageUrl = staticImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text('Nenhuma localização encontrada')
              : Image.network(
                  _previewImageUrl as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _getCurrentUserLocation,
              child: Row(
                children: const [
                  Icon(Icons.location_on),
                  Text('Localização Atual')
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: const [Icon(Icons.map), Text('Selecione no mapa')],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
