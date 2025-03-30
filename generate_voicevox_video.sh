#!/bin/bash

# スクリプトのディレクトリを取得
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# 話者IDを設定（10=玄野武宏、16=青山龍星など）
# MacOS用のsed構文
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/SPEAKER_ID = [0-9]\+/SPEAKER_ID = 10/" "$SCRIPT_DIR/main_loop_fixed.py"
else
  # Linux用のsed構文
  sed -i "s/SPEAKER_ID = [0-9]\+/SPEAKER_ID = 10/" "$SCRIPT_DIR/main_loop_fixed.py"
fi

# 出力ファイル名
output_file="$SCRIPT_DIR/output_$(date +%Y%m%d_%H%M%S).mp4"

# 入力ファイル（指定がなければデフォルト）
input_file="$SCRIPT_DIR/script.txt"
if [ -n "$1" ]; then
  input_file="$1"
fi

# 背景動画（指定がある場合）
background_video=""
if [ -n "$2" ]; then
  background_video="$2"
  # 実行
  python3 "$SCRIPT_DIR/main_loop_fixed.py" "$input_file" "$output_file" "$background_video"
else
  # 背景動画なしで実行
  python3 "$SCRIPT_DIR/main_loop_fixed.py" "$input_file" "$output_file"
fi

echo "処理が完了しました。出力ファイル: $output_file"