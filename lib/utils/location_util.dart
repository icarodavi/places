// ignore_for_file: constant_identifier_names

const GOOGLE_API_KEY = 'AIzaSyDLZtZWtmzvBaJMijxNzuKJYGikuebcj9Q';

class LocationUtil {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude%2C%20$longitude&zoom=16&markers=color%3Ared%7Clabel%3AA%7C$latitude%2C$longitude&size=600x300&key=$GOOGLE_API_KEY';
  }
}
