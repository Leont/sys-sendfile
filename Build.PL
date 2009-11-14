use 5.006;
use strict;
use warnings;
use Config;
use Module::Build;

my $builder = Module::Build->new(
	module_name         => 'Sys::Sendfile',
	license             => 'perl',
	dist_author         => 'Leon Timmermans <leont@cpan.org>',
	dist_version_from   => 'lib/Sys/Sendfile.pm',
	build_requires => {
		'ExtUtils::CBuilder' => 0,
		'Test::More' => 0,
	},
	requires => {
		perl			=> 5.006,
	},
	meta_merge => {
		resources	   => {
			bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Sys-Sendfile',
			repository  => 'http://github.com/Leont/sys-sendfile',
		},
		keywords		=> [ 'sendfile', 'zero-copy' ],
	},
	add_to_cleanup	  => [ 'Sys-Sendfile-*' ],
	create_makefile_pl  => 'passthrough',
	sign				=> 1,
);

if ($^O eq 'MSWin32') {
	my $cc = $Config{cc};
	my $type = ($cc =~ /cl(\.exe)?$/ ? 'MSVC' : $cc =~ /bcc32(\.exe)?$/ ? 'BCC' : 'GCC');
	$builder->extra_linker_flags('mswsock.lib') if $type eq 'MSVC';
	$builder->extra_linker_flags('-lmswsock') if $type eq 'GCC';
}
elsif ($^O eq 'solaris') {
	$builder->extra_linker_flags('-lsendfile');
}

$builder->create_build_script();
