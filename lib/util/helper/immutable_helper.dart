extension ImmutableIterableExt on Iterable {
  /// Runtime Immutable List
  List<T> toImmutable<T>() => List.unmodifiable(this);
}

extension CleanExt on String {
  String clean() => trim().replaceAll(RegExp(r'[~。？?、 ]'), "");
}

extension ReplaceParenthesesExt on String {
  String replaceParenthesesExt() =>
      trim().replaceAll('(', '（').replaceAll(')', '）');
      // trim().replaceAll('(', '（').replaceAll(')', '）');
}

extension ExInsideParentheses on String {
  String exInsideParentheses() => replaceAll(RegExp(r'\(.*?\)'), '').trim();
}

extension Exceptions on String {
  String exceptions() => replaceAll(RegExp(r'\明日'), 'あした').trim();
}
