import 'dart:async';
import 'dart:convert';
import 'package:countries/views/location_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../models/country.dart';
import '../extensions/country_ext.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String urlAll = "https://restcountries.eu/rest/v2/all";
  String urlSearch = "https://restcountries.eu/rest/v2/name/";
  String searchText = "";
  String error = "";
  bool loaded = false;
  bool loading = false;
  bool search = false;
  List<Country> countries = [];
  Timer timer;
  int elapsed = 0;

  void startCount(int millis) async {
    timer = Timer.periodic(Duration(milliseconds: 1), (t) {
      if (t.tick - elapsed >= millis) {
        elapsed = t.tick;
        timer.cancel();
        loadCountries(url: urlSearch + searchText);
      }
    });
  }

  void loadCountries({String url = urlAll}) async {
    setState(() {
      countries.clear();
      if (error.isNotEmpty) {
        error = "";
        search = false;
        searchText = "";
      }
      loaded = true;
      loading = true;
    });
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data =  json.decode(response.body);
        if (data.length > 0) {
          data.forEach((c) {
            Map country = c;
            countries.add(country.toCountry());
          });
          print(countries.length);
          error = "";
        }

      } else {
        error = "Error: status code: " + response.statusCode.toString();
        print("Error: status code: " + response.statusCode.toString());
      }

    } catch (e) {
      print("RESPONSE ERROR: " + e.toString());
      error = "RESPONSE ERROR: " + e.toString();
    }

    setState(() {
      loading = false;
    });
  }

  Widget body() {

    if (!loaded) {
      return SizedBox.expand(
        child: Center(
          child: Material(
            color: Colors.blue,
            elevation: 3,
            borderRadius: BorderRadius.circular(0),
            child: InkWell(
              child: Container(
                height: 40,
                width: 150,
                alignment: Alignment.center,
                child: Text("Load all countries", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
              onTap: loadCountries,
            ),
          ),
        ),
      );
    }
    else if (error.isNotEmpty) {
      return SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 30,),
              SizedBox(height: 5),
              Text(error),
              SizedBox(height: 20),
              Material(
                color: Colors.blue,
                elevation: 3,
                borderRadius: BorderRadius.circular(0),
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: 150,
                    alignment: Alignment.center,
                    child: Text("Reload all countries", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                  onTap: loadCountries,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.separated(
        itemCount: countries.length,
        itemBuilder: (context, index) {

          String name = "";
          String cioc = "";
          String capital = "";
          String region = "";
          String callingCodes = "";
          String population = "";
          String currency = "";
          String latlng = "";
          String languages = "";
          String borders = "";

          try {
            name = countries[index].name.toString();
            cioc = countries[index].cioc.toString();
            capital = countries[index].capital.toString();
            region = countries[index].region.toString();
            callingCodes = countries[index].callingCodes.join(", ").toString();
            population = countries[index].population.toString();
            currency = countries[index].currencies[0].symbol.toString();
            latlng = countries[index].latlng.join(", ").toString();

            countries[index].languages.forEach((l) {
              languages += l.name.toString() + ", ";
            });

            borders = countries[index].borders.join(", ");

          } catch (e) {
            print("data error: " + e.toString());
          }

          return Material(
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: SvgPicture.network(
                                  countries[index].flag,
                                  fit: BoxFit.cover,
                                  // width: 30,
                                  // height: 15,
                                  placeholderBuilder: (context) => Container(
                                    // width: 30,
                                    // height: 15,
                                    child: Icon(Icons.flag_outlined, color: Colors.grey, size: 10,),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3),
                              Expanded(child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1),)),
                            ],
                          ),
                          SizedBox(height: 5),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Abbv: " + cioc, style: TextStyle(fontSize: 11),),
                                    Text("Capital: " + capital, style: TextStyle(fontSize: 11),),
                                    Text("Region: " + region, style: TextStyle(fontSize: 11),),
                                    Text("Calling Codes: " + callingCodes, style: TextStyle(fontSize: 11),),
                                    Text("Population: " + population, style: TextStyle(fontSize: 11),),
                                  ],
                                ),
                                SizedBox(width: 10),
                                VerticalDivider(width: 1),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Currency: " + currency, style: TextStyle(fontSize: 11),),
                                      Text("LatLng: " + latlng, style: TextStyle(fontSize: 11),),
                                      Text("Languages: " + languages, style: TextStyle(fontSize: 11),),
                                      Text("Borders: " + borders, style: TextStyle(fontSize: 11),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward_ios, size: 18),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => LocationMap(countries[index])));
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: !search ? Text("Countries") : TextField(
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              hintText: "Search country name or abbreviation",
              hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
            ),
            onChanged: (val) {

              if (timer != null) {
                timer.cancel();
              }
              elapsed = 0;

              if (val.isNotEmpty) {
                searchText = val;
                startCount(1800);
              }
            },
          ),
          actions: [
            IconButton(
              icon: Icon(!search ? Icons.search : Icons.close),
              onPressed: () {

                setState(() {
                  search = !search;
                  searchText = "";
                });

                if (!search) {
                  loadCountries();
                }

              },
            ),
          ],
        ),
        body: body(),
      ),
    );
  }
}
