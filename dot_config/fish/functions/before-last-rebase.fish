function before-last-rebase
    set -l target (git reflog --format='%H%x09%gs' | awk -F '\t' '
        /rebase \(start\)/ { found=1; next }
        found { print $1; exit }
    ')

    if test -z "$target"
        echo "No rebase found in the HEAD reflog." >&2
        return 1
    end

    git reset --keep "$target"
end
