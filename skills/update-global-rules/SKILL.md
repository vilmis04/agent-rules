---
name: update-global-rules
description: Use when the user says "update global rules", or when the global "Remember" protocol from RULES.md is triggered (the user says "remember" about a rule, preference, or guideline) in a cloud session. Instead of editing a local file, checks the rule against RULES.md in vilmis04/agent-rules and opens a PR there with the change, regardless of which repo the session is attached to.
---

# Update Global Rules

The global rules live in `RULES.md` in the GitHub repo `vilmis04/agent-rules` (default branch `main`). This skill applies the "Remember" protocol from `RULES.md` to that repo via a pull request instead of editing `~/PROJECTS/global-agent-rules.md`.

## When to use

- The user says "update global rules" (with or without the rule text).
- The "Remember" protocol is triggered and the session is a cloud session (no access to the user's machine, e.g. Claude Code on the web / remote container). In a cloud session, never try to create or edit `~/PROJECTS/global-agent-rules.md` or any other local file; use this skill instead.

## Steps

1. **Extract the rule.** Take the core technical rule, formatting guideline, or workflow preference just discussed (or given with the request). If it is unclear what to save, ask.
2. **Formulate it** as a concise, direct instruction in the style of the existing bullets (`- **Short title:** Instruction.`).
3. **Read the current rules from GitHub**, not from disk: fetch `RULES.md` from `vilmis04/agent-rules` on `main` with the GitHub MCP `get_file_contents` tool. If the repo is not in the session's scope, attach it with `add_repo` (`owner: vilmis04`, `repo: agent-rules`, `access: push`). If access is denied, tell the user the exact reason and stop.
4. **Search for a match** in **Dynamic Global Rules** (and related sections if the topic clearly belongs there) for an existing rule with the same or very similar meaning. Also check open PRs on `vilmis04/agent-rules` (`list_pull_requests`, state `open`) for a pending change to the same rule and mention it if found.
5. **Decide the outcome before asking the user:**
   - **Exact match (same meaning):** Do not change anything. Tell the user the rule already exists (quote or paraphrase the existing bullet) and stop.
   - **Very similar:** Propose an **update** to the existing bullet (show current vs proposed text). Do not append a duplicate.
   - **No match:** Propose adding a **new** bullet under Dynamic Global Rules (or the clearly related section).
6. **Ask for confirmation.** Show the proposed action and the exact Markdown that will be written. DO NOT PROCEED WITHOUT CONFIRMATION.
7. **On confirmation, open the PR:**
   1. Create a branch from `main` in `vilmis04/agent-rules` named `rules/<short-kebab-summary>` (`create_branch`).
   2. Apply the add/update to the fetched `RULES.md` content, changing only the affected bullet(s) and keeping everything else byte-for-byte identical.
   3. Commit it to the new branch with `create_or_update_file` (pass the file `sha` from step 3), message `Add rule: <title>` or `Update rule: <title>`.
   4. Create a PR into `main` (`create_pull_request`) with a short title matching the commit and a body showing the added bullet, or current vs new text for an update.
   - Do this through the GitHub MCP tools so it works no matter which repo is checked out locally; do not modify the session's own repo or its branch.
   - Follow the **No AI attribution** rule: no "Generated with" lines or `Co-Authored-By` trailers in the commit or PR.
8. **Report** the PR link and explicitly confirm what was added or updated, or that nothing changed because it already existed.
