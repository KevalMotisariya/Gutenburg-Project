class FormatSelector {
  static String? getPreferredFormat(Map<String, dynamic> formats) {
    const html = "text/html";
    const pdf = "application/pdf";
    const txt = "text/plain";

    String? findFormat(String type) {
      final entry = formats.entries.firstWhere(
        (e) =>
            e.key.startsWith(type) &&
            !e.key.contains("zip") &&
            !(e.value.toString().endsWith(".zip")),
        orElse: () => const MapEntry("", null),
      );

      return entry.value;
    }

    return findFormat(html) ?? findFormat(pdf) ?? findFormat(txt);
  }
}
