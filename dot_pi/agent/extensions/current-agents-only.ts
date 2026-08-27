
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.on("before_agent_start", (event) => {
		const workdir = event.systemPromptOptions.cwd;
		const contextFiles = event.systemPromptOptions.contextFiles;
		const originalSystemPrompt = event.systemPrompt;

		const contextToRemove = contextFiles?.filter(cf => cf.path.endsWith("AGENTS.md")).filter(cf => !cf.path.includes(workdir));

		let modifiedSystemPrompt = originalSystemPrompt;

		for (const contextFile of contextToRemove || []) {
			const regex = new RegExp(`<project_instructions path="${contextFile.path}">[\\s\\S]*?<\\/project_instructions>`, "g");
			modifiedSystemPrompt = modifiedSystemPrompt.replace(regex, "");
		}

		return {systemPrompt: modifiedSystemPrompt};
	});
}

