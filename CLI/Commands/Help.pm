#!/usr/bin/perl

package CLI::Commands::Help;
use strict;
use warnings;
use lib "/home/aaron/projects/cli/";
require CLI::Commands::Command;

use parent 'CLI::Commands::Command';

sub _init {
	my $self = shift @_;

	$self->{help} = "command help";
	$self->{args} = "argument objects here";
	$self->{name} = "help";

}

sub command {
	print "help  here\n";
}

1;
