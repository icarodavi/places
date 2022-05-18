import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/utils/db_util.dart';
import 'package:places/utils/location_util.dart';

import '../models/places.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void> loadPlaces() async {
    _items = [];
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(
              e['image'],
            ),
            location: PlaceLocation(
              latitude: e['latitude'],
              longitude: e['longitude'],
              address: e['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      image: image,
      title: title,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );
    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
