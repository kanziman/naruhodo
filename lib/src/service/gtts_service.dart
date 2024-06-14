import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class GttsService {
  Map<String, String> urlCache = {};

  Future<String> uploadFileAndSaveData(String fileName, String text) async {
    // if (urlCache.containsKey(fileName)) {
    //   return urlCache[fileName]!;
    // }

    // Google Cloud TTS API를 사용하여 음성 파일 생성
    Uri url = Uri.parse(
        'https://texttospeech.googleapis.com/v1/text:synthesize?key=AIzaSyCXaxKHee-LEqpVx3SMhwsiAnVyRWU2lDY');

    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'input': {'text': text},
          'voice': {'languageCode': 'ja-JP', 'ssmlGender': 'FEMALE'},
          'audioConfig': {'audioEncoding': 'MP3', 'pitch': -5.0},
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var audioContent = jsonResponse['audioContent'] as String;
      Uint8List bytes = base64.decode(audioContent);

      try {
        // Firebase Storage에 파일 업로드
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref('alphabet/$fileName.mp3')
            .putData(bytes);

        String downloadUrl = await uploadTask.ref.getDownloadURL();
        urlCache[fileName] = downloadUrl; // Cache the URL for reuse
        log('Upload successful $downloadUrl');
        return downloadUrl;
      } catch (e) {
        log('Error occurred while uploading to Firebase: $e');
      }
    } else {
      log('Failed to generate TTS: ${response.body}');
    }
    return '';
  }
}
