import 'package:data/models/coordinates_entity_impl.dart';

import 'package:domain/entities/camera_state_entity.dart';

class MapCameraStateEntityImpl extends MapCameraStateEntity {
  MapCameraStateEntityImpl({required super.coordinates, required super.zoom});

  Map<String, dynamic> toJson() => {
        'coordinates': {
          'lat': coordinates.latitude,
          'lon': coordinates.longitude,
        },
        'zoomLevel': zoom
      };

  static MapCameraStateEntity fromJson(Map<String, dynamic> json) => MapCameraStateEntityImpl(
      coordinates: CoordinatesEntityImpl(latitude: json['coordinates']['lat'], longitude: json['coordinates']['lon']),
      zoom: json['zoomLevel']);
}
