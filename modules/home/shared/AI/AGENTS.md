# AGENTS Guideline

## Language

- Always respond in Chinese for all explanations, comments, and communications with the user.
- Keep technical terms and code identifiers in their original form.

## Environment & Tooling

### Missing a binary/tool

- Never run `nix profile install` to obtain a missing tool.
- Run it ad-hoc instead: `nix run nixpkgs#<pkg> -- <args>` or `nix shell nixpkgs#<pkg1> nixpkgs#<pkg2>`.

### Missing a development environment

- Prefer `ah` over hand-rolled or manually installed environments.
- Usage: `ah use rust go nodejs` (alias `ah python nodejs`).

## Safety

### Remote GitHub operations

- Never perform remote GitHub operations without explicit user confirmation.
- Covers at least: `git push` (any branch), opening/commenting issues and PRs, and publishing/replying in Discussions.
- Before any such action: state exactly what and where, then ask.

## Reasoning Standards

- Never answer with speculation or hedging ("maybe", "probably", "might be").
- If uncertain, stop guessing and gather definitive evidence: read the file, run the command, search the codebase, or query authoritative docs.
- Only assert what you can back with evidence observed in this session.
