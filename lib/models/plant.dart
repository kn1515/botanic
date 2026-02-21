/// 植物データモデル
class Plant {
  final String id;
  final String name;
  final String scientificName;
  final String family;
  final String description;
  final String habitat;
  final String bloomingSeason;
  final String emoji;
  final PlantCategory category;
  final List<String> characteristics;
  final CareInfo careInfo;

  const Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.family,
    required this.description,
    required this.habitat,
    required this.bloomingSeason,
    required this.emoji,
    required this.category,
    required this.characteristics,
    required this.careInfo,
  });
}

/// 植物カテゴリ
enum PlantCategory {
  flower('花', '🌸'),
  tree('樹木', '🌳'),
  succulent('多肉植物', '🌵'),
  herb('ハーブ', '🌿'),
  fern('シダ植物', '🍀'),
  grass('草本', '🌾');

  final String label;
  final String emoji;
  const PlantCategory(this.label, this.emoji);
}

/// お手入れ情報
class CareInfo {
  final WaterLevel waterLevel;
  final SunLevel sunLevel;
  final String difficulty;
  final String temperature;
  final String tips;

  const CareInfo({
    required this.waterLevel,
    required this.sunLevel,
    required this.difficulty,
    required this.temperature,
    required this.tips,
  });
}

enum WaterLevel {
  low('少なめ', '💧'),
  medium('普通', '💧💧'),
  high('多め', '💧💧💧');

  final String label;
  final String icon;
  const WaterLevel(this.label, this.icon);
}

enum SunLevel {
  shade('日陰', '🌑'),
  partialShade('半日陰', '⛅'),
  fullSun('日なた', '☀️');

  final String label;
  final String icon;
  const SunLevel(this.label, this.icon);
}
