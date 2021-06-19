#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use Algorithm::Combinatorics qw(permutations);

my $string = "abc";

my @perms = map { join "", @$_ } permutations([split //, $string]);

say for @perms;
