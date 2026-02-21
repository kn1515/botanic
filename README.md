# botanic

Flutter 製の植物図鑑 & 発見マップアプリです。さまざまな植物の情報を閲覧したり、地図上に植物の発見記録を登録したりできます。

## 主な機能

### 植物図鑑

- 花・樹木・多肉植物・ハーブ・シダ植物・草本の 6 カテゴリで植物を一覧表示
- カテゴリフィルターや名前・学名での検索に対応
- 各植物の詳細画面では学名・科名・生息地・開花時期・特徴・お手入れガイドを確認可能

### 発見マップ

- OpenStreetMap ベースの地図上に植物の目撃記録をピン登録
- 現在地取得に対応し、GPS の位置情報から素早く登録可能
- マーカーをタップして記録の詳細確認・削除が可能
- メモ付きで記録を残せる

## 技術スタック

| カテゴリ | ライブラリ |
| --- | --- |
| フレームワーク | Flutter (Dart ^3.11.0) |
| 状態管理 | Riverpod (`flutter_riverpod`, `riverpod_annotation`) |
| 地図 | `flutter_map` + `latlong2` |
| 位置情報 | `geolocator` |
| コード生成 | `freezed`, `json_serializable`, `build_runner` |
| ローカルDB | ObjectBox |
| HTTP | Dio |
| その他 | `go_router`, `flutter_secure_storage`, `cached_network_image`, `flutter_dotenv` など |

## ディレクトリ構成

```
lib/
├── main.dart              # エントリポイント
├── data/
│   └── plant_data.dart    # サンプル植物データ
├── models/
│   ├── plant.dart         # 植物データモデル
│   └── plant_sighting.dart # 目撃記録モデル
├── providers/
│   ├── plant_providers.dart    # 図鑑の状態管理
│   └── sighting_providers.dart # 目撃記録の状態管理
├── screens/
│   ├── home_screen.dart          # ホーム (BottomNav)
│   ├── plant_list_screen.dart    # 植物一覧
│   ├── plant_detail_screen.dart  # 植物詳細
│   ├── map_screen.dart           # 発見マップ
│   └── add_sighting_screen.dart  # 目撃登録
└── widgets/
    ├── plant_card.dart      # 植物カード
    └── category_filter.dart # カテゴリフィルター
```

## セットアップ

```bash
# 依存パッケージのインストール
flutter pub get

# コード生成（freezed / json_serializable / objectbox）
dart run build_runner build --delete-conflicting-outputs

# 静的解析
flutter analyze
```

## 起動方法

### Web

```bash
# デバッグモードで起動（Chrome が自動で開きます）
flutter run -d chrome

# ポートを指定してサーバーモードで起動する場合
flutter run -d web-server --web-port=8080

# リリースビルドを生成する場合
flutter build web
# 成果物は build/web/ に出力されます
```

### iOS

> 前提: macOS + Xcode がインストール済みであること

```bash
# シミュレータで起動
flutter run -d ios

# 特定のシミュレータを指定する場合（利用可能なデバイス一覧を確認）
flutter devices
flutter run -d "iPhone 16 Pro"

# 実機で起動（Apple Developer アカウント & プロビジョニングプロファイルが必要）
flutter run -d <実機デバイスID> --release
```

初回は `ios/Runner.xcworkspace` を Xcode で開き、Signing & Capabilities でチーム（Apple Developer アカウント）を設定してください。

### Android

> 前提: Android Studio + Android SDK がインストール済みであること

```bash
# エミュレータで起動
flutter run -d android

# 利用可能なデバイス一覧を確認
flutter devices

# 特定のエミュレータ／実機を指定する場合
flutter run -d <デバイスID>

# リリース APK をビルドする場合
flutter build apk

# App Bundle（Google Play 配布用）をビルドする場合
flutter build appbundle
```

実機で起動する場合は、端末側で **USB デバッグ** を有効にしてください。

## 動作環境

- Flutter SDK ^3.11.0
- Android / iOS / Web / Linux / macOS / Windows
