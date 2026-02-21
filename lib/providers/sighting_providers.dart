import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:latlong2/latlong.dart';
import '../models/plant_sighting.dart';
import '../data/plant_data.dart';

const _uuid = Uuid();

/// 目撃記録リスト
class SightingsNotifier extends Notifier<List<PlantSighting>> {
  @override
  List<PlantSighting> build() => [];

  /// 新しい目撃記録を追加
  void add({
    required String plantId,
    required LatLng location,
    String? note,
  }) {
    final plant = PlantData.allPlants.firstWhere((p) => p.id == plantId);
    final sighting = PlantSighting(
      id: _uuid.v4(),
      plantId: plant.id,
      plantName: plant.name,
      plantEmoji: plant.emoji,
      category: plant.category,
      location: location,
      note: note,
      createdAt: DateTime.now(),
    );
    state = [...state, sighting];
  }

  /// 目撃記録を削除
  void remove(String id) {
    state = state.where((s) => s.id != id).toList();
  }
}

final sightingsProvider =
    NotifierProvider<SightingsNotifier, List<PlantSighting>>(
  SightingsNotifier.new,
);

/// 地図上でタップした位置
class TappedLocationNotifier extends Notifier<LatLng?> {
  @override
  LatLng? build() => null;

  void set(LatLng location) => state = location;

  void clear() => state = null;
}

final tappedLocationProvider =
    NotifierProvider<TappedLocationNotifier, LatLng?>(
  TappedLocationNotifier.new,
);

/// 選択中の目撃記録（地図のマーカータップ時）
class SelectedSightingNotifier extends Notifier<PlantSighting?> {
  @override
  PlantSighting? build() => null;

  void select(PlantSighting sighting) => state = sighting;

  void clear() => state = null;
}

final selectedSightingProvider =
    NotifierProvider<SelectedSightingNotifier, PlantSighting?>(
  SelectedSightingNotifier.new,
);
