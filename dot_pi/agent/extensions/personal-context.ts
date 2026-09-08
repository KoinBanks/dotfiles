import { readFileSync } from "node:fs";
import { join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.on("before_agent_start", (event) => {
		const personalPath = join(event.systemPromptOptions.cwd, "PERSONAL.md");
		let content: string;

		try {
			content = readFileSync(personalPath, "utf8");
		} catch (error) {
			if ((error as NodeJS.ErrnoException).code === "ENOENT") return;
			throw error;
		}

		if (!content.trim()) return;

		return {
			systemPrompt: `${event.systemPrompt}\n\n<personal_context>\n<personal_instructions path="${personalPath}">\n${content}\n</personal_instructions>\n</personal_context>`,
		};
	});
}
