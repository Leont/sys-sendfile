package Sys::Sendfile;

use strict;
use warnings;

our $VERSION = '0.01';

use base qw/Exporter DynaLoader/;

our @EXPORT = qw/sendfile/;

bootstrap Sys::Sendfile $VERSION;

if (!defined &sendfile) {
	eval <<'ENDF';
	use Symbol qw/qualify_to_ref/;
	use Fcntl;
	sub sendfile(**;$) {
		my ($pre_out, $pre_in, $size) = @_;
		my ($out, $in) = map { qualify_to_ref($_ ) } $pre_out, $pre_in;
		sysread $in, my ($buffer), $size;
		syswrite $out, $buffer;
	}
ENDF
}

1;

__END__

=head1 NAME

Sys::Sendfile - Zero-copy data transfer

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

 sendfile $out, $in;

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 sendfile

=head1 AUTHOR

Leon Timmermans, C<< <leont at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sys-sendfile at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Sys-Sendfile>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Sys::Sendfile


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Sys-Sendfile>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Sys-Sendfile>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Sys-Sendfile>

=item * Search CPAN

L<http://search.cpan.org/dist/Sys-Sendfile>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Leon Timmermans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
