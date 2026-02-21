import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/plant.dart';
import '../providers/plant_providers.dart';
import '../widgets/plant_card.dart';
import '../widgets/category_filter.dart';
import 'plant_detail_screen.dart';

/// 植物一覧画面
class PlantListScreen extends ConsumerStatefulWidget {
  const PlantListScreen({super.key});

  @override
  ConsumerState<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends ConsumerState<PlantListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plants = ref.watch(filteredPlantsProvider);
    final isSearching = ref.watch(isSearchingProvider);

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '植物を検索...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                ),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).update(value);
                },
              )
            : const Text('🌿 植物図鑑'),
        centerTitle: !isSearching,
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              final wasSearching = ref.read(isSearchingProvider);
              if (wasSearching) {
                ref.read(searchQueryProvider.notifier).clear();
                _searchController.clear();
              }
              ref.read(isSearchingProvider.notifier).toggle();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // カテゴリフィルター
          CategoryFilter(
            selectedCategory: ref.watch(selectedCategoryProvider),
            onCategorySelected: (category) {
              ref.read(selectedCategoryProvider.notifier).select(category);
            },
          ),
          const SizedBox(height: 8),
          // 件数表示
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  '${plants.length}件の植物',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 植物グリッド
          Expanded(
            child: plants.isEmpty
                ? _buildEmptyState()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // 画面幅に応じて列数を動的に決定（モバイルは2列のまま）
                      final crossAxisCount =
                          (constraints.maxWidth / 200).floor().clamp(2, 6);
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: plants.length,
                        itemBuilder: (context, index) {
                          final plant = plants[index];
                          return PlantCard(
                            plant: plant,
                            onTap: () => _navigateToDetail(plant),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            '植物が見つかりませんでした',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '検索条件を変更してみてください',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(Plant plant) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlantDetailScreen(plant: plant),
      ),
    );
  }
}
