function writehours
	argparse 't/task=' 'h/hours=' -- $argv
	or return

	if not set -q _flag_task; or not set -q _flag_hours
		echo "Usage: writehours --task <task> --hours <hours>"
		return 1
	end

	set -l prev_dir (pwd)
	cd ~/develop/repos/writehours
	pnpm tsx index.ts --task $_flag_task --hours $_flag_hours
	cd $prev_dir
end
