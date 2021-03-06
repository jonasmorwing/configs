#!/bin/bash
# This file has a function called git and is used to wrap the msys-git call so that it can be called from cygwin
#TRACE_ON="GIT_TRACE_PERFORMANCE=true GIT_TRACE=true"
#TRACE_OFF="GIT_TRACE_PERFORMANCE=false GIT_TRACE=false"
MSYSGIT_AND_TOOLS_PATH="/cygdrive/c/Program Files/Git/bin:/usr/local/bin:/usr/bin:/home/Jonas_Morwing/bin:/cygdrive/c/Windows/system32" 
NETRC_HOME="/cygdrive/c/Users/Jonas_Morwing"

# Having git as a function rather than a shell script file removes overhead and reduces calltime of git with 0.5-1s, especially noteable with git-prompt
# Now the call time is in line with a git-bash terminal (still diff-analyis takes much more time than for previous git...)
git ()
{
	local myArgs
	set -f # Avoid shell expansion here if the argument contains * for example

	#for arg in "$@"
	for ((i=1;i<=$#;i++)); 
	do
		local mingwArg
		# Translate arguments with /cygdrive/d to d:/ for example (required for absolute paths such as to orderfile in diff analysis)	
		# But don't translaste git paths such as <version>:<git_path> or just :<git_path> (such as just in diff_analysis)
		re='/cygdrive/(.?)/(.*)'
		if [[ ${!i} =~ $re ]]; then
			mingwArg="${BASH_REMATCH[1]}:/${BASH_REMATCH[2]}"  
		else 
			mingwArg=${!i}
		fi

		#mingwArg="${!i/\/cygdrive\//\/}"
		#if [[ $string != *":"* ]]; then
		#	mingwArg=`cygpath -m -- ${!i}`
		#else
		#	mingwArg="${!i/\/cygdrive\//\/}"
	  	#	mingwArg=${!i}
		#fi	
		#mingwArg=`echo ${!i} | perl -pe 's{/cygdrive/(.*?)/}{\1:/}'`
		#echo "${!i} -> $mingwArg"
		myArgs[$i]=$mingwArg
	done
	#echo "${myArgs[@]}"

	local GIT_RETVAL
	local INTERACTIVE_CMDS='|mergetool|difftool|'  # Surround with |
	export -f -n git  # For the next subshells, don't export this git-function, since we want msys-git to use the actual msys-git executable for sub-calls to git
	if [[ "$INTERACTIVE_CMDS" == *"|$1|"* ]];
	then 
		HOME=$NETRC_HOME PATH=$MSYSGIT_AND_TOOLS_PATH "/cygdrive/c/Program Files/Git/bin/git.exe" "${myArgs[@]}"
		GIT_RETVAL=$?
	else
		HOME=$NETRC_HOME PATH=$MSYSGIT_AND_TOOLS_PATH "/cygdrive/c/Program Files/Git/bin/git.exe" "${myArgs[@]}" | less -XRF
		GIT_RETVAL=${PIPESTATUS[0]}
	fi
	export -f git  # Export git to subshells again

	set +f
	return $GIT_RETVAL
}
export -f git  # Export git to subshells
