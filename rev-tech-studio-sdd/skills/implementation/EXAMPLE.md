# Implementation Skill - 使用例

このドキュメントでは、`implementation`スキルの典型的な使用シナリオと期待される出力例を示します。

## シナリオ1: Webアプリケーションの実装（タスクベース）

### ユーザーからの依頼

```
タスク計画書（.spec/task-plan.md）に基づいて、読書記録アプリのバックエンドAPIの実装を開始してください。フェーズ1（基盤実装）から始めます。
```

### 実施内容

1. **タスク計画書の確認**
   - フェーズ1: 基盤実装（T001〜T007）
   - 最初のタスク: T001（Userエンティティの定義）
   - 見積もり: 2時間
   - 前提タスク: なし

2. **タスクT001の実装（Userエンティティの定義）**
   - コンポーネントの実装: `Models/User.cs`を作成
   - テストの実装: 不要（エンティティのみ）
   - 品質チェック: Linter、Formatter実行
   - Git運用: コミット（T001完了）

3. **タスクT002の実装（Bookエンティティの定義）**
   - コンポーネントの実装: `Models/Book.cs`を作成
   - Git運用: コミット（T002完了）

4. **タスクT003の実装（ReadingRecordエンティティの定義）**
   - コンポーネントの実装: `Models/ReadingRecord.cs`を作成
   - Git運用: コミット（T003完了）

5. **タスクT004の実装（ApplicationDbContextの実装）**
   - コンポーネントの実装: `Data/ApplicationDbContext.cs`を作成
   - 依存関係: T001、T002、T003が完了済み
   - Git運用: コミット（T004完了）

6. **タスクT005の実装（マイグレーションの作成）**
   - コンポーネントの実装: `dotnet ef migrations add InitialCreate`実行
   - 依存関係: T004が完了済み
   - Git運用: コミット（T005完了）

### 期待される出力

#### 実装コード例（タスクT001）

**Models/User.cs**
```csharp
namespace ReadingTrackerApi.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }
}
```

#### タスク進捗の記録

```markdown
## タスク進捗

- [x] T001: Userエンティティの定義 - 完了（2時間）
- [x] T002: Bookエンティティの定義 - 完了（2時間）
- [x] T003: ReadingRecordエンティティの定義 - 完了（2時間）
- [x] T004: ApplicationDbContextの実装 - 完了（3時間）
- [x] T005: マイグレーションの作成 - 完了（1時間）
- [ ] T006: リポジトリインターフェースの定義 - 次のタスク
- [ ] T007: 汎用リポジトリの実装 - 未着手
```

#### 実装レポート（フェーズ1完了時）

```markdown
# 実装レポート - フェーズ1（基盤実装）

## 実装サマリー

読書記録アプリのバックエンドAPIの基盤実装（データモデル、DbContext、リポジトリ基盤）を完了しました。

## 実装内容

### 完了タスク

- **T001**: Userエンティティの定義（2h）
- **T002**: Bookエンティティの定義（2h）
- **T003**: ReadingRecordエンティティの定義（2h）
- **T004**: ApplicationDbContextの実装（3h）
- **T005**: マイグレーションの作成（1h）
- **T006**: リポジトリインターフェースの定義（3h）
- **T007**: 汎用リポジトリの実装（3h）

**総作業時間**: 16時間（見積もり: 16時間）

### 実装したファイル

- `Models/User.cs`: ユーザーエンティティ
- `Models/Book.cs`: 書籍エンティティ
- `Models/ReadingRecord.cs`: 読書記録エンティティ
- `Data/ApplicationDbContext.cs`: EF Core DbContext
- `Migrations/*.cs`: 初期マイグレーション
- `Repositories/IRepository.cs`: 汎用リポジトリインターフェース
- `Repositories/Repository.cs`: 汎用リポジトリ実装

## テスト結果

- **ビルド**: 成功
- **ユニットテスト**: 0件（エンティティとインフラ層のため）

## 品質チェック結果

- **Linter**: エラー0件、警告0件
- **Formatter**: フォーマット済み
- **ビルド**: 成功

## 次のタスク

**フェーズ2: コア機能実装（P1）**
- T008: UserRepositoryの実装
- T009: IUserServiceインターフェース定義
- T010: UserServiceの実装
- ...
```

---

## シナリオ2: CLIツールの実装（単一タスク）

### ユーザーからの依頼

```
タスク計画書に基づいて、タスクT002（MarkdownParserクラス実装）を実装してください。
```

### 実施内容

1. **タスク計画書の確認**
   - タスクID: T002
   - タスク名: MarkdownParserクラス実装
   - 説明: Markdown解析機能を実装する
   - 成果物: `markdown_linter/parser.py`
   - 見積もり: 6時間
   - 依存関係: T001（MarkdownNodeクラス定義）が完了済み

2. **コンポーネントの実装**
   - `markdown_linter/parser.py`を実装
   - `MarkdownParser`クラスを作成
   - `parse()`メソッドを実装
   - 見出し、リスト、コードブロック、リンクの解析

3. **テストの実装**
   - `tests/test_parser.py`を作成
   - 見出し解析のテスト
   - リスト解析のテスト
   - コードブロック解析のテスト
   - エッジケースのテスト

4. **品質チェックの実施**
   - `ruff check .` → エラー0件
   - `black .` → フォーマット済み
   - `pytest` → 10件すべて成功

5. **Git運用**
   - `git add markdown_linter/parser.py tests/test_parser.py`
   - `git commit -m "feat: Markdownパーサークラスを実装"`

### 期待される出力

#### 実装コード例

**markdown_linter/parser.py**
```python
from typing import List
from dataclasses import dataclass
from .node import MarkdownNode

class MarkdownParser:
    def parse(self, content: str) -> List[MarkdownNode]:
        """Markdownコンテンツを解析してノードリストを返す"""
        nodes = []
        lines = content.split('\n')

        for i, line in enumerate(lines, start=1):
            node = self._parse_line(line, i)
            if node:
                nodes.append(node)

        return nodes

    def _parse_line(self, line: str, line_number: int) -> MarkdownNode | None:
        # 見出しの解析
        if line.startswith('#'):
            level = len(line) - len(line.lstrip('#'))
            content = line.lstrip('#').strip()
            return MarkdownNode('heading', content, line_number, level=level)

        # コードブロックの解析
        if line.startswith('```'):
            language = line[3:].strip()
            return MarkdownNode('code_block', '', line_number, language=language)

        # その他の要素の解析...
        return None
```

**tests/test_parser.py**
```python
import pytest
from markdown_linter.parser import MarkdownParser

def test_parse_heading():
    parser = MarkdownParser()
    content = "# Title"
    nodes = parser.parse(content)

    assert len(nodes) == 1
    assert nodes[0].type == 'heading'
    assert nodes[0].content == 'Title'
    assert nodes[0].level == 1

def test_parse_code_block():
    parser = MarkdownParser()
    content = "```python"
    nodes = parser.parse(content)

    assert len(nodes) == 1
    assert nodes[0].type == 'code_block'
    assert nodes[0].language == 'python'

# その他のテスト...
```

#### タスク完了報告

```markdown
## タスクT002完了報告

- **タスクID**: T002
- **タスク名**: MarkdownParserクラス実装
- **実際の作業時間**: 6時間（見積もり: 6時間）
- **成果物**: `markdown_linter/parser.py`、`tests/test_parser.py`
- **テスト結果**: 10件すべて成功
- **品質チェック**: すべて成功

**次のタスク**: T003（Parserユニットテスト追加）
```

---

## シナリオ3: ライブラリ機能の実装（複数タスクの並行実装）

### ユーザーからの依頼

```
タスク計画書に基づいて、T005〜T007（各Transformerの実装）を実装してください。これらは並行開発可能です。
```

### 実施内容

1. **タスク計画書の確認**
   - T005: HeadingStructureRule実装（4時間）
   - T006: LinkValidityRule実装（4時間）
   - T007: CodeBlockRule実装（4時間）
   - 依存関係: すべてT004（Ruleインターフェース定義）に依存
   - 並行開発可能: T005、T006、T007は独立

2. **タスクT005の実装（HeadingStructureRule）**
   - コンポーネントの実装: `src/rules/HeadingStructureRule.ts`
   - テストの実装: `tests/rules/HeadingStructureRule.test.ts`
   - 品質チェック: ESLint、Prettier、テスト実行
   - Git運用: コミット（T005完了）

3. **タスクT006の実装（LinkValidityRule）**
   - コンポーネントの実装: `src/rules/LinkValidityRule.ts`
   - テストの実装: `tests/rules/LinkValidityRule.test.ts`
   - Git運用: コミット（T006完了）

4. **タスクT007の実装（CodeBlockRule）**
   - コンポーネントの実装: `src/rules/CodeBlockRule.ts`
   - テストの実装: `tests/rules/CodeBlockRule.test.ts`
   - Git運用: コミット（T007完了）

### 期待される出力

#### 並行開発の実施

```markdown
## 並行開発タスク（T005〜T007）

**開始日時**: 2024-01-15 09:00

### T005: HeadingStructureRule実装
- 開始: 09:00
- 実装完了: 11:30
- テスト完了: 12:00
- コミット: 12:00

### T006: LinkValidityRule実装
- 開始: 09:00
- 実装完了: 11:30
- テスト完了: 12:00
- コミット: 12:00

### T007: CodeBlockRule実装
- 開始: 09:00
- 実装完了: 11:30
- テスト完了: 12:00
- コミット: 12:00

**総作業時間**: 4時間（並行開発により効率化）
**見積もり**: 12時間（並行開発により8時間短縮）
```

---

## まとめ

`implementation`スキルは、タスク計画書に基づいてコードを実装するプロセスを体系的に支援します。

**主な特徴:**
- タスク計画書に従った順序立てた実装
- 各タスクごとの完了確認と進捗記録
- coding-conventions、branch-commit-conventions、document-conventionsに準拠した実装
- テスト駆動の品質保証

**前工程との連携:**
`task-planning`スキルでタスク計画を作成した後、このスキルでタスクを順次実装します。

**次のフェーズ:**
すべてのタスク完了後は、`checking-contradictions`スキルでプロジェクト全体の一貫性を検証します。
