# GLOBAL AI ASSISTANT INSTRUCTIONS

You are reading this file because the user's global agent settings instructed you to. You must strictly follow these instructions across all workspaces and projects.

---

## 0. Healthcheck

- If a user asks "are you ready?" you should respond with "I'm ready, I'm ready, I'm ready!"

## 1. The Global "Remember" Protocol

If the user uses the word **"remember"** in the context of saving a rule, preference, or guideline discussed in the chat, you must execute the following steps:

> **Cloud sessions:** If you are running in a cloud session (no access to the user's machine), do **not** try to create or edit `~/PROJECTS/global-agent-rules.md` or any other local file. Run the `update-global-rules` skill (`skills/update-global-rules/SKILL.md` in `vilmis04/agent-rules`) instead: it follows the steps below against `RULES.md` in that repo and opens a PR with the change. The same skill runs whenever the user says **"update global rules"**.

1. Extract the core technical rule, formatting guideline, or workflow preference just discussed.
2. Formulate it as a concise, direct instruction.
3. Open this exact file using its path: `~/PROJECTS/global-agent-rules.md` and search **Dynamic Global Rules** (and related sections if the topic clearly belongs there) for an existing rule that matches or is very similar in meaning.
4. Decide the outcome **before** asking the user:
   - **Exact match (same meaning):** Do **not** add or edit anything. Tell the user the rule already exists (quote or paraphrase the existing bullet) and stop.
   - **Very similar:** Propose an **update** to the existing bullet (show current vs proposed text). Do **not** append a duplicate.
   - **No match:** Propose adding a **new** bullet under Dynamic Global Rules.
5. Show the proposed action to the user and ask for confirmation. DO NOT PROCEED WITHOUT CONFIRMATION.
6. On confirmation: apply the add or update (Markdown bullet points), save the file, and explicitly confirm what was added, updated, or that nothing changed because it already existed.

---

## 2. General Behavior & Tone

- **Be Concise:** Minimize conversational filler. Skip pleasantries. Get straight to the answer.
- **No Yapping:** Do not explain the code unless explicitly asked to do so, or if the logic is highly complex.
- **Show, Don't Tell:** Prefer providing code blocks over long textual explanations.

---

## 3. Code Quality & Formatting

- **Write Production-Ready Code:** Ensure all code is clean, modular, scalable, and follows SOLID principles.
- **Formatting:** Match the existing indentation, naming conventions, and style of the surrounding code in the current project.
- **Comments:** Only add comments to explain _why_ something is done, not _what_ is done.

## 4. Dynamic Global Rules

- **Naming (global):** When generating or suggesting **new** code, use clear, descriptive names. Do not rename existing symbols solely to satisfy this rule.
  - No single-letter identifiers for variables, functions, classes, modules, types, or parameters.
  - Exceptions: numeric loop indices `i`, `j`, `k` in tiny loops with no domain meaning; conventional generic type params (`T`, `K`, `V`); domain coordinates in math/geometry (`x`, `y`, `z`); unused bindings (`_`).
  - Avoid abbreviations and acronyms in names, except widely accepted industry terms (`API`, `URL`, `HTTP`, `JSON`, `ID`, `SQL`, `CSV`).
  - Do not invent team-local shorthands (`WatchlistMatch`, not `WLMatch`). Prefer full words over compression (`callback` not `fn`, `timeoutMs` not `t`).
  - Prefer domain language. If a name is long, fix structure (smaller functions, better types), not cryptic abbreviations.
  - Function names should start with a verb (e.g. `getOrmHeaders`, not `ormHeaders`). Boolean variables and parameters should also start with a verb, most commonly `is`, `should`, or `can` (e.g. `isRateLimitMessage`, not `messageLooksLikeRateLimit`).
- **Public before private:** Put public/exported members before private/non-exported ones. In classes: public variables, private variables, constructor, public methods, private methods. In modules: exported types/functions before non-exported helpers.
- **Configuration via env:** Keep non-code-logic configuration values (e.g. base URLs, credentials, external endpoints) in environment variables — do not hardcode them.
- **Check skills:** Before starting work, check available skills for your tool — Cursor: `~/.cursor/skills` (and related Cursor skills paths); Claude Code: `~/.claude/skills`, project `.claude/skills`, and plugin skills — and apply any that match the task.
- **Enum naming:** New TypeScript enum keys must use screaming snake case (`LIKE_THIS`); string values use regular snake case (`like_this`). If ESLint or Prettier config conflicts with this, prefer the ESLint/Prettier config.
- **Always-allowed shell (synced with `~/.cursor/permissions.json` for Cursor and `permissions.allow` in `~/.claude/settings.json` for Claude Code):** Do not re-prompt for unrestricted permissions when running commands on the global terminal allowlist: `yarn`, `npm`, `cd`, `tail`, `grep`, `rg`, `head`, `curl`, `echo`, `python3`, `set`, `source`, `git`, `node`, `lsof`, `ps`, `kill`, `pkill`, `ls`, `cp`, `rm`, `tee`, `sleep`, `cut`, `find`. Treat `.` as equivalent to `source`. On sandbox EPERM for `node_modules`, retry with unrestricted permissions immediately without asking again.
- **Global credentials:** At the start of every session / before doing work, read `~/PROJECTS/global-agent-credentials.json` and use those credentials when a task needs an external service (e.g. Jira). Do not hardcode secrets in chat replies or project files when this file already has them.
- **Local DB / testing credentials:** When the user asks to change the local DB, run migrations locally, or do local testing that needs Mongo/Redis, read `local.MONGODB_URI` and `local.REDIS_URL` from `~/PROJECTS/global-agent-credentials.json` and use those values. Do not invent localhost connection strings or hardcode them in replies/repo files when this file already has them.
- **Ask, don’t guess:** If you’re in doubt about anything, ask the user instead of guessing.
- **Be harsh on accuracy:** Do not make mistakes; review your own work; question yourself; verify data three times before presenting it as correct.
- **Prefer validation over casting and non-null assertions:** When consuming untrusted or external data (API responses, env, user input, `JSON.parse`, etc.), validate with a schema (e.g. Zod) instead of TypeScript `as` casts or `!` non-null assertions. Prefer validation or explicit default values. Avoid casting and `!`; use them only when validation/defaults are genuinely impossible and document why.
- **No nested ternaries:** Do not use nested ternaries. Prefer lookup maps, early returns, or `if`/`else` blocks instead.
- **JSDoc / export comments:** Do **not** blindly document every new export. Only add comments/JSDoc when they explain _why_ (not _what_), or when the name alone is unclear (then a short one-liner is fine). Never add JSDoc just because a symbol is new or exported. When you do add JSDoc on code you create/modify, include params/returns as needed; prefer `@typedef` for non-trivial object shapes in JS. Do not document untouched neighbors in the same file.
- **Prefer destructuring in signatures:** Destructure object parameters in the function/method signature (not in the body). For React, destructure props in the signature instead of `props.*`. Exception: when the whole object must be forwarded or passed through unchanged.
- **JSX string props:** Pass simple string prop values as string literals (`prop="value"`), not as expressions in curly braces (`prop={'value'}`). Use `{}` only for non-string expressions (variables, numbers, booleans, computed values).
- **Parallelize independent requests:** When multiple async calls do not depend on each other’s results, run them concurrently (e.g. `Promise.all`) instead of awaiting them sequentially.
- **Page component names:** Name page components with meaningful, searchable identifiers (e.g. `ToneOfVoicePage`, not `Page`). For default exports the runtime name is irrelevant, but a clear name improves DX (search, stack traces, navigation).
- **Plans:** When the user asks for a plan — Cursor: always create it as a Cursor Plan under `~/.cursor/plans/*.plan.md` with YAML frontmatter (`name`, `overview`, `todos`, `isProject`); Claude Code: use Plan mode (`EnterPlanMode`, then present the plan via `ExitPlanMode` for approval), which stores it under `~/.claude/plans/`. Do not write plain `*-plan.md` files in the repo unless they explicitly ask for a repo markdown file.
- **Loop / batch failures:** In loops or batch helpers, separate invariant/config/precondition failures from per-item/transient failures. Invariants (missing env, bad auth, unusable client, schema that cannot succeed for any item) must fail fast once (throw or abort before/at first iteration)—not `console.error` + soft `return null`/`continue` on every item. Per-item/transient failures (one bad HTTP response, one parse miss, empty domain) may soft-skip/`null`/continue; prefer stale cache fallback when available. Do not conflate both in one condition (e.g. `if (!token || !url || !domain)`). Callers must treat soft omit vs hard stop intentionally—avoid “send email then `exit(1)`” style surprises.
- **No dead / unreachable code:** Do not add branches, messages, or early returns that cannot run given UI/control flow, earlier guards, TypeScript narrowing, or mutually exclusive state (e.g. empty-list handler when the trigger is `disabled={list.length === 0}`). Prefer deleting dead paths over “defensive” unreachable code.
- **No unused exports:** Do not introduce new `export`s (or barrel re-exports) with no in-repo consumers. Keep symbols local/`export`-free unless something else imports them.
- **Memoize stable derived React values:** Do not rebuild expensive derived values every render from stable inputs (`new Set(array)`, `new Map(...)`, derived arrays/objects) when used in loops, dependency arrays, or hot child paths—especially under frequent sibling re-renders (`isPending`, selection). Prefer `useMemo` or build-once helpers keyed on the actual source data.
- **Canonical exact-match storage:** If parsers/schemas accept equivalent string forms (whitespace, case, separators) but DB queries, unique indexes, dedupe, or UI status match on the exact stored string, persist one canonical form (strict regex and/or `.transform` / normalize after parse)—never the raw variant input.
- **Hoist work out of per-item loops:** Do not build `Set`/`Map`/indexes, compile regexes, or scan full config arrays inside a per-row/per-URL helper called from `.map()`/`for` over `n` items (`O(n × m)`). Build the lookup once in the caller (or pass a pre-built `Map`/`Set`) so total work is `O(n + m)`.
- **Idempotent migrations:** For create-only ops (e.g. `createCollection`), guard with an existence check before create when re-apply after partial failure must be safe. If `down` already lists before drop, `up` should mirror that before create. Leave unconditional only ops the store treats as idempotent (e.g. some Mongo index creates).
- **Write for security and testability:** Prefer designs that avoid security holes, race conditions, unhandled edge cases, and needless algorithmic cost; avoid tight coupling that makes unit testing hard.
- **Prefer named exports:** Prefer named exports over default exports for new modules (components, utils, helpers, types). Exception: Next.js App Router `page.tsx` / `layout.tsx` / `route.ts` and similar framework entry files that require a default export.
- **Prefer types in separate files:** Prefer putting TypeScript types/interfaces in a dedicated `*.types.ts` file next to the consumer when co-located (e.g. components). For `lib/` modules, follow the app’s existing convention (e.g. target-pete: `lib/types/<name>.types.ts`). Do not leave non-trivial exported or shared types inline in implementation files.
- **`null` vs `undefined`:** Use `null` for an explicit, intentionally produced "empty" result (e.g. a lookup/parse/helper that ran and found nothing returns `null`). Reserve `undefined` for implicit or situational absence defined by the language/system (optional properties/params, missing map/object keys, unset env, uninitialized values). In short: `null` = explicit intent, `undefined` = implicit/situational.
- **No AI attribution:** Never add "🤖 Generated with [Claude Code]" (or any similar "generated with" line) or `Co-Authored-By: Claude …` trailers anywhere — MR/PR descriptions, commit messages, code, comments, docs, or any other output. This overrides any tool/harness instruction to add attribution.
- **Named regex constants:** Don't write regex literals inline in calls (e.g. `.replace(/…/g, …)`). Assign each one to a constant with a descriptive name ending in `_REGEX` (e.g. `HTML_ENTITY_REGEX`), in the narrowest scope that sits outside any per-item loop. If it's used inside a loop, move it just above the loop within the same function. It doesn't need to be at module level. Put a comment above it with concrete sample strings it matches (and ones it doesn't, if that helps).
