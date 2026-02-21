import '../models/plant.dart';

/// サンプル植物データ
class PlantData {
  static const List<Plant> allPlants = [
    // ===== 花 =====
    Plant(
      id: 'sakura',
      name: 'サクラ',
      scientificName: 'Prunus × yedoensis',
      family: 'バラ科',
      description:
          '日本を代表する花木で、春になると淡いピンク色の花を一斉に咲かせます。'
          '「花見」の文化と深く結びつき、日本人の心の花として古くから愛されてきました。'
          'ソメイヨシノは江戸時代末期に作出された園芸品種で、全国に広く植えられています。',
      habitat: '日本全国、東アジア',
      bloomingSeason: '3月〜4月',
      emoji: '🌸',
      category: PlantCategory.flower,
      characteristics: ['落葉高木', '花弁は5枚', '果実はサクランボ', '樹皮は横縞模様'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.fullSun,
        difficulty: '中級',
        temperature: '耐寒性あり（-15℃まで）',
        tips: '日当たりと風通しの良い場所を好みます。剪定は花後すぐに行いましょう。',
      ),
    ),
    Plant(
      id: 'rose',
      name: 'バラ',
      scientificName: 'Rosa hybrida',
      family: 'バラ科',
      description:
          '「花の女王」とも呼ばれ、世界中で最も人気のある園芸植物の一つです。'
          '数万を超える品種があり、花の色・形・香りのバリエーションは非常に豊富。'
          '古代から観賞用・香料用として栽培されてきた歴史があります。',
      habitat: '北半球の温帯地域原産',
      bloomingSeason: '5月〜11月（四季咲き品種）',
      emoji: '🌹',
      category: PlantCategory.flower,
      characteristics: ['棘がある', '芳香性', '四季咲き品種あり', '多様な花色'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.fullSun,
        difficulty: '中級〜上級',
        temperature: '5℃〜30℃',
        tips: '病害虫に注意。定期的な剪定と施肥で美しい花を咲かせます。',
      ),
    ),
    Plant(
      id: 'sunflower',
      name: 'ヒマワリ',
      scientificName: 'Helianthus annuus',
      family: 'キク科',
      description:
          '太陽に向かって花を咲かせる姿が特徴的な、夏を代表する一年草です。'
          '北アメリカ原産で、種子は食用油の原料としても重要。'
          '草丈は品種により30cmから3m以上まで様々です。',
      habitat: '北アメリカ原産',
      bloomingSeason: '7月〜9月',
      emoji: '🌻',
      category: PlantCategory.flower,
      characteristics: ['一年草', '向日性', '種子は食用', '草丈が高い'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '15℃〜30℃',
        tips: '日当たりの良い場所で育てましょう。種まきは4〜5月が適期です。',
      ),
    ),
    Plant(
      id: 'tulip',
      name: 'チューリップ',
      scientificName: 'Tulipa gesneriana',
      family: 'ユリ科',
      description:
          '春の花壇を彩る球根植物の代表格。オランダを象徴する花として有名です。'
          '17世紀には「チューリップ・バブル」と呼ばれる投機熱を引き起こしたことでも知られています。'
          '花色が非常に豊富で、一重咲き・八重咲きなど花形も多彩です。',
      habitat: '中央アジア〜地中海沿岸原産',
      bloomingSeason: '4月〜5月',
      emoji: '🌷',
      category: PlantCategory.flower,
      characteristics: ['球根植物', '花色が豊富', '秋植え春咲き', '耐寒性が強い'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '耐寒性あり（-10℃まで）',
        tips: '10〜11月に球根を植え付けます。花後は球根を太らせるため葉を残しましょう。',
      ),
    ),
    Plant(
      id: 'hydrangea',
      name: 'アジサイ',
      scientificName: 'Hydrangea macrophylla',
      family: 'アジサイ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/92264365bd369cd78a49c765b27633fbb998b10c.png',
      description:
          '梅雨の季節を彩る日本原産の花木です。土壌の酸性度によって花の色が変化する'
          '不思議な性質を持っています。酸性土壌では青色、アルカリ性土壌ではピンク色になります。'
          '「七変化」の別名の通り、開花中にも色が移り変わります。',
      habitat: '日本原産',
      bloomingSeason: '6月〜7月',
      emoji: '💠',
      category: PlantCategory.flower,
      characteristics: ['土壌pHで花色変化', '耐陰性あり', '落葉低木', '日本原産'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.high,
        sunLevel: SunLevel.partialShade,
        difficulty: '初級',
        temperature: '耐寒性あり（-5℃まで）',
        tips: '水を好むので乾燥させないように。剪定は花後すぐに行います。',
      ),
    ),
    Plant(
      id: 'cosmos',
      name: 'コスモス',
      scientificName: 'Cosmos bipinnatus',
      family: 'キク科',
      description:
          '秋の風に揺れる姿が美しい一年草。別名「秋桜」とも呼ばれます。'
          'メキシコ原産ですが、日本の秋の風景にすっかり溶け込んでいます。'
          '細い茎に繊細な花を咲かせ、群生する姿は圧巻です。',
      habitat: 'メキシコ原産',
      bloomingSeason: '9月〜11月',
      emoji: '🌼',
      category: PlantCategory.flower,
      characteristics: ['一年草', '秋桜の別名', '繊細な花弁', 'こぼれ種で増える'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '10℃〜30℃',
        tips: 'やせ地でもよく育ちます。肥料を与えすぎると花つきが悪くなります。',
      ),
    ),

    // ===== 樹木 =====
    Plant(
      id: 'maple',
      name: 'モミジ（イロハモミジ）',
      scientificName: 'Acer palmatum',
      family: 'ムクロジ科',
      description:
          '日本の秋を代表する落葉高木。秋になると葉が鮮やかな赤や黄色に紅葉し、'
          '美しい景観を作り出します。古くから庭園や盆栽に利用され、'
          '日本の美意識を象徴する樹木の一つです。',
      habitat: '日本、朝鮮半島、中国',
      bloomingSeason: '紅葉：10月〜12月',
      emoji: '🍁',
      category: PlantCategory.tree,
      characteristics: ['落葉高木', '掌状の葉', '美しい紅葉', '盆栽向き'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.partialShade,
        difficulty: '中級',
        temperature: '耐寒性あり（-20℃まで）',
        tips: '西日を避けた半日陰が最適。乾燥すると葉焼けの原因になります。',
      ),
    ),
    Plant(
      id: 'ginkgo',
      name: 'イチョウ',
      scientificName: 'Ginkgo biloba',
      family: 'イチョウ科',
      description:
          '「生きた化石」と呼ばれる、約2億年前から存在する古代樹木です。'
          '秋の黄葉が美しく、街路樹として広く植えられています。'
          '雌雄異株で、雌株にはギンナン（銀杏）の実がなります。',
      habitat: '中国原産（世界中に植栽）',
      bloomingSeason: '黄葉：11月〜12月',
      emoji: '🍂',
      category: PlantCategory.tree,
      characteristics: ['落葉高木', '生きた化石', '扇形の葉', '雌雄異株'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '耐寒性・耐暑性ともに強い',
        tips: '非常に丈夫で街路樹に適しています。大きく育つので広いスペースが必要です。',
      ),
    ),
    Plant(
      id: 'pine',
      name: 'マツ（アカマツ）',
      scientificName: 'Pinus densiflora',
      family: 'マツ科',
      description:
          '日本の風景に欠かせない常緑針葉樹。正月の門松にも使われ、'
          '長寿や繁栄の象徴とされています。赤褐色の樹皮が特徴的で、'
          '日本庭園や盆栽の素材としても人気があります。',
      habitat: '日本、朝鮮半島、中国東北部',
      bloomingSeason: '4月〜5月（花粉飛散期）',
      emoji: '🌲',
      category: PlantCategory.tree,
      characteristics: ['常緑針葉樹', '赤褐色の樹皮', '松ぼっくり', '盆栽向き'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.fullSun,
        difficulty: '上級',
        temperature: '耐寒性あり',
        tips: '日当たりと水はけの良い場所を好みます。マツケムシなどの害虫に注意。',
      ),
    ),

    // ===== 多肉植物 =====
    Plant(
      id: 'echeveria',
      name: 'エケベリア',
      scientificName: 'Echeveria elegans',
      family: 'ベンケイソウ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/527cc1ce3116c2c9d133f18d0bab9a1f03b01616.png',
      description:
          'ロゼット状に広がる肉厚の葉が美しい多肉植物。メキシコ原産で、'
          '100種以上の原種と多数の園芸品種があります。'
          '葉の色は緑、ピンク、紫、白粉を帯びたものなど多彩です。',
      habitat: 'メキシコ、中央アメリカ',
      bloomingSeason: '春〜夏',
      emoji: '🪴',
      category: PlantCategory.succulent,
      characteristics: ['ロゼット型', '葉挿しで増殖可能', '多彩な葉色', '小型〜中型'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '5℃〜35℃',
        tips: '水やりは土が完全に乾いてから。蒸れに弱いので風通しを確保しましょう。',
      ),
    ),
    Plant(
      id: 'aloe',
      name: 'アロエ',
      scientificName: 'Aloe vera',
      family: 'ススキノキ科',
      description:
          '「医者いらず」の別名を持つ、薬用・美容で広く利用される多肉植物。'
          '葉の内部のゼリー状の部分には保湿成分が豊富に含まれ、'
          'やけどや肌荒れの民間療法に古くから使われてきました。',
      habitat: 'アラビア半島原産',
      bloomingSeason: '冬〜春',
      emoji: '🌵',
      category: PlantCategory.succulent,
      characteristics: ['薬用植物', 'ゼリー状の葉肉', '丈夫で育てやすい', '子株で増殖'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '5℃〜40℃',
        tips: '乾燥に強く、水やりは控えめに。冬は室内に取り込みましょう。',
      ),
    ),
    Plant(
      id: 'haworthia',
      name: 'ハオルチア',
      scientificName: 'Haworthia obtusa',
      family: 'ススキノキ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/f97a9e1da9619e3a6b5f63558494c185bc5306c1.png',
      description:
          '透明感のある葉先が光を通す「窓」を持つ、小型の多肉植物。'
          '南アフリカ原産で、自生地では体の大部分を土中に埋め、'
          '葉先の窓から光を取り込んで光合成を行う独自の戦略を持ちます。',
      habitat: '南アフリカ',
      bloomingSeason: '春〜夏',
      emoji: '💎',
      category: PlantCategory.succulent,
      characteristics: ['透明な葉先', '小型', '室内栽培向き', 'コレクション性が高い'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.partialShade,
        difficulty: '初級',
        temperature: '5℃〜30℃',
        tips: '直射日光は避け、明るい日陰で管理。他の多肉より水を好みます。',
      ),
    ),

    // ===== ハーブ =====
    Plant(
      id: 'basil',
      name: 'バジル',
      scientificName: 'Ocimum basilicum',
      family: 'シソ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/35411487bf8c2990c20119ceccd30f392b6f3a05.png',
      description:
          'イタリア料理に欠かせないハーブの代表格。甘くスパイシーな香りが特徴で、'
          'トマトとの相性が抜群です。和名は「メボウキ」。'
          '熱帯アジア原産の一年草で、暖かい季節に旺盛に成長します。',
      habitat: '熱帯アジア原産',
      bloomingSeason: '7月〜10月',
      emoji: '🌿',
      category: PlantCategory.herb,
      characteristics: ['一年草', '芳香性', '料理用ハーブ', '摘心で分枝促進'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '15℃〜30℃',
        tips: '摘心すると脇芽が増えてこんもり育ちます。花が咲くと葉が硬くなるので早めに摘み取りましょう。',
      ),
    ),
    Plant(
      id: 'lavender',
      name: 'ラベンダー',
      scientificName: 'Lavandula angustifolia',
      family: 'シソ科',
      description:
          '優雅な紫色の花穂と心地よい香りで「ハーブの女王」と呼ばれます。'
          '地中海沿岸原産で、アロマテラピーやポプリ、料理など幅広く利用されます。'
          'リラックス効果のある香りは安眠にも効果的とされています。',
      habitat: '地中海沿岸原産',
      bloomingSeason: '6月〜7月',
      emoji: '💜',
      category: PlantCategory.herb,
      characteristics: ['多年草', 'リラックス効果', '紫色の花穂', '乾燥に強い'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.fullSun,
        difficulty: '中級',
        temperature: '耐寒性あり（品種による）',
        tips: '高温多湿が苦手。梅雨前に刈り込んで風通しを良くしましょう。',
      ),
    ),
    Plant(
      id: 'mint',
      name: 'ミント',
      scientificName: 'Mentha × piperita',
      family: 'シソ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/dea9e55c996e2baa691440e31070731d29609c91.png',
      description:
          'スーッとする爽やかな香りが特徴の多年草ハーブ。料理、飲料、アロマなど'
          '用途は幅広く、最も身近なハーブの一つです。'
          '繁殖力が非常に強く、地下茎で旺盛に広がります。',
      habitat: 'ヨーロッパ原産',
      bloomingSeason: '7月〜9月',
      emoji: '🍃',
      category: PlantCategory.herb,
      characteristics: ['多年草', '爽やかな香り', '繁殖力旺盛', '地下茎で広がる'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.high,
        sunLevel: SunLevel.partialShade,
        difficulty: '初級',
        temperature: '耐寒性あり（-15℃まで）',
        tips: '鉢植え推奨。地植えにすると広がりすぎるので注意。水切れに弱いです。',
      ),
    ),
    Plant(
      id: 'rosemary',
      name: 'ローズマリー',
      scientificName: 'Salvia rosmarinus',
      family: 'シソ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/482d9e572fd8b34c0ac654c1afaa7f4d4d07421f.png',
      description:
          '清々しい強い香りを持つ常緑低木のハーブ。肉料理の臭み消しに重宝され、'
          '記憶力を高める効果があるとされ「記憶のハーブ」とも呼ばれます。'
          '小さな青紫色の花も美しく、観賞用としても人気です。',
      habitat: '地中海沿岸原産',
      bloomingSeason: '11月〜5月',
      emoji: '🫒',
      category: PlantCategory.herb,
      characteristics: ['常緑低木', '強い香り', '記憶のハーブ', '乾燥に強い'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.low,
        sunLevel: SunLevel.fullSun,
        difficulty: '初級',
        temperature: '耐寒性あり（-5℃まで）',
        tips: '水はけの良い土で乾燥気味に管理。剪定しながら収穫しましょう。',
      ),
    ),

    // ===== シダ植物 =====
    Plant(
      id: 'boston_fern',
      name: 'ボストンファーン',
      scientificName: 'Nephrolepis exaltata',
      family: 'シノブ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/08861d4d466e400e5fa13d4fc753b621d9328f9d.png',
      description:
          '優雅に垂れ下がる葉が美しい、室内観葉植物として人気のシダ植物。'
          'NASAの空気清浄研究でも効果が認められ、'
          'ホルムアルデヒドなどの有害物質を吸着する能力があります。',
      habitat: '熱帯・亜熱帯地域',
      bloomingSeason: '（シダ植物のため花は咲きません）',
      emoji: '🌿',
      category: PlantCategory.fern,
      characteristics: ['常緑多年草', '空気清浄効果', '吊り鉢向き', '胞子で繁殖'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.high,
        sunLevel: SunLevel.shade,
        difficulty: '中級',
        temperature: '10℃〜25℃',
        tips: '湿度を好むので葉水を頻繁に。直射日光は避け、明るい日陰で管理します。',
      ),
    ),
    Plant(
      id: 'adiantum',
      name: 'アジアンタム',
      scientificName: 'Adiantum raddianum',
      family: 'イノモトソウ科',
      description:
          '繊細で小さな扇形の葉が密集する、美しいシダ植物。'
          '黒い細い茎に透き通るような薄い葉をつける姿は非常に優美です。'
          '浴室やキッチンなど湿度の高い場所でも元気に育ちます。',
      habitat: '世界の熱帯・亜熱帯地域',
      bloomingSeason: '（シダ植物のため花は咲きません）',
      emoji: '🍀',
      category: PlantCategory.fern,
      characteristics: ['繊細な葉', '高湿度を好む', '耐陰性', '浴室にも向く'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.high,
        sunLevel: SunLevel.shade,
        difficulty: '中級〜上級',
        temperature: '10℃〜25℃',
        tips: '乾燥は大敵！葉水を毎日行い、土も乾かさないように管理しましょう。',
      ),
    ),

    // ===== 草本 =====
    Plant(
      id: 'monstera',
      name: 'モンステラ',
      scientificName: 'Monstera deliciosa',
      family: 'サトイモ科',
      imageUrl:
          'https://api.plantphotoai.com/storage/v1/object/public/images/b4bd2fe96fe662fb6de43f5624cebeb163939efe.png',
      description:
          '大きな切れ込みの入った葉が印象的な、人気の観葉植物。'
          '中央アメリカの熱帯雨林原産で、自生地では大木に絡みついて成長します。'
          'インテリアグリーンの定番で、おしゃれな空間づくりに欠かせません。',
      habitat: '中央アメリカの熱帯雨林',
      bloomingSeason: '（室内では稀に開花）',
      emoji: '🪴',
      category: PlantCategory.grass,
      characteristics: ['つる性', '切れ込みのある大葉', '耐陰性', '気根を出す'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.partialShade,
        difficulty: '初級',
        temperature: '10℃〜30℃',
        tips: '明るい日陰が最適。葉が大きくなるので支柱を立てましょう。',
      ),
    ),
    Plant(
      id: 'bamboo',
      name: 'タケ（マダケ）',
      scientificName: 'Phyllostachys bambusoides',
      family: 'イネ科',
      description:
          '日本の風景に欠かせないイネ科の常緑大型植物。'
          '驚異的な成長速度を持ち、1日に最大1m以上伸びることもあります。'
          '建材、食材（タケノコ）、工芸品など多用途に利用されます。',
      habitat: '中国原産（日本に帰化）',
      bloomingSeason: '60〜120年に一度',
      emoji: '🎋',
      category: PlantCategory.grass,
      characteristics: ['常緑', '驚異的な成長速度', 'タケノコが食用', '地下茎で繁殖'],
      careInfo: CareInfo(
        waterLevel: WaterLevel.medium,
        sunLevel: SunLevel.fullSun,
        difficulty: '中級',
        temperature: '耐寒性あり',
        tips: '地下茎の広がりを抑えるため、根止めシートの設置を推奨します。',
      ),
    ),
  ];

  /// カテゴリ別にフィルタリング
  static List<Plant> getByCategory(PlantCategory category) {
    return allPlants.where((p) => p.category == category).toList();
  }

  /// 名前で検索
  static List<Plant> search(String query) {
    final lowerQuery = query.toLowerCase();
    return allPlants.where((p) {
      return p.name.toLowerCase().contains(lowerQuery) ||
          p.scientificName.toLowerCase().contains(lowerQuery) ||
          p.family.toLowerCase().contains(lowerQuery) ||
          p.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
