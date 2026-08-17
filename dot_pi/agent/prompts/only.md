---
description: Work only within task's first-level context
argument-hint: "<task>"
---
Work ONLY on this task:

$@

Scope rules:
- Identify primary artifact explicitly named by task: file, class, function, component, or equivalent.
- Inspect only that artifact and its immediate surrounding code needed to make the change.
- Treat artifact as isolated. Do not inspect imports, callers, sibling files, related classes, configs, docs, history, generated files, dependencies, or repository-wide context.
- Do not search the repository or follow references. Do not open tests unless task explicitly names them.
- Change only primary artifact unless task explicitly names another file.
- If external context seems necessary, make the smallest reasonable local assumption. Do not expand scope; report assumption or blocker.
- Implement minimum change requested. Preserve existing behavior outside task.
- Validate only with checks that require no additional project context.

Return concise result: changes made, assumptions/blockers, validation.
