import 'package:naruhodo/src/model/lang.dart';
import 'package:naruhodo/src/model/section_content.dart';

class Section {
  final int? seq;
  final Lang? title;
  final Lang? desc;
  final List<SectionContent> contents;

  Section({
    this.seq,
    this.title,
    this.desc,
    required this.contents,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    // print('json $json');
    var contentsJson = json['contents'] as List<dynamic>;
    List<SectionContent> contents = contentsJson
        .map((contentJson) =>
            SectionContent.fromJson(contentJson as Map<String, dynamic>))
        .toList();

    return Section(
      seq: json['seq'] as int,
      title: Lang.fromJson(json['title'] as Map<String, dynamic>),
      desc: Lang.fromJson(json['desc'] as Map<String, dynamic>),
      contents: contents,
    );
  }
}
