#if defined linux || defined solaris
#include <sys/sendfile.h>
#elif defined freebsd
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/uio.h>
#endif
#include <unistd.h>

#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

MODULE = Sys::Sendfile				PACKAGE = Sys::Sendfile

#if defined linux || defined solaris || defined freebsd
SV*
sendfile(out, in, size = 0)
	int out = PerlIO_fileno(IoOFP(sv_2io(ST(0))));
	int in  = PerlIO_fileno(IoIFP(sv_2io(ST(1))));
	size_t size;
	PROTOTYPE: **;$
	CODE:
#if defined linux || defined solaris
	if (size == 0) {
		struct stat info;
		if (fstat(in, &info) == -1) 
			XSRETURN_UNDEF;
		size = info.st_size - lseek(in, 0, SEEK_CUR);
	}
	{
	ssize_t success = sendfile(out, in, NULL, size);
	if (success == -1)
		XSRETURN_UNDEF;
	else
		XSRETURN_IV(success);
#elif defined freebsd
	{
	off_t bytes;
	int ret = sendfile(out, in, lseek(in, 0, SEEK_CUR), size, NULL, &bytes, 0);
	if (ret == -1)
		XSRETURN_UNDEF;
	else
		XSRETURN_IV(bytes);
#endif
	}

#endif
