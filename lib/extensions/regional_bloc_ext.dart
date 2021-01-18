import "../models/regional_bloc.dart";

extension ToRegionalBloc on Map {
  RegionalBloc toRegionalBloc() {
    String acronym = this["acronym"];
    String name = this["name"];
    List<String> otherAcronyms = [];
    try {
      otherAcronyms = List<String>.from(this['otherAcronyms']);
    } catch (e) {}
    List<String> otherNames = [];
    try {
      otherNames = List<String>.from(this['otherNames']);
    } catch (e) {}

    return RegionalBloc(acronym: acronym, name: name, otherAcronyms: otherAcronyms, otherNames: otherNames);
  }
}