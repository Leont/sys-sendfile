#!perl -T

use strict;
use warnings;
use Socket;
use Test::More tests => 2;
use Sys::Sendfile;

socketpair my ($in), my ($out), AF_UNIX, SOCK_STREAM, PF_UNSPEC;

open my $self, '<', $0 or die "Couldn't open self: $!";
my $slurped = do { local $/; <$self> };
seek $self, 0, 0;

sendfile $out, $self, -s $self or diag("Couldn't sendfile(): $!");
read $in, my $read, -s $self;

is($read, $slurped, "Read the same as was written");

seek $self, 0, 0;

sendfile $out, $self or diag("Couldn't sendfile(): $!");
read $in, $read, -s $self;

is($read, $slurped, "Read the same as was written");
