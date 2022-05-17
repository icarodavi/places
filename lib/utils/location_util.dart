// const GOOGLE_API_KEY = 'AIzaSyDilIVDffWPaGy9rOL_3E9UFi3vtHXtBXU';
const GOOGLE_API_KEY = 'AIzaSyDLZtZWtmzvBaJMijxNzuKJYGikuebcj9Q';

class LocationUtil {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%$latitude,$longitude&key=$GOOGLE_API_KEY&signature=ONP1_RN7iQY5LlKm3C-LLKPPlqY=';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude%2c%20$longitude&zoom=16&size=600x300&key=$GOOGLE_API_KEY';
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude%2C%20$longitude&zoom=16&markers=color%3Ared%7Clabel%3AA%7C$latitude%2C$longitude&size=600x300&key=$GOOGLE_API_KEY';
  }
}
