import "../models/language.dart";

extension ToLanguage on Map {
  Language toLanguage() {
    String iso639_1 = this["iso639_1"];
    String iso639_2 = this["iso639_2"];
    String name = this["name"];
    String nativeName = this["nativeName"];
    return Language(iso639_1: iso639_1, iso639_2: iso639_2, name: name, nativeName: nativeName);
  }
}