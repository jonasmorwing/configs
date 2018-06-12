README for myDiff

The myDiff script can be used as a tool for diffing git files.
It is currently  especially useful for "profiling diffs", which is automatically triggered depending on the file path.
Installation
1) Copy myDiff to any path (perhaps C:/Cygwin/bin)
2) Edit the paths to the diffing tools and viewers in the top-section of myDiff
3) Modify your .gitconfig to select myDiff as your tool for external diffs and as your "difftool"
   The following is a suggestion for modifications in the .gitconfig file to enable myDiff

[diff]
	tool = myDiffAsTool
	external = "C:/cygwin/bin/perl C:/Cygwin/bin/myDiff"
[difftool "myDiffAsTool"]
 	#Specified perl version in case embedded git otherwise takes from "Atlassian/git mingw perl"
	cmd = "C:/cygwin/bin/perl C:/Cygwin/bin/myDiff" -tool $LOCAL $REMOTE

...that is if myDiff is put in cygwin/bin, otherwise change the path



/Jonas Morwing

