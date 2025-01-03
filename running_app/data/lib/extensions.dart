import 'dart:ui';

import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/models/position_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/position.dart';

import 'dart:typed_data';

extension CoordinatesEntityExtension on CoordinatesEntity {
  Coordinates toGemCoordinates() => Coordinates(latitude: latitude, longitude: longitude);

  Future<Landmark> toGemLandmark() async {
    final lmk = Landmark();
    lmk.coordinates = toGemCoordinates();
    return lmk;
  }
}

extension GemPositionExtension on GemPosition {
  PositionEntityImpl? toEntityImpl() {
    if (!hasCoordinates) return null;
    return PositionEntityImpl(ref: this, coordinates: coordinates.toEntity(), speed: speed, altitude: altitude);
  }
}

extension AddressInfoExtension on AddressInfo {
  String toAddressString() {
    final country = getField(AddressField.country);
    final city = getField(AddressField.city);
    final street = getField(AddressField.streetName);
    return '$street $city $country';
  }
}

extension GemLandmarkExtension on Landmark {
  LandmarkEntityImpl toEntityImpl({int width = 48, int height = 48, Uint8List? image, bool isPositionBased = false}) {
    final landmarkImage = image ?? getImage(size: Size(width.toDouble(), height.toDouble()));

    return LandmarkEntityImpl(
      ref: this,
      icon: landmarkImage,
      isPositionBased: isPositionBased,
    );
  }
}
