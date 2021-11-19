#!/usr/bin/perl

use strict;
use warnings;
package CLI::Commands::Command;

sub new {
	my $class = shift @_;

	my $instance = {};

	bless $instance, $class;

	$instance->_init(@_);
	return $instance;
}

sub _init {
	my $self = shift @_;

	#$self->{help} = "command help";
	#$self->{args} = "argument objects here";
	#$self->{name} = "commandname";

}

sub command { # do something
	print "hello, world\n";
}

sub getSyntax {
	my $self = shift @_;
	my $msg = "$self->{name}";
	foreach my $argParser (@{$self->{args}}) {
		if($argParser->isOptional) {
			$msg.= (" [".$argParser->getSyntax()."]");
		} else { 
			$msg.= (" ".$argParser->getSyntax());
		}
	}
	return $msg;
}
1;
