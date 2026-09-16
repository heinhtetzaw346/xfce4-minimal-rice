# Output Handling Rule

1. **Route Non-Code Outputs:** Save all generated non-code files (e.g., markdown, text, images, slides) exclusively to `.agent-files/out` in the current workspace.

# Sensitive Information Rule

1. **Do Not Use Terminal Reading Tools on Sensitive Information:** You must NEVER use tools like `cat`, `grep`, `less`, or other generic file reading/searching commands on files containing sensitive information (e.g., tokens, passwords, private keys, session logs, or environment configs with secrets).
2. **Find Alternative Paths:** If a task involves sensitive information, look for alternative paths (like native MCP tools, APIs, or documented endpoints) instead of reading the raw text files.
3. **Inform the User:** If a task absolutely cannot be solved without reading sensitive information and no safe alternative exists, inform the user about the blockage.
4. **Never Force It:** Do NOT attempt to overcome the blockage by force. Stop and wait for user guidance.

# Temp File Handling Rule

1. **Store Temp Files Safely:** Save any temporary files needed during tasks into `.agent-files/temp` in the current workspace.
2. **Clean Up:** Delete these temporary files once the major task is completed.

# Progress Logging Rule

1. After every major tasks, please log the progress in .agent-files/log/file-name.md files. 
2. Name the log files with procedural numbers-topic/task name. example 01-review-project.md
3. If temporary scripts are used, please record the overview of the steps taken by those scripts in the log file.

# Kubeconfig & Context Policy

1. **Never Touch `.kube/config.d`:** NEVER read, inspect, list, edit, or touch the `.kube/config.d` directory under any circumstances. Do not even look at it.
2. **Prioritize MCP:** Always perform Kubernetes operations through the connected MCP tools.
3. **Explicit Context Switching:** If terminal operations are needed for a specific cluster/context, ask the user to switch into that specific context instead of referencing or switching kubeconfigs manually.

# Git Configuration Policy

1. **Preserve User Identity:** If a task or test requires changing Git user credentials (`user.name` or `user.email`), agents must record the original values before making any modifications.
2. **Prefer Local or Ephemeral Configs:** Avoid modifying global Git configuration (`--global`). Prefer repository-local configs (`git config user.name ...`), command-line overrides (`git -c user.name="..." -c user.email="..." commit ...`), or environment variables (`GIT_AUTHOR_NAME`, `GIT_COMMITTER_NAME`, etc.) whenever possible.
3. **Mandatory Restoration:** If Git user configurations (`user.name` or `user.email`) are altered for testing or automated tasks, agents must ALWAYS restore them to their original values immediately upon completion of the task.
