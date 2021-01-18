import "../models/translations.dart";

extension ToTranslations on Map {
  Translations toTranslations() {
    String de = this["de"];
    String es = this["es"];
    String fr = this["fr"];
    String ja = this["ja"];
    String it = this["it"];
    String br = this["br"];
    String pt = this["pt"];
    String nl = this["nl"];
    String hr = this["hr"];
    String fa = this["fa"];
    return Translations(de: de, es: es, fr: fr, ja: ja, it: it, br: br, pt: pt, nl: nl, hr: hr, fa: fa);
  }
}