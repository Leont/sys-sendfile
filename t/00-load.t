#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Sys::Sendfile' );
}

diag( "Testing Sys::Sendfile $Sys::Sendfile::VERSION, Perl $], $^X" );
