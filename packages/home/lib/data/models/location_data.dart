import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_data.freezed.dart';
part 'location_data.g.dart';

@freezed
abstract class LocationData with _$LocationData {
  const factory LocationData({
    required int id,
    required String name,
    required String description,
    required String imageUrl,
    required String address,
    required String city,
    required String state,
    required String zip,
    required String country,
    required double latitude,
    required double longitude,
    required bool isFavorite,
  }) = _LocationData;

  factory LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);
}
