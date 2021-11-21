#!/usr/bin/perl

use strict;
use warnings;

use lib "../";
use lib "./";
use CLI;
use CLI::Commands::Command;
use CLI::Commands::Help;
use Sum;

my $bleh = CLI::App->new();
$bleh->addCommand(Sum::makecommand());
$bleh->startCLI();
