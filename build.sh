#!/bin/bash

# Process parameters
params="$(getopt -o d:e:fshv \
    -l diff:,exclude:,force,skip-existing,help,verbose \
    --name "$cmdname" -- "$@")"

if [ $? -ne 0 ]
then
    usage
fi

eval set -- "$params"
unset params

while true
do
    case $1 in
        -d|--diff)
            diff_exec=(${2-})
            shift 2
            ;;
        -e|--exclude)
            # Will override $default_excludes
            excludes+=("${2-}")
            shift 2
            ;;
        -f|--force)
            action='R'
            shift
            ;;
        -s|--skip-existing)
            action='S'
            shift
            ;;
        -h|--help)
            usage
            exit
            ;;
        -v|--verbose)
            verbose='--verbose'
            shift
            ;;
        --)
            shift
            if [ -z "${1:-}" ]
            then
                error "Missing targets." "$help_info" $EX_USAGE
            fi
            if [ -z "${2:-}" ]
            then
                error "Missing directory." "$help_info" $EX_USAGE
            fi
            targets=(${@:1:$(($#-1))})
            source_dir="${@:$#}"
            break
            ;;
        *)
            usage
            ;;
    esac
done


# Remove old image


if [[ "$(docker images -q myimage:mytag 2> /dev/null)" == "" ]]; then
  # do something

fi