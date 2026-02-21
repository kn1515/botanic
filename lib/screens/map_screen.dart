import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/sighting_providers.dart';
import '../models/plant_sighting.dart';
import 'add_sighting_screen.dart';

/// 地図画面 - 植物の目撃場所をマッピング
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  // デフォルト: 東京駅
  LatLng _center = const LatLng(35.6812, 139.7671);
  bool _locationLoaded = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requested = await Geolocator.requestPermission();
        if (requested == LocationPermission.denied ||
            requested == LocationPermission.deniedForever) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      if (mounted) {
        setState(() {
          _center = LatLng(position.latitude, position.longitude);
          _locationLoaded = true;
        });
        _mapController.move(_center, 15);
      }
    } catch (_) {
      // 位置情報取得失敗時はデフォルトのまま
    }
  }

  @override
  Widget build(BuildContext context) {
    final sightings = ref.watch(sightingsProvider);
    final selectedSighting = ref.watch(selectedSightingProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🗺️ 発見マップ'),
        centerTitle: true,
        actions: [
          if (_locationLoaded)
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () => _mapController.move(_center, 15),
              tooltip: '現在地へ移動',
            ),
        ],
      ),
      body: Stack(
        children: [
          // 地図
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 13,
              onTap: (tapPosition, point) {
                ref.read(tappedLocationProvider.notifier).set(point);
                ref.read(selectedSightingProvider.notifier).clear();
                _showAddSightingSheet(context, point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.botanic',
              ),
              // マーカーレイヤー
              MarkerLayer(
                markers: sightings.map((sighting) {
                  final isSelected = selectedSighting?.id == sighting.id;
                  return Marker(
                    point: sighting.location,
                    width: isSelected ? 56 : 44,
                    height: isSelected ? 56 : 44,
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(selectedSightingProvider.notifier)
                            .select(sighting);
                      },
                      child: _buildMarker(sighting, isSelected),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // 登録数バッジ
          Positioned(
            top: 12,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('📍', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    '${sightings.length}件の発見',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 操作ヒント
          if (sightings.isEmpty)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.inverseSurface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '地図をタップして植物を登録しましょう 🌱',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onInverseSurface,
                    ),
                  ),
                ),
              ),
            ),

          // 選択中のマーカー詳細カード
          if (selectedSighting != null)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: _buildSightingCard(context, selectedSighting),
            ),
        ],
      ),
      // + ボタン（現在地に追加）
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final location = _locationLoaded
              ? _center
              : const LatLng(35.6812, 139.7671);
          _showAddSightingSheet(context, location);
        },
        icon: const Icon(Icons.add_location_alt),
        label: const Text('現在地で登録'),
      ),
    );
  }

  Widget _buildMarker(PlantSighting sighting, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primaryContainer,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isSelected ? 0.3 : 0.15),
            blurRadius: isSelected ? 8 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          sighting.plantEmoji,
          style: TextStyle(fontSize: isSelected ? 24 : 20),
        ),
      ),
    );
  }

  Widget _buildSightingCard(BuildContext context, PlantSighting sighting) {
    final theme = Theme.of(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // 絵文字アイコン
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      sighting.plantEmoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sighting.plantName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${sighting.category.emoji} ${sighting.category.label}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // 閉じるボタン
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    ref.read(selectedSightingProvider.notifier).clear();
                  },
                ),
              ],
            ),
            if (sighting.note != null && sighting.note!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  sighting.note!,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time,
                    size: 14, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  _formatDate(sighting.createdAt),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                // 削除ボタン
                TextButton.icon(
                  onPressed: () => _confirmDelete(context, sighting),
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text('削除'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddSightingSheet(BuildContext context, LatLng location) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddSightingScreen(location: location),
        fullscreenDialog: true,
      ),
    );
  }

  void _confirmDelete(BuildContext context, PlantSighting sighting) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('記録を削除'),
        content: Text('${sighting.plantName}の発見記録を削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(sightingsProvider.notifier).remove(sighting.id);
              ref.read(selectedSightingProvider.notifier).clear();
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
