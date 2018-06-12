#!/usr/bin/env perl

use strict;

my @winFileArgs;

foreach my $arg (@ARGV)
{
	my $cygFile = $arg;
	my $lineArg = '';
	if ($arg =~ m/(.*)(:.*)/) {
		$cygFile = $1;
		$lineArg=$2; 
	}
	my $winFile = `cygpath -w "$cygFile"`;
	chomp $winFile;
	push @winFileArgs, "\"$winFile$lineArg\"";
}

my $sublimeExe = '/cygdrive/c/Program\ Files/Sublime\ Text\ 2/sublime_text.exe';
my $cmd = sprintf("bash -c '$sublimeExe -n -w %s'",
	join(' ',@winFileArgs));
print("$cmd\n");
system($cmd)==0 or die "Cmd $cmd failed: $?\n";
