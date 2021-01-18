import '../models/translations.dart';
import '../models/language.dart';
import '../models/currency.dart';
import "../models/country.dart";
import '../models/regional_bloc.dart';
import '../extensions/currency_ext.dart';
import '../extensions/language_ext.dart';
import '../extensions/translations_ext.dart';
import '../extensions/regional_bloc_ext.dart';
import '../extensions/language_ext.dart';

extension ToCountry on Map {
  Country toCountry() {
    String name = this["name"];
    List<String> topLevelDomain = [];
    try {
      topLevelDomain = List<String>.from(this['topLevelDomain']);
    } catch (e) {
      print("topLevelDomain: " + e.toString());
    }
    String alpha2Code = this["alpha2Code"];
    String alpha3Code = this["alpha3Code"];
    List<String> callingCodes = [];
    try {
      callingCodes = List<String>.from(this['callingCodes']);
    } catch (e) {
      print("callingCodes: " + e.toString());
    }
    String capital = this["capital"];
    List<String> altSpellings = [];
    try {
      altSpellings = List<String>.from(this['altSpellings']);
    } catch (e) {
      print("altSpellings: " + e.toString());
    }
    String region = this["region"];
    String subregion = this["subregion"];
    int population = int.parse(this["population"].toString());
    List<double> latlng = [];
    try {
      latlng = List<double>.from(this['latlng']);
    } catch (e) {
      print("latlng: " + e.toString());
    }
    String demonym = this["demonym"];
    double area = this["area"] == null ? 0 : double.parse(this["area"].toString());
    double gini = this["gini"] == null ? 0 : double.parse(this["gini"].toString());
    List<String> timezones = [];
    try {
      timezones = List<String>.from(this['timezones']);
    } catch (e) {
      print("timezones: " + e.toString());
    }
    List<String> borders = [];
    try {
      borders = List<String>.from(this['borders']);
    } catch (e) {
      print("borders: " + e.toString());
    }

    String nativeName = this["nativeName"];
    String numericCode = this["numericCode"];

    List<Currency> currencies = [];
    try {
      List<dynamic> cs = this["currencies"];
      cs.forEach((c) {
        Map currency = c;
        currencies.add(currency.toCurrency());
      });
    } catch (e) {
      print("currencies: " + e.toString());
    }

    List<Language> languages = [];
    try {
      List<dynamic> ls = this["languages"];
      ls.forEach((l) {
        Map language = l;
        languages.add(language.toLanguage());
      });
    } catch (e) {
      print("languages: " + e.toString());
    }

    Translations translations;
    try {
      Map ts = this["translations"];
      translations = ts.toTranslations();
    } catch(e) {
      print("translations: " + e.toString());
    }

    String flag = this["flag"];

    List<RegionalBloc> regionalBlocs = [];
    try {

      List<dynamic> rbs =  this["regionalBlocs"];
      rbs.forEach((rb) {
        Map regionalBloc = rb;
        regionalBlocs.add(regionalBloc.toRegionalBloc());
      });
    } catch (e) {
      print("regionalBlocs: " + e.toString());
    }

    String cioc = this["cioc"];

    return Country(name: name, topLevelDomain: topLevelDomain, alpha2Code: alpha2Code, alpha3Code: alpha3Code, callingCodes: callingCodes, capital: capital, altSpellings: altSpellings, region: region, subregion: subregion,
      population: population, latlng: latlng, demonym: demonym, area: area, gini: gini, timezones: timezones, borders: borders, nativeName: nativeName, numericCode: numericCode, currencies: currencies, languages: languages,
      translations: translations, flag: flag, regionalBloc: regionalBlocs, cioc: cioc,
    );
  }
}