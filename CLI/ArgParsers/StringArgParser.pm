#!/usr/bin/perl

use strict;
use warnings;

package CLI::ArgParsers::StringArgParser;
use parent "CLI::ArgParsers::ArgParser";

sub _init {
	my $self = shift @_;
	$self->SUPER::_init(@_);
	my $args = shift @_;
	
	$self->{type}='string';

	if( defined($args) and defined($args->{strings})) {
		$self->{_strings_to_match} = $args->{strings};
	}
}

sub parse { 
	my $self = shift (@_);
	my $arg = shift(@_);
	#if we haven't defined strings to match then any string will do
	unless (defined($self->{_strings_to_match} )) {
		return $arg;
	}
	
	foreach my $string (@{$self->{_strings_to_match}}) {
		if (lc($arg) eq lc($string)) {
			return $arg;
		}
	}

	my $msg = "$self->{name} \"$arg\" did not match any of the following options:\n\t";
	foreach my $string (@{$self->{_strings_to_match}}) {
		$msg .= "$string\n\t";
	}
	$msg =~ s/\n\t$/\n/;
	die($msg);
}

1;
