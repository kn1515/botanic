import 'package:flutter/material.dart';
import '../models/plant.dart';

/// 植物一覧のカードウィジェット
class PlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.plant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 絵文字エリア
            Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _getCategoryColors(plant.category),
                ),
              ),
              child: Center(
                child: Text(
                  plant.emoji,
                  style: const TextStyle(fontSize: 56),
                ),
              ),
            ),
            // 情報エリア
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plant.scientificName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColors(plant.category)[0]
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${plant.category.emoji} ${plant.category.label}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: _getCategoryColors(plant.category)[1],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getCategoryColors(PlantCategory category) {
    switch (category) {
      case PlantCategory.flower:
        return [const Color(0xFFFFCDD2), const Color(0xFFE91E63)];
      case PlantCategory.tree:
        return [const Color(0xFFC8E6C9), const Color(0xFF388E3C)];
      case PlantCategory.succulent:
        return [const Color(0xFFDCEDC8), const Color(0xFF689F38)];
      case PlantCategory.herb:
        return [const Color(0xFFB2DFDB), const Color(0xFF00897B)];
      case PlantCategory.fern:
        return [const Color(0xFFE0F2F1), const Color(0xFF26A69A)];
      case PlantCategory.grass:
        return [const Color(0xFFF1F8E9), const Color(0xFF558B2F)];
    }
  }
}
