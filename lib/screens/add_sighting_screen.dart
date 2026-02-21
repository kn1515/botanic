import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../data/plant_data.dart';
import '../models/plant.dart';
import '../providers/sighting_providers.dart';

/// 植物目撃登録画面
class AddSightingScreen extends ConsumerStatefulWidget {
  final LatLng location;

  const AddSightingScreen({super.key, required this.location});

  @override
  ConsumerState<AddSightingScreen> createState() => _AddSightingScreenState();
}

class _AddSightingScreenState extends ConsumerState<AddSightingScreen> {
  Plant? _selectedPlant;
  PlantCategory? _filterCategory;
  final _noteController = TextEditingController();
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _noteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Plant> get _filteredPlants {
    List<Plant> plants = PlantData.allPlants;

    if (_filterCategory != null) {
      plants = plants.where((p) => p.category == _filterCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      plants = plants
          .where((p) =>
              p.name.toLowerCase().contains(query) ||
              p.scientificName.toLowerCase().contains(query))
          .toList();
    }

    return plants;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('植物を登録'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 位置情報ヘッダー
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Row(
              children: [
                Icon(Icons.location_on,
                    color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${widget.location.latitude.toStringAsFixed(5)}, ${widget.location.longitude.toStringAsFixed(5)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // 検索バー
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '植物名で検索...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                isDense: true,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // カテゴリフィルタチップ
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('すべて'),
                  selected: _filterCategory == null,
                  onSelected: (_) {
                    setState(() => _filterCategory = null);
                  },
                ),
                const SizedBox(width: 8),
                ...PlantCategory.values.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      avatar: Text(cat.emoji),
                      label: Text(cat.label),
                      selected: _filterCategory == cat,
                      onSelected: (_) {
                        setState(() {
                          _filterCategory =
                              _filterCategory == cat ? null : cat;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 1),

          // 植物一覧
          Expanded(
            child: _filteredPlants.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🔍', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text(
                          '植物が見つかりません',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: _filteredPlants.length,
                    itemBuilder: (context, index) {
                      final plant = _filteredPlants[index];
                      final isSelected = _selectedPlant?.id == plant.id;

                      return ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              plant.emoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        title: Text(
                          plant.name,
                          style: TextStyle(
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(
                          '${plant.category.emoji} ${plant.category.label}  ·  ${plant.scientificName}',
                          style: theme.textTheme.bodySmall,
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle,
                                color: theme.colorScheme.primary)
                            : null,
                        selected: isSelected,
                        onTap: () {
                          setState(() => _selectedPlant = plant);
                        },
                      );
                    },
                  ),
          ),

          // メモ入力 & 登録ボタン
          if (_selectedPlant != null)
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(
                16,
                12,
                16,
                12 + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 選択中の植物表示
                  Row(
                    children: [
                      Text(_selectedPlant!.emoji,
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        '${_selectedPlant!.name} を登録',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // メモ欄
                  TextField(
                    controller: _noteController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'メモ（任意）例: 公園の入口付近に群生',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 登録ボタン
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: _register,
                      icon: const Icon(Icons.add_location_alt),
                      label: const Text('この場所に登録'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _register() {
    if (_selectedPlant == null) return;

    ref.read(sightingsProvider.notifier).add(
          plantId: _selectedPlant!.id,
          location: widget.location,
          note: _noteController.text.isNotEmpty ? _noteController.text : null,
        );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedPlant!.emoji} ${_selectedPlant!.name} を登録しました'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
