#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Rationale : Show a 3-way diff of a given file."
    echo "Usage : $(basename $0) commit1 commit2 base filename"
    echo "Usage : $(basename $0) commit1 commit2 filename   ... then base is taken from git merge-base"
    exit -1
fi

# Test e.g. with https://github.com/git/git/commit/8cde60210dd01f23d89d9eb8b6f08fb9ef3a11b8
ver1=$1
ver2=$2
sha1=$(git rev-parse $ver1)
sha2=$(git rev-parse $ver2)
if [ $# -lt 4 ]; then
	shaBase=$(git merge-base $ver1 $ver2)
	verBase=merge-base_$shaBase
	file=$3
else
	verBase=$3
	shaBase=$(git rev-parse $verBase)
	file=$4
fi

echo "file $file"

if [ -z $(git diff --name-only $sha1 $file) ]; then
	tmp1=$file
else
	tmp1=$(mktemp -t $(basename $file).XXX)
	git show $sha1:$file > $tmp1
fi
echo "tmp1 $tmp1"
tmp2=$(mktemp -t $(basename $file).$sha2.XXX)
echo "tmp2 $tmp2"
git show $sha2:$file > $tmp2

tmpBase=$(mktemp -t $(basename $file).$shaBase.XXX)
git show $shaBase:$file > $tmpBase
echo "tmpBase $tmpBase"

echo paths $tmp1 $tmp2 $tmpBase $tmp1
winTmp1=$(cygpath -wla $tmp1 | tr -d '\n')
winTmp2=$(cygpath -wla $tmp2 | tr -d '\n')
winTmpBase=$(cygpath -wla $tmpBase | tr -d '\n')
winOut=$(cygpath -wla $file | tr -d '\n')
winPaths="$winTmp1 $winTmp2 $winTmpBase $winOut"

'C:/Program Files (x86)/Beyond Compare 4/BComp.exe' /lefttitle=$ver1 /righttitle=$ver2 /centertitle=$verBase /center=$winTmpBase $winPaths 

#'C:/Program Files (x86)/Beyond Compare 4/BComp.exe' \"$tmp1\" \"$tmp2\" \"$tmpBase\" \"$tmp1\"

#diffuse -r $sha1 -r $shaBase -r $sha2 $file
