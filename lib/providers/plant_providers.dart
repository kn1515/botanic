import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/plant_data.dart';
import '../models/plant.dart';

/// 選択中のカテゴリ
class SelectedCategoryNotifier extends Notifier<PlantCategory?> {
  @override
  PlantCategory? build() => null;

  void select(PlantCategory? category) => state = category;
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, PlantCategory?>(
  SelectedCategoryNotifier.new,
);

/// 検索クエリ
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String query) => state = query;

  void clear() => state = '';
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

/// 検索モードかどうか
class IsSearchingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;

  void close() => state = false;
}

final isSearchingProvider = NotifierProvider<IsSearchingNotifier, bool>(
  IsSearchingNotifier.new,
);

/// フィルタリング済みの植物リスト
final filteredPlantsProvider = Provider<List<Plant>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  List<Plant> plants = PlantData.allPlants;

  if (selectedCategory != null) {
    plants = plants.where((p) => p.category == selectedCategory).toList();
  }

  if (searchQuery.isNotEmpty) {
    final query = searchQuery.toLowerCase();
    plants = plants.where((p) {
      return p.name.toLowerCase().contains(query) ||
          p.scientificName.toLowerCase().contains(query) ||
          p.family.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query);
    }).toList();
  }

  return plants;
});
