import { basename, join, resolve } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export function filterCwdAgentsFiles<T extends { path: string }>(files: T[], cwd: string): T[] {
	const cwdAgentsFile = resolve(cwd, "AGENTS.md");
	// ponytail: Normalize paths without resolving symlinks; use realpathSync if Pi reports physical aliases.
	return files.filter(
		(file) => basename(file.path) !== "AGENTS.md" || resolve(cwd, file.path) === cwdAgentsFile,
	);
}

export default function (pi: ExtensionAPI) {
	pi.registerCommand("exportdesktop", {
		description: "Export the current session as HTML to your Desktop",
		handler: async (_args, ctx) => {
			const sessionFile = ctx.sessionManager.getSessionFile();

			if (!sessionFile) {
				ctx.ui.notify("Cannot export an unsaved session.", "error");
				return;
			}

			const desktop = await pi.exec("wslupath", ["-D"]);
			const outputDir = desktop.stdout.trim();
			if (desktop.code !== 0 || desktop.killed || desktop.truncated || !outputDir) {
				ctx.ui.notify(`Could not find the Desktop directory: ${desktop.stderr.trim() || "wslupath -D failed"}`, "error");
				return;
			}

			const outputPath = join(outputDir, `${basename(sessionFile, ".jsonl")}.html`);
			const result = await pi.exec("pi", ["--export", sessionFile, outputPath], { cwd: ctx.cwd });
			if (result.code !== 0 || result.killed || result.truncated) {
				ctx.ui.notify(`Session export failed: ${result.stderr.trim() || "pi --export failed"}`, "error");
				return;
			}

			ctx.ui.notify(`Session exported to ${outputPath}`, "info");
		},
	});

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
