import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.on("before_agent_start", (event) => {
		const workdir = event.systemPromptOptions.cwd;
		const contextFiles = event.systemPromptOptions.contextFiles;
		const originalSystemPrompt = event.systemPrompt;

		const contextToRemove = contextFiles?.filter(cf => cf.path.endsWith("AGENTS.md")).filter(cf => !cf.path.includes(workdir));

		let modifiedSystemPrompt = originalSystemPrompt;

		for (const contextFile of contextToRemove || []) {
			const path = contextFile.path.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
			const regex = new RegExp(
				`^[\\t ]*<project_instructions path="${path}">[\\s\\S]*?<\\/project_instructions>[\\t ]*(?:\\r?\\n|$)`,
				"gm",
			);
			modifiedSystemPrompt = modifiedSystemPrompt.replace(regex, "");
		}

		return {systemPrompt: modifiedSystemPrompt};
	});
}
