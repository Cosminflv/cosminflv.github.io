import 'package:data/extensions.dart';
import 'package:data/models/coordinates_entity_impl.dart';
import 'package:data/models/landmark_entity_impl.dart';

import 'package:domain/repositories/landmark_repository.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';

import 'package:gem_kit/core.dart';
import 'package:gem_kit/search.dart';

import 'dart:async';

class LandmarkRepositoryImpl extends LandmarkRepository {
  @override
  LandmarkEntity getLandmarkAtCoordinates(
      {required CoordinatesEntity coordinates, String? name, bool? isPositionBased}) {
    Landmark gemLmk = Landmark();
    gemLmk.coordinates = coordinates.toGemCoordinates();
    gemLmk.name = name ?? '';
    final lmk = gemLmk.toEntityImpl(isPositionBased: isPositionBased ?? false);
    return lmk;
  }

  @override
  Future<LandmarkEntity?> getClosestLandmark(CoordinatesEntity coordinates) async {
    final gemLandmarkCompleter = Completer<Landmark?>();
    final prefs = SearchPreferences(searchAddresses: false, searchMapPOIs: true, maxMatches: 1);
    SearchService.searchAroundPosition((coordinates as CoordinatesEntityImpl).toGemCoordinates(), preferences: prefs,
        (err, result) async {
      if (err != GemError.success || result == null || result.isEmpty) {
        gemLandmarkCompleter.complete(null);
        return;
      }

      gemLandmarkCompleter.complete(result.first);
    });
    Landmark? gemLandmark = await gemLandmarkCompleter.future;
    LandmarkEntity? landmark;
    if (gemLandmark != null) {
      landmark = LandmarkEntityImpl(ref: gemLandmark);
    }
    return landmark;
  }
}