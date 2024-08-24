import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/address/city_model.dart';
import 'package:hippopants/models/address/county_model.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/widgets/sheets/selector_sheet.dart';

class AddAddressController extends GetxController {
  final cities = <CityModel>[].obs;
  final counties = <CountyModel>[].obs;

  final currentCityID = 0.obs;
  final currentCountyID = 0.obs;

  Map<String, ValidEditingController> validators = {
    "city": ValidEditingController(validFn: (_) => null),
    "county": ValidEditingController(validFn: (_) => null),
  };

  @override
  void onInit() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    await loadCounties();
    await loadCities();

    EasyLoading.dismiss();

    super.onInit();
  }

  Future<void> loadCities() async {
    final jsonString =
        await DefaultAssetBundle.of(Get.context!).loadString('assets/data/cities.json');

    final jsonResponse = json.decode(jsonString);
    final citiesJson = jsonResponse["data"] as List<dynamic>;
    final items = citiesJson.map((e) => CityModel.fromMap(e)).toList();

    cities.addAll(items);
    cities.sort((a, b) => a.name.toLowerCaseTurkish().compareTo(b.name.toLowerCaseTurkish()));

    setCity(cities[0]);
  }

  Future<void> loadCounties() async {
    final jsonString =
        await DefaultAssetBundle.of(Get.context!).loadString('assets/data/counties.json');

    final jsonResponse = json.decode(jsonString);
    final countiesJson = jsonResponse["data"] as List<dynamic>;
    final items = countiesJson.map((e) => CountyModel.fromMap(e)).toList();

    counties.addAll(items);
    counties.sort((a, b) => a.name.toLowerCaseTurkish().compareTo(b.name.toLowerCaseTurkish()));

    setCounty(counties[0]);
  }

  void changeCity() async {
    final value = await SelectorSheet.open(
      "select_city",
      cities.map((city) => city.name).toList(),
    );
    if (value == null) return;

    final city = cities.firstWhereOrNull((e) => e.name == value);
    if (city == null) return;

    setCity(city);
  }

  void changeCounty() async {
    final value = await SelectorSheet.open(
      "select_city",
      counties.where((e) => e.cityID == currentCityID.value).map((county) => county.name).toList(),
    );
    if (value == null) return;

    final county = counties.firstWhereOrNull((e) => e.name == value);
    if (county == null) return;

    setCounty(county);
  }

  void setCity(CityModel city) {
    currentCityID.value = city.id;
    validators["city"]!.controller.text = city.name.toLowerCaseTurkish().turkishTitleCase;

    final county = counties.firstWhere((e) => e.cityID == currentCityID.value);
    setCounty(county);
  }

  void setCounty(CountyModel county) {
    currentCountyID.value = county.id;
    validators["county"]!.controller.text = county.name.toLowerCaseTurkish().turkishTitleCase;
  }
}
