import 'package:flutter/material.dart';
import '../models/plant.dart';

/// カテゴリフィルターチップ
class CategoryFilter extends StatelessWidget {
  final PlantCategory? selectedCategory;
  final ValueChanged<PlantCategory?> onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('すべて'),
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
              avatar: selectedCategory == null
                  ? const Icon(Icons.check, size: 18)
                  : const Text('📋', style: TextStyle(fontSize: 14)),
              showCheckmark: false,
            ),
          ),
          ...PlantCategory.values.map((category) {
            final isSelected = selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category.label),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(
                  isSelected ? null : category,
                ),
                avatar: isSelected
                    ? const Icon(Icons.check, size: 18)
                    : Text(category.emoji, style: const TextStyle(fontSize: 14)),
                showCheckmark: false,
              ),
            );
          }),
        ],
      ),
    );
  }
}
