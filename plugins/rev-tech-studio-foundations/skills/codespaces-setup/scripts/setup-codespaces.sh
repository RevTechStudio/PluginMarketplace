#!/bin/bash

set -e  # エラーが発生したら停止

echo "Codespace初期設定スクリプトを開始します..."
echo ""

read -p "初期設定を実行しますか？ (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "処理を中断しました"
    exit 0
fi

# スキルディレクトリのパス
SKILL_DIR="./rev-tech-studio-foundations/skills/setup-codespaces-config"

# テンプレートファイルの存在確認
echo "テンプレートファイルを確認中..."

REQUIRED_TEMPLATES=(
    "$SKILL_DIR/templates/devcontainer.json"
    "$SKILL_DIR/templates/dependabot.yml"
    "$SKILL_DIR/templates/.markdownlint-cli2.jsonc"
)

MISSING_TEMPLATES=()

for template in "${REQUIRED_TEMPLATES[@]}"; do
    if [ ! -f "$template" ]; then
        MISSING_TEMPLATES+=("$template")
        echo "❌ $template が見つかりません"
    else
        echo "✓ $template が見つかりました"
    fi
done

# テンプレートが1つでもない場合は中止
if [ ${#MISSING_TEMPLATES[@]} -gt 0 ]; then
    echo ""
    echo "❌ 必要なテンプレートファイルが不足しています"
    echo "処理を中止します"
    exit 1
fi

echo "✓ すべてのテンプレートファイルが見つかりました"
echo ""

# 既存ファイルのチェック
DEVCONTAINER_EXISTS=false
DEPENDABOT_EXISTS=false
MARKDOWNLINT_EXISTS=false

if [ -f ".devcontainer/devcontainer.json" ]; then
    DEVCONTAINER_EXISTS=true
    echo "⚠️  .devcontainer/devcontainer.json が既に存在します"
fi

if [ -f ".github/dependabot.yml" ]; then
    DEPENDABOT_EXISTS=true
    echo "⚠️  .github/dependabot.yml が既に存在します"
fi

if [ -f ".markdownlint-cli2.jsonc" ]; then
    MARKDOWNLINT_EXISTS=true
    echo "⚠️  .markdownlint-cli2.jsonc が既に存在します"
fi

# 既存ファイルがある場合は確認
if [ "$DEVCONTAINER_EXISTS" = true ] || [ "$DEPENDABOT_EXISTS" = true ] || [ "$MARKDOWNLINT_EXISTS" = true ]; then
    echo ""
    read -p "既存のファイルを上書きしますか? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "処理を中断しました"
        exit 0
    fi
fi

# ディレクトリの作成
mkdir -p .devcontainer .github

# テンプレートファイルのコピー
echo ""
echo "ファイルをコピー中..."
cp "$SKILL_DIR/templates/devcontainer.json" .devcontainer/
echo "✓ .devcontainer/devcontainer.json をコピーしました"

cp "$SKILL_DIR/templates/dependabot.yml" .github/
echo "✓ .github/dependabot.yml をコピーしました"

cp "$SKILL_DIR/templates/.markdownlint-cli2.jsonc" .
echo "✓ .markdownlint-cli2.jsonc をコピーしました"

echo ""
echo "🎉 すべてのファイルのセットアップが完了しました"
echo ""
echo "次のステップ:"
echo "1. VS Codeのコマンドパレット (Ctrl+Shift+P / Cmd+Shift+P) を開く"
echo "2. 'Codespaces: Rebuild Container' を実行"
