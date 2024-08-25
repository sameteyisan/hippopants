import 'package:hippopants/models/address/city_model.dart';
import 'package:hippopants/models/address/county_model.dart';
import 'package:hippopants/utils/extensions.dart';

class AddressModel {
  final int id;
  final String name;
  final String surname;
  final CityModel city;
  final CountyModel county;
  final String address;
  final String postcode;
  final String phone;
  final bool byDefault;
  AddressModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.city,
    required this.county,
    required this.address,
    required this.postcode,
    required this.phone,
    required this.byDefault,
  });

  String get fullname => "$name $surname";

  String get cityCounty =>
      "${postcode.isEmpty ? "" : "$postcode "}${city.name.toLowerCaseTurkish().turkishTitleCase}/${county.name.toLowerCaseTurkish().turkishTitleCase}";
}
