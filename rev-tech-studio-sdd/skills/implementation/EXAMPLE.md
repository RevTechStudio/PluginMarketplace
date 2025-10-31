# Implementation Skill - 使用例

このドキュメントでは、`implementation`スキルの典型的な使用シナリオと期待される出力例を示します。

## シナリオ1: Webアプリケーションの実装

### ユーザーからの依頼

```
詳細設計書（.spec/detailed-design.md）に基づいて、読書記録アプリのバックエンドAPIを実装してください。
```

### 実施内容

1. **詳細設計書の確認**
   - 技術スタック: ASP.NET Core Web API、Entity Framework Core、SQLite
   - システムアーキテクチャ: レイヤードアーキテクチャ（Controller、Service、Repository）
   - データベース設計: Users、Books、ReadingRecordsテーブル
   - API設計: RESTful API（CRUD操作）

2. **開発環境の確認**
   - .NET 8.0 SDKの確認
   - NuGetパッケージのインストール確認
   - ビルドの動作確認

3. **実装計画の作成**
   - フェーズ1: データモデル、DbContext、Repository実装
   - フェーズ2: Serviceクラス、ビジネスロジック実装
   - フェーズ3: Controller、APIエンドポイント実装

4. **コンポーネントの実装**
   - `Models/User.cs`、`Models/Book.cs`、`Models/ReadingRecord.cs`を実装
   - `Data/ApplicationDbContext.cs`を実装
   - `Repositories/IUserRepository.cs`、`Repositories/UserRepository.cs`を実装
   - `Services/IUserService.cs`、`Services/UserService.cs`を実装
   - `Controllers/UsersController.cs`を実装

5. **テストの実装**
   - `UserServiceTests.cs`: ユニットテスト（正常系、異常系）
   - `UsersControllerTests.cs`: コントローラーのテスト

6. **品質チェックの実施**
   - Linter実行: `dotnet format --verify-no-changes`
   - テスト実行: `dotnet test` → すべて成功

7. **ドキュメントの更新**
   - `README.md`: セットアップ手順、API使用方法を追加
   - `docs/api-spec.md`: 実装したAPIエンドポイントを記載

8. **実装レポートの作成**
   - `.spec/implementation-report.md`を作成

9. **Git運用**
   - `git add .`
   - `git commit -m "feat: ユーザー管理APIを実装"`
   - `git push origin feature/user-management`

### 期待される出力

#### 実装コード例（一部）

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

**Services/UserService.cs**
```csharp
namespace ReadingTrackerApi.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<User?> GetUserByIdAsync(int id)
        {
            return await _userRepository.GetByIdAsync(id);
        }

        // その他のメソッド実装...
    }
}
```

#### 実装レポート

```markdown
# 実装レポート

## 実装サマリー

読書記録アプリのバックエンドAPIを実装しました。ユーザー管理機能（CRUD操作）を含む、P1機能の実装を完了しました。

## 実装内容

### 実装したファイル

- `Models/User.cs`: ユーザーエンティティ
- `Data/ApplicationDbContext.cs`: EF Core DbContext
- `Repositories/IUserRepository.cs`: リポジトリインターフェース
- `Repositories/UserRepository.cs`: リポジトリ実装
- `Services/IUserService.cs`: サービスインターフェース
- `Services/UserService.cs`: ビジネスロジック実装
- `Controllers/UsersController.cs`: APIコントローラー

### 実装したAPI

- `GET /api/users`: ユーザー一覧取得
- `GET /api/users/{id}`: ユーザー詳細取得
- `POST /api/users`: ユーザー作成
- `PUT /api/users/{id}`: ユーザー更新
- `DELETE /api/users/{id}`: ユーザー削除

## テスト結果

- **ユニットテスト**: 15件 → すべて成功
- **統合テスト**: 5件 → すべて成功
- **カバレッジ**: 85%

## 品質チェック結果

- **Linter**: エラー0件、警告0件
- **Formatter**: フォーマット済み
- **ビルド**: 成功

## 残課題

- [ ] P2機能（読書記録管理）の実装
- [ ] P3機能（読書統計）の実装

## 次のステップ

1. P2機能の実装を開始する
2. APIドキュメントをSwaggerで自動生成する
3. checking-contradictionsスキルで一貫性を検証する
```

---

## シナリオ2: CLIツールの実装

### ユーザーからの依頼

```
詳細設計書に基づいて、Markdownファイルのlintツールを実装してください。Python実装です。
```

### 実施内容

1. **詳細設計書の確認**
   - 技術スタック: Python 3.11、Click（CLIフレームワーク）
   - システムアーキテクチャ: Parser、Validator、Reporter
   - 入力: Markdownファイルパス
   - 出力: lint結果（エラー、警告）

2. **開発環境の確認**
   - Python 3.11の確認
   - `requirements.txt`のインストール確認
   - `pytest`の動作確認

3. **実装計画の作成**
   - フェーズ1: Parserクラス（Markdown解析）
   - フェーズ2: Validatorクラス（ルール検証）
   - フェーズ3: Reporterクラス（結果出力）
   - フェーズ4: CLIエントリーポイント

4. **コンポーネントの実装**
   - `markdown_linter/parser.py`: Markdown解析
   - `markdown_linter/validator.py`: ルール検証
   - `markdown_linter/reporter.py`: 結果出力
   - `markdown_linter/cli.py`: CLIエントリーポイント

5. **テストの実装**
   - `tests/test_parser.py`: パーサーのテスト
   - `tests/test_validator.py`: バリデーターのテスト
   - `tests/test_reporter.py`: レポーターのテスト

6. **品質チェックの実施**
   - Linter実行: `ruff check .` → エラー0件
   - Formatter実行: `black .` → フォーマット済み
   - テスト実行: `pytest` → すべて成功

7. **ドキュメントの更新**
   - `README.md`: インストール手順、使用方法を追加
   - `docs/rules.md`: 検証ルールの詳細を記載

8. **実装レポートの作成**
   - `.spec/implementation-report.md`を作成

9. **Git運用**
   - `git add .`
   - `git commit -m "feat: Markdownパーサーとバリデーターを実装"`
   - `git push origin feature/core-implementation`

### 期待される出力

#### 実装コード例（一部）

**markdown_linter/parser.py**
```python
from typing import List
from dataclasses import dataclass

@dataclass
class MarkdownNode:
    type: str
    content: str
    line_number: int

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
            return MarkdownNode('heading', line, line_number)
        # その他の要素の解析...
        return None
```

#### 実装レポート

```markdown
# 実装レポート

## 実装サマリー

MarkdownファイルのlintツールのコアロジックとCLIインターフェースを実装しました。

## 実装内容

### 実装したファイル

- `markdown_linter/parser.py`: Markdown解析機能
- `markdown_linter/validator.py`: ルール検証機能
- `markdown_linter/reporter.py`: 結果出力機能
- `markdown_linter/cli.py`: CLIエントリーポイント
- `markdown_linter/rules/`: 検証ルール（5種類）

### 実装したルール

1. `HeadingStructureRule`: 見出し階層の検証
2. `LinkValidityRule`: リンクの有効性検証
3. `CodeBlockRule`: コードブロックの言語指定検証
4. `ListIndentationRule`: リストのインデント検証
5. `TrailingWhitespaceRule`: 行末の空白検証

## テスト結果

- **ユニットテスト**: 32件 → すべて成功
- **カバレッジ**: 92%

## 品質チェック結果

- **Ruff**: エラー0件、警告0件
- **Black**: フォーマット済み
- **Mypy**: 型チェック成功

## 残課題

- [ ] 設定ファイル（.markdownlintrc）のサポート
- [ ] CI/CDパイプラインの設定

## 次のステップ

1. 設定ファイルのサポートを実装する
2. パフォーマンステストを実施する
3. checking-contradictionsスキルで一貫性を検証する
```

---

## シナリオ3: ライブラリ機能の実装

### ユーザーからの依頼

```
詳細設計書（.spec/detailed-design.md）に基づいて、データ変換ライブラリのコア機能を実装してください。TypeScript実装です。
```

### 実施内容

1. **詳細設計書の確認**
   - 技術スタック: TypeScript、Vitest
   - システムアーキテクチャ: Transformer（抽象クラス）、具象Transformer（JSON、XML、YAML）
   - 入力: 各種データ形式
   - 出力: 変換後のデータ

2. **開発環境の確認**
   - Node.js、npmの確認
   - `package.json`の依存関係確認
   - `npm run build`の動作確認

3. **実装計画の作成**
   - フェーズ1: Transformerインターフェース、抽象クラス
   - フェーズ2: JSONTransformer実装
   - フェーズ3: XMLTransformer実装
   - フェーズ4: YAMLTransformer実装

4. **コンポーネントの実装**
   - `src/core/Transformer.ts`: 抽象クラス
   - `src/transformers/JsonTransformer.ts`: JSON変換
   - `src/transformers/XmlTransformer.ts`: XML変換
   - `src/transformers/YamlTransformer.ts`: YAML変換
   - `src/index.ts`: エントリーポイント

5. **テストの実装**
   - `tests/transformers/JsonTransformer.test.ts`
   - `tests/transformers/XmlTransformer.test.ts`
   - `tests/transformers/YamlTransformer.test.ts`

6. **品質チェックの実施**
   - Linter実行: `npm run lint` → エラー0件
   - Formatter実行: `npm run format` → フォーマット済み
   - テスト実行: `npm test` → すべて成功
   - ビルド: `npm run build` → 成功

7. **ドキュメントの更新**
   - `README.md`: インストール手順、API使用方法を追加
   - `docs/api.md`: 各Transformerの使用例を記載

8. **実装レポートの作成**
   - `.spec/implementation-report.md`を作成

9. **Git運用**
   - `git add .`
   - `git commit -m "feat: データ変換コア機能を実装"`
   - `git push origin feature/core-transformers`

### 期待される出力

#### 実装コード例（一部）

**src/core/Transformer.ts**
```typescript
export interface TransformOptions {
  pretty?: boolean;
  encoding?: string;
}

export abstract class Transformer<TInput, TOutput> {
  abstract transform(input: TInput, options?: TransformOptions): TOutput;

  protected validate(input: TInput): void {
    if (input === null || input === undefined) {
      throw new Error('Input cannot be null or undefined');
    }
  }
}
```

**src/transformers/JsonTransformer.ts**
```typescript
import { Transformer, TransformOptions } from '../core/Transformer';

export class JsonTransformer extends Transformer<object, string> {
  transform(input: object, options?: TransformOptions): string {
    this.validate(input);

    const indent = options?.pretty ? 2 : undefined;
    return JSON.stringify(input, null, indent);
  }
}
```

#### 実装レポート

```markdown
# 実装レポート

## 実装サマリー

データ変換ライブラリのコア機能（JSON、XML、YAML変換）を実装しました。

## 実装内容

### 実装したファイル

- `src/core/Transformer.ts`: 変換の抽象クラス
- `src/transformers/JsonTransformer.ts`: JSON変換
- `src/transformers/XmlTransformer.ts`: XML変換
- `src/transformers/YamlTransformer.ts`: YAML変換
- `src/index.ts`: エクスポート設定

### API

```typescript
import { JsonTransformer, XmlTransformer, YamlTransformer } from 'data-transformer';

const jsonTransformer = new JsonTransformer();
const json = jsonTransformer.transform({ key: 'value' }, { pretty: true });

const xmlTransformer = new XmlTransformer();
const xml = xmlTransformer.transform({ key: 'value' });

const yamlTransformer = new YamlTransformer();
const yaml = yamlTransformer.transform({ key: 'value' });
```

## テスト結果

- **ユニットテスト**: 24件 → すべて成功
- **カバレッジ**: 95%

## 品質チェック結果

- **ESLint**: エラー0件、警告0件
- **Prettier**: フォーマット済み
- **TypeScript**: 型チェック成功
- **ビルド**: 成功

## 残課題

- [ ] P2機能（カスタムTransformer）の実装
- [ ] パフォーマンスベンチマークの実施

## 次のステップ

1. カスタムTransformerのサポートを実装する
2. npmパッケージとして公開する準備をする
3. checking-contradictionsスキルで一貫性を検証する
```

---

## まとめ

`implementation`スキルは、詳細設計書を実際のコードに落とし込むプロセスを体系的に支援します。

**主な特徴:**
- coding-conventions、branch-commit-conventions、document-conventionsに準拠した実装
- テスト駆動の品質保証
- 段階的な実装プロセス
- 実装レポートによる進捗の可視化

**次のフェーズ:**
実装完了後は、`checking-contradictions`スキルでプロジェクト全体の一貫性を検証します。
