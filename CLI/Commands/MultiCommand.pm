#!/usr/bin/perl

use strict;
use warnings;
require CLI::Commands::Command;
package CLI::Commands::DefinableCommand;

use parent 'CLI::Commands::Command';

sub _init {
	my $self = shift @_;
	my $cmd = shift @_;

	$self->{help} = $cmd->{help};
	$self->{args} = $cmd->{args};
	$self->{name} = $cmd->{name};
	$self->{data} = $cmd->{data};
	$self->{subcommands} = {};
	$self->{multicommand} = 1;
	my @subCmdNames;
	foreach (@{$cmd->{subcommands}}) {
		$self->{subcommands}->{$_->{name}} = $_;
		push(@subCmdnames,$_->{name});
		
	}
	
	$self->{args} => [CLI::ArgParsers::StringArgParser->new( {name => "subcommand", strings=>\@cmdNames} )],
}

sub command {
	my $self = shift @_;
	my $args = shift @_;
	$self->{command}($args, $self->{data});
}

sub getSyntax {
	my $self = shift @_;

	my @syntax;
	foreach my $subCmd (@{$self->{args}}) {
		$msg = "$self->{name} $subCmd->{name} ". $subCmd->{getSyntax}();
		push(@syntax, $msg);
	}
	return @syntax;
}
1;
