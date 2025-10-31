# 詳細設計スキルの使用例

このドキュメントでは、detailed-designスキルの典型的な使用例を示します。

## 例1: 読書記録アプリの詳細設計

### ユーザーからの依頼

「読書記録アプリの要件定義書ができたので、詳細設計をお願いします。」

### 実施内容

#### ステップ1: 要件定義書の確認

要件定義書（`docs/requirements.md`）を読み込み、以下を確認：

- **機能要件**: ユーザー管理、読書記録管理、本の検索、読書メモ、読書統計、共有機能
- **非機能要件**:
  - パフォーマンス: 100〜1000人の同時利用
  - セキュリティ: ユーザー認証、データ保護
  - 可用性: 99%以上の稼働率
  - 互換性: 最新のブラウザ対応、レスポンシブデザイン

#### ステップ2: プロジェクト特性の確認

要件定義書から判断：

- **データベースの使用**: Yes - 読書記録、ユーザー情報を保存する必要がある
- **Web APIの使用**: Yes - フロントエンドとバックエンドが連携する
- **認証・認可の必要性**: Yes - ユーザー認証が必要

したがって、ステップ5（データベース設計）、ステップ6（API設計）、ステップ8（セキュリティ設計）を実施する。

#### ステップ3: 技術スタックの選定

ユーザーに以下を提案：

```markdown
**フロントエンドフレームワークについて**

A. **React + TypeScript**: 豊富なエコシステム、型安全性、広範なコミュニティサポート
B. **Vue.js + TypeScript**: 学習曲線が緩やか、シンプルな構文
C. **Next.js (React)**: SSR/SSG対応、SEO最適化、フルスタックフレームワーク
D. **その他**

**推奨**: **C. Next.js** - SEO対応が必要な読書記録の共有機能に最適。SSRによりパフォーマンスも向上。
```

```markdown
**バックエンドについて**

A. **Node.js + Express**: JavaScriptで統一、軽量、高速
B. **ASP.NET Core (C#)**: 高パフォーマンス、エンタープライズ対応、型安全性
C. **Next.js API Routes**: フロントエンドと統合、シンプル
D. **その他**

**推奨**: **C. Next.js API Routes** - フロントエンドとバックエンドを統合し、開発効率を最大化。中規模アプリに最適。
```

```markdown
**データベースについて**

A. **PostgreSQL**: 高機能、JSON対応、トランザクション処理が強力
B. **MySQL**: 広く使われている、シンプル
C. **MongoDB**: スキーマレス、柔軟なデータ構造
D. **その他**

**推奨**: **A. PostgreSQL** - リレーショナルデータに最適。ユーザー・読書記録・メモの関係を明確に管理できる。
```

**ユーザーの回答**: 推奨案で進めてください。

#### ステップ4: システムアーキテクチャの設計

**レイヤー構成**:

- **プレゼンテーション層**: Next.jsページコンポーネント、UIコンポーネント
- **API層**: Next.js API Routes
- **ビジネスロジック層**: サービスクラス
- **データアクセス層**: Prisma ORM
- **データベース層**: PostgreSQL

**コンポーネント構成**:

- フロントエンド: ページ、UIコンポーネント、カスタムフック、状態管理
- バックエンド: APIルート、サービス、リポジトリ、ドメインモデル

**状態管理**: React Context API + カスタムフック

#### ステップ5: データベース設計

**テーブル定義**:

1. **users** - ユーザー情報
   - id (UUID, PK)
   - email (VARCHAR, UNIQUE, NOT NULL)
   - password_hash (VARCHAR, NOT NULL)
   - username (VARCHAR, NOT NULL)
   - created_at (TIMESTAMP)

2. **books** - 本の情報
   - id (UUID, PK)
   - title (VARCHAR, NOT NULL)
   - author (VARCHAR, NOT NULL)
   - isbn (VARCHAR)
   - created_at (TIMESTAMP)

3. **reading_records** - 読書記録
   - id (UUID, PK)
   - user_id (UUID, FK → users.id)
   - book_id (UUID, FK → books.id)
   - status (ENUM: reading, completed)
   - started_at (DATE)
   - completed_at (DATE, NULL)
   - rating (INTEGER, 1-5)
   - created_at (TIMESTAMP)

4. **memos** - 読書メモ
   - id (UUID, PK)
   - reading_record_id (UUID, FK → reading_records.id)
   - content (TEXT, NOT NULL)
   - page_number (INTEGER)
   - created_at (TIMESTAMP)

**ER図**:

```
users (1) ──< (N) reading_records (N) >── (1) books
                        │
                        │ (1)
                        │
                        ↓ (N)
                      memos
```

#### ステップ6: API設計

**エンドポイント例**:

| HTTPメソッド | パス | 説明 |
|------------|------|------|
| POST | /api/auth/register | ユーザー登録 |
| POST | /api/auth/login | ログイン |
| GET | /api/reading-records | 読書記録一覧取得 |
| POST | /api/reading-records | 読書記録作成 |
| PUT | /api/reading-records/:id | 読書記録更新 |
| DELETE | /api/reading-records/:id | 読書記録削除 |
| GET | /api/books/search?q={query} | 本の検索 |
| POST | /api/memos | メモ作成 |

**認証**: JWT（JSON Web Token）を使用

#### ステップ7: コンポーネント設計

**フロントエンド**:

- **ページコンポーネント**: `pages/index.tsx`, `pages/records/index.tsx`, `pages/records/[id].tsx`
- **UIコンポーネント**: `RecordCard`, `BookSearchInput`, `MemoEditor`
- **カスタムフック**: `useAuth`, `useReadingRecords`, `useMemos`
- **サービス層**: `authService`, `recordService`, `bookService`

**バックエンド**:

- **APIルート**: `pages/api/auth/`, `pages/api/reading-records/`, `pages/api/memos/`
- **サービス層**: `AuthService`, `RecordService`, `BookService`
- **リポジトリ層**: `UserRepository`, `RecordRepository`, `BookRepository`

#### ステップ8: セキュリティ設計

- **認証**: JWT、HTTPOnly Cookie
- **認可**: ミドルウェアでJWT検証、ユーザーIDベースのアクセス制御
- **データ保護**: bcryptでパスワードハッシュ化、HTTPS通信
- **入力検証**: Zodでバリデーション

#### ステップ9: ディレクトリ構造の提案

```
reading-app/
├── src/
│   ├── pages/
│   │   ├── api/
│   │   │   ├── auth/
│   │   │   ├── reading-records/
│   │   │   └── memos/
│   │   ├── index.tsx
│   │   └── records/
│   ├── components/
│   │   ├── layouts/
│   │   ├── ui/
│   │   └── features/
│   ├── hooks/
│   ├── services/
│   ├── lib/
│   │   ├── prisma.ts
│   │   └── auth.ts
│   └── types/
├── prisma/
│   └── schema.prisma
└── public/
```

#### ステップ10: 詳細設計書の作成

すべての設計内容を `docs/detailed-design.md` としてドキュメント化。

---

## 例2: データベースを使用しないプロジェクト

### ユーザーからの依頼

「Markdown解析ツールの詳細設計をお願いします。ローカルファイルを読み込んで、構造を分析するCLIツールです。」

### 実施内容

#### ステップ1: 要件定義書の確認

要件定義書から以下を確認：

- **機能要件**: Markdownファイル解析、見出し階層チェック、リンク切れ検出
- **非機能要件**: ローカル実行、高速処理

#### ステップ2: プロジェクト特性の確認

要件定義書から判断：

- **データベースの使用**: No - ローカルファイルのみを扱う
- **Web APIの使用**: No - CLIツール
- **認証・認可の必要性**: No - ローカル実行

したがって、ステップ5（データベース設計）、ステップ6（API設計）、ステップ8（セキュリティ設計）をスキップする。

#### ステップ3: 技術スタックの選定

- **言語**: Node.js + TypeScript
- **CLIフレームワーク**: Commander.js
- **Markdown解析**: unified + remark

#### ステップ4: システムアーキテクチャの設計

- **入力層**: CLIコマンド処理
- **解析層**: Markdownパーサー、構造解析
- **検証層**: ルールエンジン
- **出力層**: レポート生成

#### ステップ7: コンポーネント設計

- **CLIコマンドハンドラー**: コマンド解析と実行
- **FileReader**: ファイル読み込み
- **MarkdownParser**: Markdown構文解析
- **StructureAnalyzer**: 構造分析
- **RuleEngine**: 検証ルール適用
- **ReportGenerator**: レポート出力

#### ステップ9: ディレクトリ構造

```
markdown-analyzer/
├── src/
│   ├── cli/
│   ├── parsers/
│   ├── analyzers/
│   ├── rules/
│   └── reporters/
└── tests/
```

#### ステップ10: 詳細設計書の作成

必須項目のみを含む詳細設計書を作成。データベース設計、API設計、セキュリティ設計は含まれない。

---

## ヒント

- **要件定義書が必須**: 詳細設計は要件定義書に基づいて行われます
- **技術選定は対話的**: 複数の選択肢を提示し、ユーザーと合意します
- **プロジェクト特性に応じた設計**: 不要なステップはスキップし、効率的に進めます
- **段階的な承認**: 各ステップでユーザーの承認を得てから進めます
