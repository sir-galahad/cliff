#!/usr/bin/perl

use strict;
use warnings;

package CLI::ArgParsers::IntArgParser;
use parent "CLI::ArgParsers::ArgParser";

#sub new {
#	my $class = shift @_;

#	my $instance = {};

#	bless $instance, $class;

#	$instance->_init(@_);
#	return $instance;
#}

sub _init {
	my $self = shift @_;
	$self->SUPER::_init(@_);
	my $args = shift @_;
	$self->{type} = "integer";
	$self->{_max_int} = $args->{max_int};
	$self->{_min_int} = $args->{min_int};
}

sub parse { 
	my $self = shift (@_);
	my $arg = shift(@_);
	#make sure our argument is an int
	unless ( $arg =~ /^-?[1-9]\d*$/) {
		die("$self->{name} : Argument supplied is not a valid integer\n");
	}
	#make sure our argument is less than or equal to max allowable
	if ( defined($self->{_max_int}) and $arg > $self->{_max_int} ) {
		die("$self->{name} : Interger greater than maximum allowed ($self->{_max_int})\n");
	}
	#make sure our argument is greater than or equal to min allowable
	if ( defined($self->{_min_int}) and $arg < $self->{_min_int} ) {
		die("$self->{name} : Interger less than minimum allowed ($self->{_min_int})\n");
	}
	return $arg;
}

1;
