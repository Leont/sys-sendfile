package Sys::Sendfile;

# This software is copyright (c) 2008, 2009 by Leon Timmermans <leont@cpan.org>.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as perl itself.

use strict;
use warnings;

use base qw/Exporter/;
use XSLoader;

##no critic ProhibitAutomaticExportation
our @EXPORT = qw/sendfile/;

XSLoader::load('Sys::Sendfile', __PACKAGE__->VERSION);

1;

# ABSTRACT: Zero-copy data transfer

=head1 SYNOPSIS

 use Sys::Sendfile;
 sendfile $sink, $source, $count;

=head1 DESCRIPTION

Sys::Sendfile provides access to your operating system's C<sendfile> facility. It allows you to efficiently transfer data from one filehandle to another. Typically the source is a file on disk and the sink is a socket, and some operating systems may not even support other usage.

=func sendfile $out, $in, $count

This function sends up to C<$count> B<bytes> from C<$in> to C<$out>. If $count isn't given, it will send all remaining bytes in $in. C<$in> and C<$out> can be a bareword, constant, scalar expression, typeglob, or a reference to a typeglob. It returns the number of bytes actually sent. On error, C<$!> is set appropriately and it returns undef. This function is exported by default.

=head1 CONTRIBUTORS

Kazuho Oku C<< <kazuhooku@gmail.com> >> wrote the Mac OS X code.

=head1 BUGS AND LIMITATIONS

Not all operating systems support sendfile(). Currently Linux, FreeBSD, Solaris, Mac OS X (version 10.5 and up) and Windows are supported.

=head1 SEE ALSO

sendfile(2) - Your manpage on sendfile

L<IO::Sendfile> - A sendfile implementation for Linux

L<Sys::Syscall> - Another sendfile implementation for Linux

L<Sys::Sendfile::FreeBSD> - A module implementing the FreeBSD variant of sendfile 

