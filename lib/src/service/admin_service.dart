import 'dart:convert';
import 'dart:developer';
import 'dart:math' as m;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/gtts_service.dart';

class AdminService extends ChangeNotifier {
  final alphabetCollection = FirebaseFirestore.instance.collection('alphabet');
  final n5Collection = FirebaseFirestore.instance.collection('N5');
  final n4Collection = FirebaseFirestore.instance.collection('N4');
  final n3Collection = FirebaseFirestore.instance.collection('N3');
  final n2Collection = FirebaseFirestore.instance.collection('N2');
  final n1Collection = FirebaseFirestore.instance.collection('N1');
  final sectionCollection = FirebaseFirestore.instance.collection('section');

  final sentencesCollection =
      FirebaseFirestore.instance.collection('sentences');
  final word = FirebaseFirestore.instance.collection('word');
  final patternCollection = FirebaseFirestore.instance.collection('pattern');

  List<Word> words = [];
  String cardView = '';

  var random = m.Random();

  void insertWords(String jsonString) async {
    List<dynamic> list = jsonDecode(jsonString);
    int res = 0;

    for (var item in list) {
      try {
        await word.add({
          'topic': item['topic'],
          'character': item['character'],
          'kanji': item['kanji'] ?? item['kanji'],
          'meaning': {
            'ko': item['meaning']['ko'],
            'en': item['meaning']['en'],
          },
          'sound': {
            'ko': item['sound']['ko'],
            'en': item['sound']['en'],
          },
        }).then((docRef) {
          res++;
          // print("Document added with ID: ${docRef.id}");
        });
      } catch (e) {
        log("Error adding document: $e");
      }
    }
    log("$res documents were successfully added.");
  }

  void insertPattern(String patternNum, String jsonString) async {
    List<dynamic> list = jsonDecode(jsonString);
    int res = 0;
    CollectionReference patternCollection = FirebaseFirestore.instance
        .collection('patterns')
        .doc('pattern')
        .collection(patternNum);
    int seq = 0;
    for (var item in list) {
      Map<String, dynamic>? soundMap;
      if (item['sound'] != null) {
        soundMap = {
          'ko': item['sound']['ko'],
          'en': item['sound']['en'],
        };
      }

      Map<String, dynamic> data = {
        'topic': item['topic'],
        'pattern': item['pattern'],
        'character': item['character'],
        'answer': item['answer'] ?? item['answer'],
        'quiz': item['quiz'] ?? item['quiz'],
        'meaning': {
          'ko': item['meaning']['ko'],
          'en': item['meaning']['en'],
        },
        'seq': seq++
      };

      // soundMap이 null이 아니면 데이터에 추가
      if (soundMap != null) {
        data['sound'] = soundMap;
      }
      try {
        await patternCollection.add(data).then((docRef) {
          res++;
          // log("Document added with ID: ${docRef.id}");
        });
      } catch (e) {
        log("Error adding document: $e");
      }
    }
    log("$res documents were successfully added.");
  }

  void insertSentences(String jsonString) async {
    List<dynamic> list = jsonDecode(jsonString);

    for (var item in list) {
      await sentencesCollection.add({
        'topic': item['topic'],
        'character': item['character'],
        'answer': item['answer'],
        'meaning': {
          'ko': item['meaning']['ko'],
          'en': item['meaning']['en'],
        },
        'sound': {
          'ko': item['sound']['ko'],
          'en': item['sound']['en'],
        },
      });
    }
  }

  /// AUTO INSERT
  /// =====
  void insertVoca(String category, List<dynamic> jsonData) async {
    log('Inserting $category data: $jsonData');
    try {
      Map<String, int> numMap = {};
      log('add $category');
      if (category == 'N5') {
        await addVocabularyItems('N5', jsonData, numMap, n5Collection);
      }
      if (category == 'N4') {
        await addVocabularyItems('N4', jsonData, numMap, n4Collection);
      }
    } catch (e) {
      log('Error parsing JSON: $e');
    }
  }

  Future<void> addVocabularyItems(
      String vocaLevel, // 'n5' or 'n4'
      List<dynamic> list, // List of vocabulary items
      Map<String, int> numMap, // Tracking the sequence numbers
      CollectionReference collection // Firestore collection reference
      ) async {
    int insertedCount = 0; // Counter for successfully inserted items

    for (var item in list) {
      try {
        String category = item['category'];
        numMap.update(category, (value) => value + 1, ifAbsent: () => 1);

        await collection.add({
          'topic': vocaLevel,
          'category': category,
          'type': item['type'],
          'voca': item['voca'],
          'vocaMean': {
            'ko': item['vocaMean']['ko'],
            'en': item['vocaMean']['en'],
          },
          'expression': item['expression'],
          'meaning': {
            'ko': item['meaning']['ko'],
            'en': item['meaning']['en'],
          },
          'quiz': {
            'ko': item['quiz']['ko'],
            'en': item['quiz']['en'],
          },
          'seq': numMap[category]!,
        });
        insertedCount++; // Increment counter after successful insertion
      } catch (e) {
        log('Failed to insert ${item['voca']}: $e'); // Log failed insertions
      }
    }

    // Log total count of successfully inserted items
    log(
        '$insertedCount items successfully inserted into $vocaLevel collection.');
  }

  Future<void> loadJsonFrom(String category) async {
    // List<String> targets = [];
    // CollectionReference collection;
    if (category.toLowerCase() == 'hiragana' ||
        category.toLowerCase() == 'katakana') {
      insertAlphabet('');
    }
    if (category.toLowerCase() == 'hiragana_word' ||
        category.toLowerCase() == 'katakana_word') {
      String jsonString = await rootBundle
          .loadString('assets/data/${category.split('_')[0]}/$category.json');
      insertWords(jsonString);
    }
    if (category.toLowerCase() == 'pattern') {
      for (int i = 1; i <= 18; i++) {
        ['', '_exp', '_word'].forEach((element) async {
          String target = i.toString().padLeft(3, '0');
          target = target + element;
          String jsonString =
              await rootBundle.loadString('assets/data/$category/$target.json');
          // log(jsonString.toString());
          insertPattern(i.toString().padLeft(3, '0'), jsonString);
        });
      }
    }
    if (category.toLowerCase() == 'section') {
      for (var section in ['home', 'pattern', 'voca']) {
        String jsonString = await rootBundle
            .loadString('assets/data/$category/${category}_$section.json');
        var jsonData = jsonDecode(jsonString);
        var batch = FirebaseFirestore.instance.batch();

        jsonData.forEach((levelData) {
          levelData.forEach((level, details) {
            var docRef =
                FirebaseFirestore.instance.collection('sections').doc(level);
            batch.set(docRef, details);
          });
        });
        await batch.commit().then((_) {
          log("Vocabulary data successfully added to Firestore!");
        }).catchError((error) {
          log("Error writing document: $error");
        });
      }
    }
  }

  // Future<void> loadJsonData(String category) async {
  //   // String jsonString =
  //   //     await rootBundle.loadString('assets/data/voca/n5/category_verbs.json');
  //   // final jsonResponse = jsonDecode(jsonString);
  //   // log(jsonResponse.toString());
  //   List<String> targets = [];
  //   CollectionReference collection;
  //   try {
  //     if (category.toUpperCase() == 'N5') {
  //       targets = n5names;
  //       collection = n5Collection;
  //     } else if (category.toUpperCase() == 'N4') {
  //       targets = n4names;
  //       collection = n4Collection;
  //     } else if (category.toUpperCase() == 'N3') {
  //       targets = n4names;
  //       collection = n4Collection;
  //     } else if (category.toUpperCase() == 'N2') {
  //       targets = n4names;
  //       collection = n4Collection;
  //     } else if (category.toUpperCase() == 'N1') {
  //       targets = n4names;
  //       collection = n4Collection;
  //     } else {
  //       targets = n4names;
  //       collection = n4Collection;
  //     }

  //     // 파일 목록에 따라 각 파일을 읽습니다.
  //     for (String fileName in targets) {
  //       log(fileName);
  //       String filePath = 'assets/data/voca/$category/$fileName';
  //       String fileContent = await rootBundle.loadString(filePath);

  //       var jsonData = jsonDecode(fileContent);
  //       // insertVoca(category, jsonData);

  //       log('Inserting $category data: $jsonData');
  //       Map<String, int> numMap = {};
  //       await addVocabularyItems(category, jsonData, numMap, collection);
  //     }
  //   } catch (e) {
  //     log('Error parsing JSON: $e');
  //   }
  // }

  Map<String, String> urlCache = {};
  GttsService gttsService = GttsService();
  void insertAlphabet(String jsonString) async {
    int res = 0; // This will keep track of how many documents have been added
    for (int i = 0; i < 2; i++) {
      String section = i == 0 ? 'hiragana' : 'katakana';
      String jsonString =
          await rootBundle.loadString('assets/data/$section/$section.json');
      List<dynamic> list = jsonDecode(jsonString);
      for (var item in list) {
        try {
          String fileName = item['seq'].toString().padLeft(2, '0');

          String url = await uploadFileAndSaveData(fileName);

          await alphabetCollection.add({
            'topic': item['topic'],
            'character': item['character'],
            'romaji': item['romaji'],
            'sound': {
              'ko': item['sound']['ko'],
              'en': item['sound']['en'],
            },
            'seq': item['seq'],
            'url': url,
          }).then((docRef) {
            res++;
            // log("Document added with ID: ${docRef.id}");
          });
        } catch (e) {
          log("Error adding document: $e");
        }
      }
    }

    log("$res documents were successfully added.");
  }

  Future<String> uploadFileAndSaveData(fileName) async {
    if (urlCache.containsKey(fileName)) {
      return urlCache[fileName]!;
    }

    String assetPath = 'assets/data/audio/$fileName.mp3';
    ByteData data = await rootBundle.load(assetPath);
    Uint8List bytes = data.buffer.asUint8List();

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
    return '';
  }

  // void update(String docId, bool isDone) async {
  //   // bucket isDone 업데이트
  //   await bucketCollection.doc(docId).update({"isDone": isDone});
  //   notifyListeners();
  // }

  // void delete(String docId) async {
  //   // bucket 삭제
  //   await bucketCollection.doc(docId).delete();
  //   notifyListeners();
  // }
}
