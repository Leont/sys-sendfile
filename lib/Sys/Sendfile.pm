package Sys::Sendfile;

# This software is copyright (c) 2008, 2009 by Leon Timmermans <leont@cpan.org>.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as perl itself.

use strict;
use warnings;

our $VERSION = '0.10';

use base qw/Exporter/;
use XSLoader;

##no critic ProhibitAutomaticExportation
our @EXPORT = qw/sendfile/;

XSLoader::load('Sys::Sendfile', $VERSION);

1;

__END__

=head1 NAME

Sys::Sendfile - Zero-copy data transfer

=head1 VERSION

Version 0.10

=cut

=head1 SYNOPSIS

 use Sys::Sendfile;
 sendfile $sink, $source, $count;

=head1 DESCRIPTION

Sys::Sendfile provides access to your operating system's C<sendfile> facility. It allows you to efficiently transfer data from one filehandle to another. Typically the source is a file on disk and the sink is a socket, and some operating systems may not even support other usage.

=head1 FUNCTIONS

=head2 sendfile $out, $in, $count

This function sends up to C<$count> B<bytes> from C<$in> to C<$out>. If $count isn't given, it will send all remaining bytes in $in. C<$in> and C<$out> can be a bareword, constant, scalar expression, typeglob, or a reference to a typeglob. It returns the number of bytes actually sent. On error, C<$!> is set appropriately and it returns undef. This function is exported by default.

=head1 AUTHORS

Leon Timmermans, C<< <leont at cpan.org> >> wrote the Linux FreeBSD and Solaris code.

Kazuho Oku C<< <kazuhooku@gmail.com> >> wrote the Mac OS X code.

=head1 BUGS AND LIMITATIONS

Not all operating systems support sendfile(). Currently Linux, FreeBSD, Solaris, Mac OS X and Windows are supported.

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

=head1 SEE ALSO

sendfile(2) - Your manpage on sendfile

L<IO::Sendfile> - A sendfile implementation for Linux

L<Sys::Syscall> - Another sendfile implementation for Linux

L<Sys::Sendfile::FreeBSD> - A module implementing the FreeBSD variant of sendfile 

=head1 COPYRIGHT AND LICENSE

Copyright 2009 Leon Timmermans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
