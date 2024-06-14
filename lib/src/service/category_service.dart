import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/section.dart';
import 'package:naruhodo/src/model/section_content.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';

class SectionService extends ChangeNotifier {
  List<Section> _sectionPattern = [];
  List<Section> get sectionPattern => _sectionPattern;
  List<Section> _sectionHome = [];
  List<Section> get sectionHome => _sectionHome;
  final Map<String, List<SectionContent>> _sectionVoca = {};
  Map<String, List<SectionContent>> get sectionVoca => _sectionVoca;

  Future<void> init() async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('sections').get();

      for (var doc in snapshot.docs) {
        var data = doc.data();

        if (data['contentsContainer'] != null) {
          var contentsContainer = data['contentsContainer'] as List<dynamic>;
          List<Section> sections = contentsContainer.map((sectionData) {
            return Section.fromJson(sectionData as Map<String, dynamic>);
          }).toList();

          if (doc.id == 'home') _sectionHome = sections.toImmutable();
          if (doc.id == 'pattern') _sectionPattern = sections.toImmutable();
        }

        if (data['contents'] != null) {
          var contentsContainer = data['contents'] as List<dynamic>;
          List<SectionContent> contents = contentsContainer
              .map((contentJson) =>
                  SectionContent.fromJson(contentJson as Map<String, dynamic>))
              .toList();

          _sectionVoca
              .putIfAbsent(doc.id, () => [])
              .addAll(contents.toImmutable());
        }
      }

      notifyListeners();
    } catch (e, s) {
      log('Failed to load sections', error: e, stackTrace: s);
    }
  }
}
