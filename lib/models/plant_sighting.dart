import 'package:latlong2/latlong.dart';
import 'plant.dart';

/// 植物の目撃記録
class PlantSighting {
  final String id;
  final String plantId;
  final String plantName;
  final String plantEmoji;
  final PlantCategory category;
  final LatLng location;
  final String? note;
  final DateTime createdAt;

  const PlantSighting({
    required this.id,
    required this.plantId,
    required this.plantName,
    required this.plantEmoji,
    required this.category,
    required this.location,
    this.note,
    required this.createdAt,
  });

  PlantSighting copyWith({
    String? id,
    String? plantId,
    String? plantName,
    String? plantEmoji,
    PlantCategory? category,
    LatLng? location,
    String? note,
    DateTime? createdAt,
  }) {
    return PlantSighting(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      plantName: plantName ?? this.plantName,
      plantEmoji: plantEmoji ?? this.plantEmoji,
      category: category ?? this.category,
      location: location ?? this.location,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
