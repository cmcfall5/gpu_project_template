#!/bin/bash
# Creates a GPU project

dir=$2
proj_name=$1
proj_dir="$2/$1"
echo "Creating GPU project at $proj_dir"

success=$(mkdir "$proj_dir")
# TODO check success

scriptpath=$(dirname $(realpath -s $0))
template_dir="$scriptpath/template"
new_src_dir="$proj_dir/src"

success=$(cp -r $template_dir/* $proj_dir)
# TODO check success

success=$(mv $new_src_dir/main.c $new_src_dir/$proj_name.c)
# TODO check success

sed_str="s/PROJ_NAME_PLACEHOLDER/$proj_name/g"
success=$(sed -i $sed_str $proj_dir/Makefile)
# TODO check success

success=$(sed -i $sed_str $proj_dir/run.sh)
# TODO check success