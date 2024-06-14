import 'dart:math';

class Avatar {
  static String generateRandomAvatarUrl() {
    Random random = Random();
    int seed = random.nextInt(10000); // Generate a random seed
    String baseUrl = 'https://api.dicebear.com/8.x/bottts/svg?seed=';
    return '$baseUrl$seed.svg'; // Return the full URL to the random avatar
  }
}
