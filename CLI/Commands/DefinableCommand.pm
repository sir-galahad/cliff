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
	$self->{command} = $cmd->{command};
	$self->{data} = $cmd->{data};
}

sub command {
	my $self = shift @_;
	my $args = shift @_;
	$self->{command}($args, $self->{data});
}

1;
