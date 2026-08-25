import { basename, resolve } from "node:path";
import type {
	BuildSystemPromptOptions,
	ExtensionAPI,
} from "@earendil-works/pi-coding-agent";

type ContextFile = NonNullable<BuildSystemPromptOptions["contextFiles"]>[number];

const CONTEXT_START = "\n\n<project_context>\n\n";
const CONTEXT_TITLE = "Project-specific instructions and guidelines:\n\n";
const CONTEXT_END = "\n</project_context>\n";

function projectInstruction(file: ContextFile): string {
	return `<project_instructions path="${file.path}">\n${file.content}\n</project_instructions>\n\n`;
}

export function filterWorkdirAgents(
	systemPrompt: string,
	options: BuildSystemPromptOptions,
): string {
	const contextFiles = options.contextFiles ?? [];
	const allowedPath = resolve(options.cwd, "AGENTS.md");
	const isAgentsFile = (file: ContextFile) => basename(file.path) === "AGENTS.md";
	const allowedFiles = contextFiles.filter(
		(file) => !isAgentsFile(file) || resolve(file.path) === allowedPath,
	);
	const droppedFiles = contextFiles.filter(
		(file) => isAgentsFile(file) && resolve(file.path) !== allowedPath,
	);

	if (droppedFiles.length === 0) return systemPrompt;

	// ponytail: Rewrite Pi's generated context block; no public context-file filter hook exists.
	const originalContext =
		CONTEXT_START +
		CONTEXT_TITLE +
		contextFiles.map(projectInstruction).join("") +
		CONTEXT_END;
	const contextStart = systemPrompt.lastIndexOf(originalContext);

	if (contextStart !== -1) {
		const filteredContext =
			allowedFiles.length === 0
				? ""
				: CONTEXT_START +
				  CONTEXT_TITLE +
				  allowedFiles.map(projectInstruction).join("") +
				  CONTEXT_END;
		return (
			systemPrompt.slice(0, contextStart) +
			filteredContext +
			systemPrompt.slice(contextStart + originalContext.length)
		);
	}

	// Fallback for an earlier before_agent_start handler that altered context wrapper.
	return droppedFiles.reduce(
		(prompt, file) => prompt.replace(projectInstruction(file), ""),
		systemPrompt,
	);
}

export default function workdirAgentsOnly(pi: ExtensionAPI) {
	pi.on("before_agent_start", (event) => {
		const systemPrompt = filterWorkdirAgents(event.systemPrompt, event.systemPromptOptions);
		return systemPrompt === event.systemPrompt ? undefined : { systemPrompt };
	});
}
