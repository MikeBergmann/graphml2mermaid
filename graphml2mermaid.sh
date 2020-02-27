#!/bin/bash

# Copyright 2019 Mike Bergmann, mike@mdb977.de
# Released under the MIT License 

set -e
set -u
set -o pipefail

function show_help
{
	echo
	echo $(basename "$0") [option] graphmlfile
	echo
	echo "Converts a graphml dependency file to mermaid syntax for GitLab; outputs on stdout or view it in browser"
	echo
	echo "Options:"
	echo "  -v|--view   View the mermaid within browser."
	echo
}

function convert
{
	echo 'graph TD;'
	xml_grep 'edge' ${1} | grep -P 'edge.*source' | sed -nr 's/.*=\"(.*)\".*\"(.*)\".*/\1-->\2/p'
}

function view
{
	local DATA
	DATA=$(echo -n '{"code":"';convert ${1} | sed -z 's/\n/\\n/g;s/\\n$/\n/' ;echo -n '","mermaid":{"theme":"default"}}')
	DATA=$(echo $DATA | base64 | tr '+' '-')
	xdg-open 'https://mermaidjs.github.io/mermaid-live-editor/#/view/'"${DATA}"
}

function main
{
	if [ $# -eq 0 ]
	then
		show_help
		exit
	fi

	local VIEWMODE=0
	local FILE

	while [ $# -gt 0 ]
	do
		local KEY="$1"
		case ${KEY} in
			-v|--view)
				shift # past argument
				VIEWMODE=1
				;;
			-h|--help)
				show_help
				exit
				;;
			*)
				FILE="$1"
				shift # past argument
				;;
		esac
	done

	if [ ${VIEWMODE} -eq 1 ]
	then
		view ${FILE}
		exit
	fi

	echo '```mermaid'
	convert ${FILE}
	echo '```'
}


main "$@"
