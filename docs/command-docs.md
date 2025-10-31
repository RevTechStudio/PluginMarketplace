# スラッシュコマンド

> インタラクティブセッション中にスラッシュコマンドを使用してClaudeの動作を制御します。

## 組み込みスラッシュコマンド

| コマンド                      | 目的                                                                                               |
| :------------------------ | :----------------------------------------------------------------------------------------------- |
| `/add-dir`                | 追加の作業ディレクトリを追加                                                                                   |
| `/agents`                 | 特殊なタスク用のカスタムAIサブエージェントを管理                                                                        |
| `/bug`                    | バグを報告（会話をAnthropicに送信）                                                                           |
| `/clear`                  | 会話履歴をクリア                                                                                         |
| `/compact [instructions]` | オプションのフォーカス指示付きで会話をコンパクト化                                                                        |
| `/config`                 | 設定インターフェース（設定タブ）を開く                                                                              |
| `/cost`                   | トークン使用統計を表示（サブスクリプション固有の詳細については[コスト追跡ガイド](/ja/docs/claude-code/costs#using-the-cost-command)を参照） |
| `/doctor`                 | Claude Code インストールの健全性をチェック                                                                      |
| `/help`                   | 使用方法ヘルプを取得                                                                                       |
| `/init`                   | CLAUDE.md ガイドでプロジェクトを初期化                                                                         |
| `/login`                  | Anthropic アカウントを切り替え                                                                             |
| `/logout`                 | Anthropic アカウントからサインアウト                                                                          |
| `/mcp`                    | MCP サーバー接続と OAuth 認証を管理                                                                          |
| `/memory`                 | CLAUDE.md メモリファイルを編集                                                                             |
| `/model`                  | AI モデルを選択または変更                                                                                   |
| `/permissions`            | [権限](/ja/docs/claude-code/iam#configuring-permissions)を表示または更新                                   |
| `/pr_comments`            | プルリクエストコメントを表示                                                                                   |
| `/review`                 | コードレビューをリクエスト                                                                                    |
| `/sandbox`                | ファイルシステムとネットワーク分離を備えたサンドボックス化されたbashツールを有効にして、より安全で自律的な実行を実現                                     |
| `/rewind`                 | 会話またはコードを巻き戻す                                                                                    |
| `/status`                 | 設定インターフェース（ステータスタブ）を開く。バージョン、モデル、アカウント、接続性を表示                                                    |
| `/terminal-setup`         | Shift+Enter キーバインディングを改行用にインストール（iTerm2 と VSCode のみ）                                             |
| `/usage`                  | プラン使用制限とレート制限ステータスを表示（サブスクリプションプランのみ）                                                            |
| `/vim`                    | vim モードに入る。挿入モードとコマンドモードを交互に切り替え                                                                 |

## カスタムスラッシュコマンド

カスタムスラッシュコマンドを使用すると、頻繁に使用されるプロンプトを Markdown ファイルとして定義でき、Claude Code が実行できます。コマンドはスコープ（プロジェクト固有または個人用）で整理され、ディレクトリ構造を通じた名前空間をサポートします。

### 構文

```
/<command-name> [arguments]
```

#### パラメータ

| パラメータ            | 説明                                  |
| :--------------- | :---------------------------------- |
| `<command-name>` | Markdown ファイル名から派生した名前（`.md` 拡張子なし） |
| `[arguments]`    | コマンドに渡されるオプション引数                    |

### コマンドタイプ

#### プロジェクトコマンド

リポジトリに保存され、チームと共有されるコマンド。`/help` にリストされる場合、これらのコマンドは説明の後に「(project)」と表示されます。

**場所**: `.claude/commands/`

次の例では、`/optimize` コマンドを作成します：

```bash  theme={null}
# プロジェクトコマンドを作成
mkdir -p .claude/commands
echo "Analyze this code for performance issues and suggest optimizations:" > .claude/commands/optimize.md
```

#### 個人用コマンド

すべてのプロジェクト全体で利用可能なコマンド。`/help` にリストされる場合、これらのコマンドは説明の後に「(user)」と表示されます。

**場所**: `~/.claude/commands/`

次の例では、`/security-review` コマンドを作成します：

```bash  theme={null}
# 個人用コマンドを作成
mkdir -p ~/.claude/commands
echo "Review this code for security vulnerabilities:" > ~/.claude/commands/security-review.md
```

### 機能

#### 名前空間

サブディレクトリ内でコマンドを整理します。サブディレクトリは組織用に使用され、コマンドの説明に表示されますが、コマンド名自体には影響しません。説明には、コマンドがプロジェクトディレクトリ（`.claude/commands`）またはユーザーレベルディレクトリ（`~/.claude/commands`）のどちらから来ているか、およびサブディレクトリ名が表示されます。

ユーザーレベルとプロジェクトレベルのコマンド間の競合はサポートされていません。それ以外の場合、同じベースファイル名を持つ複数のコマンドが共存できます。

たとえば、`.claude/commands/frontend/component.md` のファイルは、説明に「(project:frontend)」と表示される `/component` コマンドを作成します。
一方、`~/.claude/commands/component.md` のファイルは、説明に「(user)」と表示される `/component` コマンドを作成します。

#### 引数

引数プレースホルダーを使用して、コマンドに動的な値を渡します：

##### `$ARGUMENTS` を使用したすべての引数

`$ARGUMENTS` プレースホルダーは、コマンドに渡されたすべての引数をキャプチャします：

```bash  theme={null}
# コマンド定義
echo 'Fix issue #$ARGUMENTS following our coding standards' > .claude/commands/fix-issue.md

# 使用方法
> /fix-issue 123 high-priority
# $ARGUMENTS は以下になります: "123 high-priority"
```

##### `$1`、`$2` などを使用した個別引数

位置パラメータ（シェルスクリプトと同様）を使用して、特定の引数に個別にアクセスします：

```bash  theme={null}
# コマンド定義  
echo 'Review PR #$1 with priority $2 and assign to $3' > .claude/commands/review-pr.md

# 使用方法
> /review-pr 456 high alice
# $1 は「456」、$2 は「high」、$3 は「alice」になります
```

位置引数を使用する場合は、以下が必要です：

* コマンドのさまざまな部分で引数に個別にアクセスする
* 不足している引数のデフォルトを提供する
* 特定のパラメータロールを持つより構造化されたコマンドを構築する

#### Bash コマンド実行

`!` プレフィックスを使用して、スラッシュコマンドが実行される前に bash コマンドを実行します。出力はコマンドコンテキストに含まれます。`allowed-tools` に `Bash` ツールを含める\_必要がありますが\_、許可する特定の bash コマンドを選択できます。

たとえば：

```markdown  theme={null}
---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

Based on the above changes, create a single git commit.
```

#### ファイル参照

`@` プレフィックスを使用して、コマンドにファイルコンテンツを含め、[ファイルを参照](/ja/docs/claude-code/common-workflows#reference-files-and-directories)します。

たとえば：

```markdown  theme={null}
# 特定のファイルを参照

Review the implementation in @src/utils/helpers.js

# 複数のファイルを参照

Compare @src/old-version.js with @src/new-version.js
```

#### 思考モード

スラッシュコマンドは、[拡張思考キーワード](/ja/docs/claude-code/common-workflows#use-extended-thinking)を含めることで、拡張思考をトリガーできます。

### フロントマター

コマンドファイルはフロントマターをサポートしており、コマンドに関するメタデータを指定するのに便利です：

| フロントマター                    | 目的                                                                                                                     | デフォルト         |
| :------------------------- | :--------------------------------------------------------------------------------------------------------------------- | :------------ |
| `allowed-tools`            | コマンドが使用できるツールのリスト                                                                                                      | 会話から継承        |
| `argument-hint`            | スラッシュコマンドに期待される引数。例：`argument-hint: add [tagId] \| remove [tagId] \| list`。このヒントは、スラッシュコマンドをオートコンプリートするときにユーザーに表示されます。 | なし            |
| `description`              | コマンドの簡潔な説明                                                                                                             | プロンプトの最初の行を使用 |
| `model`                    | 特定のモデル文字列（[モデル概要](/ja/docs/about-claude/models/overview)を参照）                                                           | 会話から継承        |
| `disable-model-invocation` | `SlashCommand` ツールがこのコマンドを呼び出すのを防ぐかどうか                                                                                 | false         |

たとえば：

```markdown  theme={null}
---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
argument-hint: [message]
description: Create a git commit
model: claude-3-5-haiku-20241022
---

Create a git commit with message: $ARGUMENTS
```

位置引数を使用した例：

```markdown  theme={null}
---
argument-hint: [pr-number] [priority] [assignee]
description: Review pull request
---

Review PR #$1 with priority $2 and assign to $3.
Focus on security, performance, and code style.
```

## プラグインコマンド

[プラグイン](/ja/docs/claude-code/plugins)は、Claude Code とシームレスに統合するカスタムスラッシュコマンドを提供できます。プラグインコマンドはユーザー定義コマンドと同じように機能しますが、[プラグインマーケットプレイス](/ja/docs/claude-code/plugin-marketplaces)を通じて配布されます。

### プラグインコマンドの仕組み

プラグインコマンドは：

* **名前空間化**: コマンドは競合を避けるために `/plugin-name:command-name` 形式を使用できます（名前の衝突がない限り、プラグインプレフィックスはオプション）
* **自動的に利用可能**: プラグインがインストールされて有効になると、そのコマンドが `/help` に表示されます
* **完全に統合**: すべてのコマンド機能をサポート（引数、フロントマター、bash 実行、ファイル参照）

### プラグインコマンド構造

**場所**: プラグインルート内の `commands/` ディレクトリ

**ファイル形式**: フロントマター付き Markdown ファイル

**基本的なコマンド構造**:

```markdown  theme={null}
---
description: Brief description of what the command does
---

# Command Name

Detailed instructions for Claude on how to execute this command.
Include specific guidance on parameters, expected outcomes, and any special considerations.
```

**高度なコマンド機能**:

* **引数**: コマンド説明で `{arg1}` のようなプレースホルダーを使用
* **サブディレクトリ**: 名前空間化のためにサブディレクトリ内でコマンドを整理
* **Bash 統合**: コマンドはシェルスクリプトとプログラムを実行できます
* **ファイル参照**: コマンドはプロジェクトファイルを参照および変更できます

### 呼び出しパターン

```shell 競合がない場合の直接コマンド theme={null}
/command-name
```

```shell 曖昧性を排除する必要がある場合のプラグインプレフィックス theme={null}
/plugin-name:command-name
```

```shell 引数付き（コマンドがサポートしている場合） theme={null}
/command-name arg1 arg2
```

## MCP スラッシュコマンド

MCP サーバーは、Claude Code で利用可能になるスラッシュコマンドとしてプロンプトを公開できます。これらのコマンドは、接続された MCP サーバーから動的に検出されます。

### コマンド形式

MCP コマンドは以下のパターンに従います：

```
/mcp__<server-name>__<prompt-name> [arguments]
```

### 機能

#### 動的検出

MCP コマンドは以下の場合に自動的に利用可能になります：

* MCP サーバーが接続されてアクティブである
* サーバーが MCP プロトコルを通じてプロンプトを公開している
* 接続中にプロンプトが正常に取得されている

#### 引数

MCP プロンプトはサーバーで定義された引数を受け入れることができます：

```
# 引数なし
> /mcp__github__list_prs

# 引数付き
> /mcp__github__pr_review 456
> /mcp__jira__create_issue "Bug title" high
```

#### 命名規則

* サーバーとプロンプト名は正規化されます
* スペースと特殊文字はアンダースコアになります
* 一貫性のために名前は小文字になります

### MCP 接続の管理

`/mcp` コマンドを使用して：

* 構成されたすべての MCP サーバーを表示
* 接続ステータスを確認
* OAuth 対応サーバーで認証
* 認証トークンをクリア
* 各サーバーから利用可能なツールとプロンプトを表示

### MCP 権限とワイルドカード

[MCP ツールの権限を設定](/ja/docs/claude-code/iam#tool-specific-permission-rules)する場合、**ワイルドカードはサポートされていない**ことに注意してください：

* ✅ **正しい**: `mcp__github`（github サーバーからのすべてのツールを承認）
* ✅ **正しい**: `mcp__github__get_issue`（特定のツールを承認）
* ❌ **正しくない**: `mcp__github__*`（ワイルドカードはサポートされていません）

MCP サーバーからのすべてのツールを承認するには、サーバー名のみを使用します：`mcp__servername`。特定のツールのみを承認するには、各ツールを個別にリストします。

## `SlashCommand` ツール

`SlashCommand` ツールを使用すると、Claude は会話中に[カスタムスラッシュコマンド](/ja/docs/claude-code/slash-commands#custom-slash-commands)をプログラムで実行できます。これにより、Claude は必要に応じてあなたに代わってカスタムコマンドを呼び出す機能が得られます。

Claude に `SlashCommand` ツールをトリガーするよう促すには、指示（プロンプト、CLAUDE.md など）が通常、スラッシュ付きのコマンド名を参照する必要があります。

例：

```
> Run /write-unit-test when you are about to start writing tests.
```

このツールは、利用可能な各カスタムスラッシュコマンドのメタデータを文字予算制限までコンテキストに入れます。`/context` を使用してトークン使用量を監視し、以下の操作に従ってコンテキストを管理できます。

### `SlashCommand` ツールがサポートするコマンド

`SlashCommand` ツールは以下のカスタムスラッシュコマンドのみをサポートします：

* ユーザー定義である。`/compact` や `/init` などの組み込みコマンドは\_サポートされていません\_。
* `description` フロントマターフィールドが入力されている。コンテキストで説明を使用します。

Claude Code バージョン >= 1.0.124 の場合、`claude --debug` を実行してクエリをトリガーすることで、`SlashCommand` ツールが呼び出せるカスタムスラッシュコマンドを確認できます。

### `SlashCommand` ツールを無効にする

Claude がツール経由でスラッシュコマンドを実行するのを防ぐには：

```bash  theme={null}
/permissions
# 拒否ルールに追加: SlashCommand
```

これにより、SlashCommand ツール（およびスラッシュコマンドの説明）もコンテキストから削除されます。

### 特定のコマンドのみを無効にする

特定のスラッシュコマンドが利用可能になるのを防ぐには、スラッシュコマンドのフロントマターに `disable-model-invocation: true` を追加します。

これにより、コマンドのメタデータもコンテキストから削除されます。

### `SlashCommand` 権限ルール

権限ルールは以下をサポートします：

* **完全一致**: `SlashCommand:/commit`（引数なしで `/commit` のみを許可）
* **プレフィックス一致**: `SlashCommand:/review-pr:*`（任意の引数で `/review-pr` を許可）

### 文字予算制限

`SlashCommand` ツールには、Claude に表示されるコマンド説明のサイズを制限するための文字予算が含まれています。これにより、多くのコマンドが利用可能な場合のトークンオーバーフローを防ぎます。

予算には、各カスタムスラッシュコマンドの名前、引数、説明が含まれます。

* **デフォルト制限**: 15,000 文字
* **カスタム制限**: `SLASH_COMMAND_TOOL_CHAR_BUDGET` 環境変数で設定

文字予算を超えた場合、Claude は利用可能なコマンドのサブセットのみを表示します。`/context` では、「M of N commands」という警告が表示されます。

## スキルとスラッシュコマンド

**スラッシュコマンド**と**エージェントスキル**は Claude Code で異なる目的を果たします：

### スラッシュコマンドを使用する場合

**クイック、頻繁に使用されるプロンプト**:

* よく使用する単純なプロンプトスニペット
* クイックリマインダーまたはテンプレート
* 1 つのファイルに収まる頻繁に使用される指示

**例**:

* `/review` → 「このコードをレビューしてバグを見つけ、改善を提案してください」
* `/explain` → 「このコードを簡単な言葉で説明してください」
* `/optimize` → 「このコードをパフォーマンスの問題について分析してください」

### スキルを使用する場合

**構造を持つ包括的な機能**:

* 複数のステップを持つ複雑なワークフロー
* スクリプトまたはユーティリティが必要な機能
* 複数のファイルに整理された知識
* 標準化したいチームワークフロー

**例**:

* フォーム入力スクリプトと検証を備えた PDF 処理スキル
* さまざまなデータ型の参照ドキュメント付きデータ分析スキル
* スタイルガイドとテンプレート付きドキュメンテーションスキル

### 主な違い

| 側面       | スラッシュコマンド            | エージェントスキル                |
| -------- | -------------------- | ------------------------ |
| **複雑さ**  | シンプルなプロンプト           | 複雑な機能                    |
| **構造**   | 単一の .md ファイル         | SKILL.md + リソースを含むディレクトリ |
| **検出**   | 明示的な呼び出し（`/command`） | 自動（コンテキストに基づく）           |
| **ファイル** | 1 つのファイルのみ           | 複数のファイル、スクリプト、テンプレート     |
| **スコープ** | プロジェクトまたは個人用         | プロジェクトまたは個人用             |
| **共有**   | git 経由               | git 経由                   |

### 例の比較

**スラッシュコマンドとして**:

```markdown  theme={null}
# .claude/commands/review.md
Review this code for:
- Security vulnerabilities
- Performance issues
- Code style violations
```

使用方法: `/review`（手動呼び出し）

**スキルとして**:

```
.claude/skills/code-review/
├── SKILL.md (overview and workflows)
├── SECURITY.md (security checklist)
├── PERFORMANCE.md (performance patterns)
├── STYLE.md (style guide reference)
└── scripts/
    └── run-linters.sh
```

使用方法: 「このコードをレビューしてもらえますか？」（自動検出）

スキルは、より豊富なコンテキスト、検証スクリプト、整理された参照資料を提供します。

### 各々をいつ使用するか

**スラッシュコマンドを使用する場合**:

* 同じプロンプトを繰り返し呼び出す
* プロンプトが 1 つのファイルに収まる
* いつ実行するかについて明示的な制御が必要

**スキルを使用する場合**:

* Claude が機能を自動的に検出する必要がある
* 複数のファイルまたはスクリプトが必要
* 検証ステップを含む複雑なワークフロー
* チームが標準化された詳細なガイダンスが必要

