AGENTS.md

Purpose
-------
This document explains how agentic coding agents (bots, CI agents, or human contributors acting as agents)
should build, lint, test and change this repository. Keep instructions concise and deterministic so agents
can operate reliably without asking for clarifying questions.

Quick commands (run from repository root)
- Install dependencies: `bundle install` (Ruby/Gems used by Jekyll)
- Build site: `bundle exec jekyll build` (outputs to `_site/`)
- Serve locally: `bundle exec jekyll serve --livereload` (rebuilds on change)
- Clean build: `rm -rf _site/ && bundle exec jekyll build`
- Preview production build (GitHub Pages compatible): `JEKYLL_ENV=production bundle exec jekyll build`

Linting & formatting (suggested commands)
- SCSS/CSS: if stylelint is installed: `npx stylelint "assets/**/*.scss" --fix`.
- HTML: `npx htmlhint .` or run an HTML linter of choice over `_layouts/` and `_includes/`.
- Markdown: `markdownlint **/*.md` (or `npx markdownlint-cli`) to check Markdown style.
- Ruby: add `rubocop` when Ruby code expands: `bundle exec rubocop`.

Running tests
- This repository currently contains no automated test suite. If you add tests, prefer one of these patterns
  so agents can run a single test deterministically:
  1) RSpec (Ruby): `bundle exec rspec spec/path/to/file_spec.rb:LINE` -- runs a single example at the given line.
  2) Minitest (Ruby): run a single file `ruby -Ilib:test test/path/to/test_file.rb` or use the test runner.
  3) Jest (JS): `npm test -- -t "pattern"` or `npx jest path/to/file.test.js -t "name of test"`.
  4) Pytest (Python): `pytest tests/test_file.py::test_name -q`.
  When adding tests, include a `Makefile` or `bin/test` wrapper that accepts an optional path or pattern so
  agents can run `bin/test path/to/thing` to run a single test reliably.

Cursor / Copilot rules
- No `.cursor/rules/` or `.cursorrules` files were found in this repo. There is also no
  `.github/copilot-instructions.md`. If such rules are added later, agents must read those files and obey
  them before making any changes.

Code style guidelines (for agents)
- General
  - Use UTF-8 and Unix line endings. Ensure each file ends with a single newline.
  - No tab characters for indentation; prefer 2 spaces for HTML, SCSS and YAML, and 2-4 spaces for Ruby.
  - Avoid trailing whitespace and long lines (> 100 characters) when possible. Break long strings into
    readable parts or template includes.

- Files & naming
  - Filenames: lowercase, hyphen-separated for public assets and content (e.g. `my-post.md`, `main.scss`).
  - Templates & includes: keep partials in `_includes/` with meaningful names, e.g. `_site-header.html`.
  - SCSS partials: start filenames with an underscore (e.g. `_variables.scss`) and import from `assets/`.

- Markdown & Jekyll
  - Every content file with front-matter must include valid YAML front matter delimited by `---`.
  - Keep front-matter keys simple and consistent (title, date, layout, tags, categories). Use ISO 8601 for
    dates: `YYYY-MM-DD HH:MM:SS +/-TZ` when time is needed.
  - Prefer permalinks and canonical URLs in front-matter where applicable.

- HTML & templates
  - Keep layout files small and componentized. Put repeated markup in `_includes/`.
  - Escape user-submitted or dynamic content with Liquid filters (`{{ var | escape }}`) where appropriate.
  - Avoid inline styles where possible; prefer classes and SCSS.

- SCSS / CSS
  - Variables: use `$kebab-case` for SCSS variables (e.g. `$brand-color`).
  - Mixins & functions: name `mixin-name` and keep them generic and well-documented.
  - Prefer `@use`/`@forward` for new projects; older `@import` is acceptable if the codebase already uses it.
  - Keep specificity low — prefer utility classes or BEM-like naming for components.

- Ruby (Jekyll plugin snippets)
  - Use snake_case for method and variable names.
  - Class and module names should be CamelCase.
  - Keep embedded Ruby code minimal — prefer Liquid and build-time plugins only when needed.

- JavaScript (if added)
  - Use `const`/`let` rather than `var`.
  - Prefer ES modules and clear exports when adding build tooling.
  - Keep client-side scripts minimal; avoid bundling unless site complexity requires it.

Types & typing
- This repository currently does not use a static type system. If adding TypeScript or Sorbet/RBS:
  - Add type definitions incrementally and include `tsconfig.json` or Sorbet config in the repo root.
  - Prefer explicit small types over wide `any`/`Object` types.

Error handling
- Fail early and loudly in CI and agent runs. Do not silently swallow exceptions.
- Log errors with context (what operation, file path, line number if applicable) so follow-up debugging is easy.
- When catching exceptions, handle the expected cases and re-raise or log unexpected ones.

Commit, branch & PR workflow for agents
- Branch naming: `feat/<short-desc>`, `fix/<short-desc>`, `docs/<short-desc>`, `chore/<short-desc>`.
- Commits: one logical change per commit; subject line <= 72 characters; body optional but include motivation.
- When creating a PR include:
  - Short summary (2-4 bullets) of what changed and why.
  - Any manual verification steps (commands to run locally).
  - If relevant, note performance or accessibility impacts.

Safety & blocking rules for agents
- Do not modify files outside the scope of the task without explicit instruction.
- NEVER commit secrets (API keys, credentials, .env files). If secrets are found, stop and notify a human.
- If a change affects build or deploy settings, add a short rationale in the PR body.

Helpful tips for maintainers and future agents
- Add a `bin/` script collection for common tasks (build, serve, test, lint) to make agent scripts deterministic
  and avoid environment-specific quirks.
- If you add tests, include a `CI` job that runs the test matrix and linters on every PR.

Where this file lives
- This file is created at repository root: `AGENTS.md`. Agents should consult it before making changes.

If you want changes
- I will create a small `bin/` wrapper or a `Makefile` to standardize commands if you ask. Suggested next steps:
  1) Add a `bin/test` wrapper that accepts an optional path/pattern. (Recommended)
  2) Add linters (`stylelint`, `markdownlint`, `rubocop`) to `Gemfile` / package.json and CI.
