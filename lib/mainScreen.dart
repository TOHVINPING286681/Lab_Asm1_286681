import 'dart:async';
import 'dart:convert';

import 'package:country_information_app/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var gdp = 0.0,
      name = "",
      desc = "",
      iso2 = "",
      currency = "",
      country = "",
      capital = "";
  // information info = information("", "", "", "", "", "", 0.0);
  TextEditingController cName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Country Information App"),
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Please key in the country to get country information.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: cName,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter the country name',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: onpressed,
                  child: Text(
                    "Search",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
            ],
          ),
        ));
  }

  Widget countryFlag() {
    if (cName.text.isNotEmpty && iso2.isNotEmpty) {
      return Image.network(
        "https://flagsapi.com/$iso2/flat/64.png",
        scale: 0.4,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    cName.dispose();
    super.dispose();
  }

  Widget countryInformation() {
    try {
      if (cName.text.isNotEmpty &&
          gdp.isFinite &&
          name.isNotEmpty &&
          currency.isNotEmpty &&
          country.isNotEmpty &&
          capital.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Capital"),
              const Icon(
                Icons.business,
                size: 64,
              ),
              Text(capital),
            ],
          ),
          color: Colors.blue[100],
        );
      }
      // else if (cName.text.isEmpty) {
      //   return const Text("Please check the country name against!");
      // }
      else {
        return const Text("Please check the country name against!");
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> onpressed() async {
    String countryName = cName.text;
    var url =
        Uri.parse('https://api.api-ninjas.com/v1/country?name=$countryName');
    var response = await http.get(url, headers: {
      'X-Api-Key': 'YO7Jj+s3cwGjrQiV312nOw==11FXyILyRBswWmkl',
    });
    var rescode = response.statusCode;
    try {
      if (rescode == 200 && cName.text.isNotEmpty) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          iso2 = parsedJson[0]['iso2'];
          country = parsedJson[0]['name'];
          capital = parsedJson[0]['capital'];
          gdp = parsedJson[0]['gdp'];
          currency = parsedJson[0]['currency']['code'];
          name = parsedJson[0]['currency']['name'];
          desc = "The country you search is $country.";
          // info = information(name, desc, iso2, currency, country, capital, gdp);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => dataPage(
                    countryName: cName,
                    iso2: iso2,
                    country: country,
                    capital: capital,
                    gdp: gdp,
                    name: name,
                    desc: desc,
                    currency: currency)),
          );
        });
        //print(response.body);
      } else {
        setState(() {
          gdp = 0.0;
          name = "";
          desc = "";
          iso2 = "";
          currency = "";
          country = "";
          capital = "";
          desc = "\tNo record.\nPlease check the country name against!";
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => dataPage(
                    countryName: cName,
                    iso2: iso2,
                    country: country,
                    capital: capital,
                    gdp: gdp,
                    name: name,
                    desc: desc,
                    currency: currency)),
          );
        });
      }
    } catch (e) {
      setState(() {
        gdp = 0.0;
        name = "";
        desc = "";
        iso2 = "";
        currency = "";
        country = "";
        capital = "";
        desc = "\t No record.\nPlease check the country name against!";
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => dataPage(
                  countryName: cName,
                  iso2: iso2,
                  country: country,
                  capital: capital,
                  gdp: gdp,
                  name: name,
                  desc: desc,
                  currency: currency)),
        );
      });
    }
  }
}

class dataPage extends StatefulWidget {
  var iso2, country, capital, name, desc, currency, countryName;
  var gdp;
  dataPage(
      {Key? key,
      required this.capital,
      required this.country,
      required this.name,
      required this.currency,
      required this.iso2,
      required this.gdp,
      required this.desc,
      required this.countryName})
      : super(key: key);
  @override
  State<dataPage> createState() => _dataPageState();
}

class _dataPageState extends State<dataPage> {
  //MainScreen method = new MainScreen();
  var desc = "";
  // information info = information("", "", "", "", "", "", 0.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Country Information App"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Container(
                    width: 400,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(179, 0, 255, 255),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          desc,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: _MainScreenState().countryFlag(),
                        ),
                        Center(
                          child: _MainScreenState().countryInformation(),
                        ),
                        SizedBox(
                          width: 400,
                          height: 126,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
