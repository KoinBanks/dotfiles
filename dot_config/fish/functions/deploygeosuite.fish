function deploygeosuite
    set local_path ~/develop/repos/mis/sw/ims/ims4/Web/src/main/webapp
    set remote_path /opt/ims/tomcat/webapps/ims
    set new_flag 0
    set user 'root'

    # Check for --user flag and --new flag
    set targets
    set i 1
    while test $i -le (count $argv)
        set arg $argv[$i]
        if test $arg = '--user'
            set i (math $i + 1)
            set user $argv[$i]
        else if test $arg = '--new'
            set remote_path /home/ims/web-deploy
            set new_flag 1
        else
            set targets $targets $arg
        end
        set i (math $i + 1)
    end

    for target in $targets
        # Create necessary directories on remote
        ssh $user@$target "mkdir -p $remote_path/js2/fragments/geosuite"
        ssh $user@$target "mkdir -p $remote_path/css2/fragments/geosuite"
        ssh $user@$target "mkdir -p $remote_path/js2/build/lib/thermodiagram"

        # Transfer the geosuite folder
        rsync -avz $local_path/js2/fragments/geosuite/ $user@$target:$remote_path/js2/fragments/geosuite/

        # Transfer the scss file
        rsync -avz $local_path/css2/fragments/geosuite/geoSuite.scss $user@$target:$remote_path/css2/fragments/geosuite/

        # Transfer the thermodiagram library
        rsync -avz $local_path/js2/build/lib/thermodiagram/ $user@$target:$remote_path/js2/build/lib/thermodiagram/
    end
end
