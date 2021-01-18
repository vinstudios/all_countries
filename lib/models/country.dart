import '../models/translations.dart';
import '../models/language.dart';
import '../models/regional_bloc.dart';
import '../models/currency.dart';

class Country {
  String name;
  List<String> topLevelDomain = [];
  String alpha2Code;
  String alpha3Code;
  List<String> callingCodes = [];
  String capital;
  List<String> altSpellings = [];
  String region;
  String subregion;
  int population;
  List<double> latlng = [];
  String demonym;
  double area;
  double gini;
  List<String> timezones = [];
  List<String> borders = [];
  String nativeName;
  String numericCode;
  List<Currency> currencies = [];
  List<Language> languages = [];
  Translations translations;
  String flag;
  List<RegionalBloc> regionalBloc = [];
  String cioc;

  Country({this.name, this.topLevelDomain, this.alpha2Code, this.alpha3Code, this.callingCodes, this.capital, this.altSpellings, this.region, this.subregion,
    this.population, this.latlng, this.demonym, this.area, this.gini, this.timezones, this.borders, this.nativeName, this.numericCode, this.currencies, this.languages,
    this.translations, this.flag, this.regionalBloc, this.cioc,
  });
}