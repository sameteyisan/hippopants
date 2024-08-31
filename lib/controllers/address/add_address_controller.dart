import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/address/addresses_controller.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/models/address/city_model.dart';
import 'package:hippopants/models/address/county_model.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/widgets/modals/sure_modal.dart';
import 'package:hippopants/widgets/sheets/selector_sheet.dart';

class AddAddressController extends GetxController {
  final cities = <CityModel>[].obs;
  final counties = <CountyModel>[].obs;

  final byDefault = false.obs;

  final currentCityID = 0.obs;
  final currentCountyID = 0.obs;

  final phoneController = MaskedTextController(mask: '(000) 000 00 00');

  AddressModel? addressModel;
  AddAddressController(this.addressModel);

  Map<String, ValidEditingController> validators = {
    "name": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
          return "name_entered_must_least_3_characters";
        }

        return null;
      },
    ),
    "surname": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
          return "surname_entered_must_least_2_characters";
        }

        return null;
      },
    ),
    "city": ValidEditingController(validFn: (_) => null),
    "county": ValidEditingController(validFn: (_) => null),
    "address": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthGreaterThan(txt?.trim(), 3)) {
          return "error address";
        }

        return null;
      },
    ),
    "postcode": ValidEditingController(
      validFn: (txt) {
        final text = txt?.trim() ?? "";

        if (text.isEmpty || Helpers.isValidPostCode(text)) {
          return null;
        }

        return "error_postcode";
      },
    ),
  };

  @override
  void onInit() async {
    final controller = AuthController.to;

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    validators["name"]!.controller.text = controller.getName;
    validators["surname"]!.controller.text = controller.getSurname;

    await loadCounties();
    await loadCities();

    if (addressModel != null) setFields();

    EasyLoading.dismiss();

    super.onInit();
  }

  @override
  void onClose() {
    for (final validator in validators.values) {
      validator.dispose();
    }

    phoneController.dispose();
    super.onClose();
  }

  void setFields() {
    validators["name"]!.controller.text = addressModel!.name;
    validators["surname"]!.controller.text = addressModel!.surname;
    validators["address"]!.controller.text = addressModel!.address;
    validators["postcode"]!.controller.text = addressModel!.postcode;

    phoneController.text = addressModel!.phone.substring(1);

    byDefault.value = addressModel!.byDefault;

    setCity(addressModel!.city);
    setCounty(addressModel!.county);
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
      "select_county",
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

  String? isValid() {
    for (final validator in validators.values) {
      final err = validator.validFn(validator.controller.text);
      if (err != null) return err;
    }

    final phone = phoneController.text.trim();

    if (phone.length < 13) {
      return 'enter_valid_phone_number';
    }

    return null;
  }

  void setByDefault(bool? value) {
    byDefault.value = value ?? byDefault.value;
  }

  void deleteAddress(int addressID) async {
    final value = await SureModal.show("you_sure_want_delete_address");
    if (value == null) return;

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(300.milliseconds);
    EasyLoading.dismiss();

    AddressesController.to.addresses.removeWhere((e) => e.id == addressID);
    Get.back();
    Helpers.showToast("address_deleted_succesfully");
  }

  void addAddress() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    final address = AddressModel(
      id: addressModel?.id ??
          (Helpers.hasController<AddressesController>()
              ? AddressesController.to.addresses.length
              : 1),
      name: validators["name"]!.controller.text.trim(),
      surname: validators["surname"]!.controller.text.trim(),
      city: cities.firstWhere((e) => e.id == currentCityID.value),
      county: counties.firstWhere((e) => e.id == currentCountyID.value),
      postcode: validators["postcode"]!.controller.text.trim(),
      address: validators["address"]!.controller.text.trim(),
      phone:
          "0${phoneController.text.trim().replaceAll(" ", "").replaceAll("(", "").replaceAll(")", "")}",
      byDefault: false,
    );

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(300.milliseconds);
    EasyLoading.dismiss();

    Get.back(result: address);
    Helpers.showToast("address_added_succesfully");
  }
}
