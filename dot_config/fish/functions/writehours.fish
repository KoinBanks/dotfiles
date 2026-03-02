function writehours
	cd ~/develop/repos/writehours
	bun run index.ts $argv
	cd $prev_dir
end
