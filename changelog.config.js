module.exports = {
  disableEmoji: false,
  format: "{emoji}{type}: {subject}",
  list: [
    "fix",
    "feat",
    "refactor",
    "test",
    "style",
    "chore",
  ],
  maxMessageLength: 80,
  minMessageLength: 3,
  questions: ["type", "subject", "body"],
  scopes: [],
  types: {
    chore: {
      description: "ドキュメント、ビルドプロセス、ツールなどの変更",
      emoji: '🤖',
      value: "chore",
    },
    feat: {
      description: "機能追加",
      emoji: '🎸',
      value: "feat",
    },
    fix: {
      description: "不具合の修正",
      emoji: '🐛',
      value: "fix",
    },
    refactor: {
      description: "バグ修正や機能の追加を行わないコードの変更",
      emoji: '💡',
      value: "refactor",
    },
    style: {
      description: 'デザイン、マークアップ、フォーマットなどの修正',
      emoji: '💄',
      value: 'style',
    },
    test: {
      description: 'テストの追加・修正',
      emoji: '💍',
      value: 'test',
    },
  },
};
