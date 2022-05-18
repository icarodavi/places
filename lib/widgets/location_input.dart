import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/models/places.dart';
import 'package:places/screen/map_screen.dart';
import 'package:places/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(this.onSelectPosition, {Key? key}) : super(key: key);
  final Function onSelectPosition;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  PlaceLocation? currentLocation;

  _showPreview(double latitude, double longitude) {
    try {
      final staticImageUrl = LocationUtil.generateLocationPreviewImage(
          latitude: latitude, longitude: longitude);

      setState(() {
        _previewImageUrl = staticImageUrl;
        currentLocation =
            PlaceLocation(latitude: latitude, longitude: longitude);
      });
    } catch (e) {
      //implement error
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => currentLocation == null
            ? const MapScreen()
            : MapScreen(initialLocation: currentLocation!),
      ),
    );

    if (selectedLocation == null) return;

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);

    widget.onSelectPosition(selectedLocation);
  }

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    _showPreview(
        locationData.latitude as double, locationData.longitude as double);
    widget.onSelectPosition(locationData.latitude, locationData.longitude);
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
              onPressed: _selectOnMap,
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
