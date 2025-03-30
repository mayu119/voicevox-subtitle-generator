# VOICEVOX 字幕付き音声動画生成ツール

このツールは、テキスト台本をVOICEVOXで音声合成し、その読み上げ時間に合わせて動的な字幕を表示する動画を生成します。

## 機能

- テキストファイルから行単位で音声合成
- 音声の長さに完全に合わせた字幕タイミング自動生成
- スタイリッシュな字幕表示（フォントサイズ・色・位置などカスタマイズ可能）
- 任意の背景動画への字幕追加（または黒背景での生成）
- 長い台本からでも簡単に一括処理

## 必要なもの

- Python 3.6以上
- FFmpeg (コマンドラインから実行可能な状態)
- VOICEVOX Engine (ローカルで起動する必要があります)

## セットアップ

1. このリポジトリをクローン
   ```bash
   git clone https://github.com/mayu119/voicevox-subtitle-generator.git
   cd voicevox-subtitle-generator
   ```

2. 必要なPythonパッケージをインストール
   ```bash
   pip install requests
   ```

3. [VOICEVOX](https://voicevox.hiroshiba.jp/)をダウンロードしてインストール

4. [FFmpeg](https://ffmpeg.org/download.html)をインストール

## 使い方

### 基本的な使い方

1. VOICEVOX Engineを起動する

2. 台本を作成する (例: `script.txt`)
   - 1行ごとに字幕として表示したいテキストを記述します

3. スクリプトを実行する
   ```bash
   python main_loop_fixed.py script.txt output.mp4
   ```

### シェルスクリプトを使った実行例

```bash
#!/bin/bash

# 話者IDを設定
sed -i '' "s/SPEAKER_ID = [0-9]\+/SPEAKER_ID = 10/" main_loop_fixed.py

# 出力ファイル名
output_file="output_$(date +%Y%m%d_%H%M%S).mp4"

# 実行
python3 main_loop_fixed.py script.txt "$output_file"

echo "処理が完了しました。出力ファイル: $output_file"
```

### 背景動画付きの実行例

```bash
python main_loop_fixed.py script.txt output.mp4 background.mp4
```

## 設定カスタマイズ

`main_loop_fixed.py`の冒頭部分で以下の設定をカスタマイズできます：

```python
# VoiceVox関連の設定
VOICEVOX_URL = "http://localhost:50021"  # VoiceVoxのデフォルトURL
SPEAKER_ID = 10  # 話者ID

# FFmpeg関連の設定
FONT_SIZE = 28  # 字幕サイズ
FONT_COLOR = "white"  # 字幕の色
MARGIN_BOTTOM = 60  # 画面下端からの余白
```

## 主なVOICEVOX話者ID

- 0: 四国めたん（ノーマル）
- 1: ずんだもん（ノーマル）
- 2: 四国めたん（あまあま）
- 3: ずんだもん（あまあま）
- 4: 春日部つむぎ（ノーマル）
- 10: 玄野武宏（ノーマル）
- 11: 白上虎太郎（ノーマル）
- 16: 青山龍星（ノーマル）

詳細は[VOICEVOXのドキュメント](https://github.com/VOICEVOX/voicevox_engine/blob/master/docs/api.md)を参照してください。

## 字幕と音声の同期について

話者IDによって読み上げ速度が異なるため、字幕と音声のずれが生じる場合があります。問題が発生した場合は、以下の対処法を試してください：

1. 話者の変更（ID 10, 16など異なる話者を試す）
2. FFmpegの同期パラメータの調整（詳細は`create_video`メソッド参照）

## 注意点

- VOICEVOX Engineが起動していない場合、エラーが発生します
- 長い台本の処理には時間がかかる場合があります
- 一時ファイルは自動削除されません（デバッグ用）

## ライセンス

MITライセンス