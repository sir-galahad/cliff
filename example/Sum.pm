#!/usr/bin/perl

use strict;
use warnings;
use CLI::Commands::DefinableCommand;
package Sum;

use CLI::ArgParsers::IntArgParser;

use parent 'CLI::Commands::Command';

sub makecommand {
	my $cmd; 
	$cmd->{help} = "Sum 2 or 3 passed in integers";
	$cmd->{args} = [
		CLI::ArgParsers::IntArgParser->new( {name => "int1"} ),
		CLI::ArgParsers::IntArgParser->new( {name => "int2"} ),
		CLI::ArgParsers::IntArgParser->new( {name => "int3", isOptional => 1} ),
	];
	$cmd->{name} = "sum";
	$cmd->{command} = \&command;
	CLI::Commands::DefinableCommand->new($cmd);
}

sub command {
	my $args = shift @_;
	my $sum = $args->{int1} + $args->{int2};
	$sum += $args->{int3} if(defined($args->{int3}));
	print "$sum\n";
}

1;
