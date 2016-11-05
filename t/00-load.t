#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'WebService::Formstack' ) || print "Bail out!\n";
}

diag( "Testing WebService::Formstack $WebService::Formstack::VERSION, Perl $], $^X" );
