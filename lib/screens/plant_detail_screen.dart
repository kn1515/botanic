import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/plant.dart';

/// 植物詳細画面
class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ヘッダー
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                plant.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(blurRadius: 8, color: Colors.black54),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: _getCategoryGradient(plant.category),
                  ),
                ),
                child: plant.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: plant.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Center(
                          child: Hero(
                            tag: 'plant_${plant.id}',
                            child: Text(
                              plant.emoji,
                              style: const TextStyle(fontSize: 100),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Hero(
                            tag: 'plant_${plant.id}',
                            child: Text(
                              plant.emoji,
                              style: const TextStyle(fontSize: 100),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Hero(
                          tag: 'plant_${plant.id}',
                          child: Text(
                            plant.emoji,
                            style: const TextStyle(fontSize: 100),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          // コンテンツ
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 学名・科名
                  _buildInfoHeader(theme),
                  const SizedBox(height: 24),

                  // 説明
                  _buildSection(
                    theme,
                    icon: Icons.description_outlined,
                    title: '概要',
                    child: Text(
                      plant.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 基本情報
                  _buildSection(
                    theme,
                    icon: Icons.info_outline,
                    title: '基本情報',
                    child: _buildBasicInfo(theme),
                  ),
                  const SizedBox(height: 20),

                  // 特徴
                  _buildSection(
                    theme,
                    icon: Icons.star_outline,
                    title: '特徴',
                    child: _buildCharacteristics(theme),
                  ),
                  const SizedBox(height: 20),

                  // お手入れ情報
                  _buildSection(
                    theme,
                    icon: Icons.eco_outlined,
                    title: 'お手入れガイド',
                    child: _buildCareInfo(theme),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoHeader(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.scientificName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plant.family,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getCategoryGradient(plant.category)[0]
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${plant.category.emoji} ${plant.category.label}',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 22, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildBasicInfo(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(theme, '🌍', '生息地', plant.habitat),
            const Divider(height: 20),
            _buildInfoRow(theme, '🌸', '開花時期', plant.bloomingSeason),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    ThemeData theme,
    String emoji,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCharacteristics(ThemeData theme) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: plant.characteristics.map((char) {
        return Chip(
          label: Text(char),
          backgroundColor:
              theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        );
      }).toList(),
    );
  }

  Widget _buildCareInfo(ThemeData theme) {
    final care = plant.careInfo;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 水やり・日照・難易度
            Row(
              children: [
                Expanded(
                  child: _buildCareItem(
                    theme,
                    care.waterLevel.icon,
                    '水やり',
                    care.waterLevel.label,
                  ),
                ),
                Expanded(
                  child: _buildCareItem(
                    theme,
                    care.sunLevel.icon,
                    '日照',
                    care.sunLevel.label,
                  ),
                ),
                Expanded(
                  child: _buildCareItem(
                    theme,
                    '📊',
                    '難易度',
                    care.difficulty,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // 温度
            _buildInfoRow(theme, '🌡️', '適温', care.temperature),
            const SizedBox(height: 16),
            // アドバイス
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text(
                        'アドバイス',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    care.tips,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareItem(
    ThemeData theme,
    String emoji,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  List<Color> _getCategoryGradient(PlantCategory category) {
    switch (category) {
      case PlantCategory.flower:
        return [const Color(0xFFFF8A80), const Color(0xFFFF80AB)];
      case PlantCategory.tree:
        return [const Color(0xFF66BB6A), const Color(0xFF43A047)];
      case PlantCategory.succulent:
        return [const Color(0xFF9CCC65), const Color(0xFF7CB342)];
      case PlantCategory.herb:
        return [const Color(0xFF26A69A), const Color(0xFF00897B)];
      case PlantCategory.fern:
        return [const Color(0xFF4DB6AC), const Color(0xFF009688)];
      case PlantCategory.grass:
        return [const Color(0xFF8BC34A), const Color(0xFF689F38)];
    }
  }
}
