module.exports = {
    // Extends a shareable configuration, typically based on Conventional Commits.
    // This line imports and applies the rules defined in the '@commitlint/config-conventional' package.
    extends: ['@commitlint/config-conventional'],
  
    // Defines custom rules or overrides rules from the extended configuration.
    // Rules are defined as an object where the key is the rule name and the value is an array:
    // [level, applicable, value]
    // - level: 0 (disabled), 1 (warning), 2 (error)
    // - applicable: 'always' or 'never' (inverts the rule)
    // - value: the value to use for the rule (e.g., an array of allowed types for 'type-enum')
    rules: {
      // Enforces a specific set of allowed commit types.
      // In this example, 'button' is added to the default types provided by 'config-conventional'.
      'type-enum': [
        2,
        'always',
        [
          'build',
          'chore',
          'ci',
          'docs',
          'feat',
          'fix',
          'perf',
          'refactor',
          'revert',
          'style',
          'test',
          'button', // Custom type added
        ],
      ],
      // Enforces that the commit subject should not be empty.
      'subject-empty': [2, 'never'],
      // Enforces a maximum length for the commit header.
      'header-max-length': [2, 'always', 100],
    },
  
    // Optionally ignore specific commit messages based on a function.
    // ignore: (commit) => commit.includes('WIP'),
  };