import { basename, resolve } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export function filterCwdAgentsFiles<T extends { path: string }>(files: T[], cwd: string): T[] {
	const cwdAgentsFile = resolve(cwd, "AGENTS.md");
	// ponytail: Normalize paths without resolving symlinks; use realpathSync if Pi reports physical aliases.
	return files.filter(
		(file) => basename(file.path) !== "AGENTS.md" || resolve(cwd, file.path) === cwdAgentsFile,
	);
}

export default function (pi: ExtensionAPI) {
	pi.on("input", (event, ctx) => {
		if (event.source === "interactive" && event.text.trim() === "exit") {
			ctx.shutdown();
			return { action: "handled" };
		}
	});

	pi.on("before_agent_start", (event, ctx) => {
		event.systemPromptOptions.contextFiles = filterCwdAgentsFiles(
			event.systemPromptOptions.contextFiles ?? [],
			ctx.cwd,
		);
	});
}
