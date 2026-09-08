import { readFileSync } from "node:fs";
import { join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.on("before_agent_start", (event) => {
		const workdir = event.systemPromptOptions.cwd;
		const contextFiles = event.systemPromptOptions.contextFiles;
		let modifiedSystemPrompt = event.systemPrompt;

		const contextToRemove = contextFiles?.filter(cf => cf.path.endsWith("AGENTS.md")).filter(cf => !cf.path.includes(workdir));

		for (const contextFile of contextToRemove || []) {
			const path = contextFile.path.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
			const regex = new RegExp(
				`^[\\t ]*<project_instructions path="${path}">[\\s\\S]*?<\\/project_instructions>[\\t ]*(?:\\r?\\n|$)`,
				"gm",
			);
			modifiedSystemPrompt = modifiedSystemPrompt.replace(regex, "");
		}

		const personalPath = join(workdir, "PERSONAL.md");
		try {
			const content = readFileSync(personalPath, "utf8");
			if (content.trim()) {
				modifiedSystemPrompt = `${modifiedSystemPrompt}\n\n<personal_context>\n<personal_instructions path="${personalPath}">\n${content}\n</personal_instructions>\n</personal_context>`;
			}
		} catch (error) {
			if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;
		}

		return {systemPrompt: modifiedSystemPrompt};
	});

	pi.on("input", (event, ctx) => {
		if (event.source === "interactive" && event.text.trim() === "exit") {
			ctx.shutdown();
			return { action: "handled" };
		}
	});
}
