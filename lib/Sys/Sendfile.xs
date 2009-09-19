/*
 * This software is copyright (c) 2008, 2009 by Leon Timmermans <leont@cpan.org>.
 *
 * This is free software; you can redistribute it and/or modify it under
 * the same terms as perl itself.
 *
 */

#if defined (__SVR4) && defined (__sun)
#define __solaris__
#endif

#if defined linux || defined solaris
#include <sys/sendfile.h>
#elif defined (__FreeBSD__) || defined (__APPLE__)
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/uio.h>
#endif
#include <unistd.h>

#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#if !defined __linux__ && !defined __solaris__ && !defined __FreeBSD__ && !defined __APPLE__

#ifdef __GNUC__
#error Your operating system appears to be unsupported
#else
Your operating system appears to be unsupported;
#endif

#endif

MODULE = Sys::Sendfile				PACKAGE = Sys::Sendfile

SV*
sendfile(out, in, count = 0, offset = &PL_sv_undef)
	int out = PerlIO_fileno(IoOFP(sv_2io(ST(0))));
	int in  = PerlIO_fileno(IoIFP(sv_2io(ST(1))));
	size_t count;
	SV* offset;
	PROTOTYPE: **@
	CODE:
	off_t real_offset = SvOK(offset) ? SvUV(offset) : lseek(in, 0, SEEK_CUR);
#if defined linux || defined __solaris__
	if (count == 0) {
		struct stat info;
		if (fstat(in, &info) == -1) 
			XSRETURN_EMPTY;
		count = info.st_size - real_offset;
	}
	{
		ssize_t success = sendfile(out, in, &real_offset, count);
		if (success == -1)
			XSRETURN_EMPTY;
		else
			XSRETURN_IV(success);
#elif defined __FreeBSD__
	{
		off_t bytes;
		int ret = sendfile(in, out, real_offset, count, NULL, &bytes, 0);
		if (ret == -1 && ! (errno == EAGAIN || errno == EINTR))
			XSRETURN_EMPTY;
		else
			XSRETURN_IV(bytes);
#elif defined __APPLE__
	{
		off_t bytes = count;
		int ret = sendfile(in, out, real_offset, &bytes, NULL, 0);
		if (ret == -1 && ! (errno == EAGAIN || errno == EINTR))
			XSRETURN_EMPTY;
		else
			XSRETURN_IV(bytes);
#endif
	}
