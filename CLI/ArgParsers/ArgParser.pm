#!/usr/bin/perl

use strict;
use warnings;
package CLI::ArgParsers::ArgParser;

sub new {
	my $class = shift @_;

	my $instance = {};

	bless $instance, $class;

	$instance->_init(@_);
	return $instance;
}

sub _init {
	my $self = shift @_;
	my $args = shift @_;
	$self->{name} = $args->{name};
	$self->{_wordsUsed} = 1;
	$self->{_isOptional}= $args->{isOptional};
}



sub parse { # do something
	print "hello, world\n";
}

sub getWordsUsed {
	my $self = shift @_;
	return $self->{_wordsUsed};
}

sub isOptional {
	my $self = shift @_;
	return $self->{_isOptional};
}

sub getSyntax {
	my $self = shift @_ ;
	return "<$self->{name}:$self->{type}>";
}

1;
