#!/usr/bin/perl

use strict;
use warnings;
use CLI::Commands::DefinableCommand;
use CLI::ArgParsers::StringArgParser;
package CLI::App;

sub new {
	my $self = {
		commands => {},
	};
	return bless $self;
}

sub startCLI {
	my $self = shift @_;
	
	#add help command before starting to parse commands
	my @cmdNames;
	foreach my $cmd (sort keys %{$self->{commands}}) {
		push @cmdNames, $cmd;
	}
	push @cmdNames, "help";
	my $helpCmd = {
		name => 'help',
		help => 'Get help for other commands',
		command => \&helpCommand,
		args => [CLI::ArgParsers::StringArgParser->new( {name => "command", strings=>\@cmdNames, isOptional=>1} )],
		data => $self,
	};

	$self->addCommand( CLI::Commands::DefinableCommand->new($helpCmd));
	while(<>) {
		my @args = split(/\s+/,$_);
		my $command = undef;
		$command = getCommand($self,$args[0]) if (defined ( $args[0] ));
		if (defined($command)) {
			shift @args;
			my %argject; #arg object get it?

			eval {
ARGLOOP:		foreach my $argParser ( @{$command->{args}}) {
					my $result;
					my $argject;
					eval {
						if(@args>0) {
							$result = $argParser->parse(@args);
							$argject{$argParser->{name}} = $result;
						}
					};
					if($@) {
						if ($argParser->isOptional()) {
							next ARGLOOP;
						} else {
							die $@;
						}
					}
					my $argWords = $argParser->getWordsUsed();
					if($argWords < 0) {
						die ("Arg Parser $argParser->{name} claims to use $argWords argWords, this is impossible!\n");
					}
					for( my $i = 0; $i < $argWords; $i++) {
						shift @args;
						last ARGLOOP if( @args == 0 );
					}

				}
			};
			if ($@) {
				print $@."\n";
			} else {
				if(@args == 0) {
					$command->command(\%argject);
				} else {
					print "Too many arguments for command $command->{name} or \"@args\" didn't match optional arguments\n";
				}
			}
		}
	}
}

sub addCommand {
	my $self = shift @_;
	my $commandObj = shift @_;
	$self->{commands}->{$commandObj->{name}}=$commandObj;
}

sub getCommand {
	my $self = shift @_;
	my $command = shift @_;
	return $self->{commands}->{$command};
}

sub parse {
	
	my $self = shift @_;
	my $command = shift @_;
	my @args = @_;

}

sub helpCommand {
	my $args = shift @_;
	my $self = shift @_;
	unless( defined ($args) and defined($args->{command})) {
		print "\nAvaialble commands: \n\n";
		foreach my $cmd (values %{$self->{commands}} ) {
			print ($cmd->getSyntax()."\n");		
		}
	} else {
		my $cmd = getCommand($self,$args->{command}) if (defined ( $args->{command} ));
		print "\n". $cmd->getSyntax()."\n\n";
		print $cmd->{help}."\n\n";
		
	}
}

1;
