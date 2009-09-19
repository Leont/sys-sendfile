use 5.006;
use strict;
use warnings;
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
    meta_merge => {
        resources       => {
            bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Sys-Sendfile',
			repository  => 'http://github.com/Leont/sys-sendfile',
        },
        keywords        => [ 'sendfile', 'zero-copy' ],
    },
    add_to_cleanup      => [ 'Sys-Sendfile-*' ],
    create_makefile_pl  => 'passthrough',
    sign                => 1,
);

$builder->extra_linker_flags('-lsendfile') if $^O eq 'solaris';

$builder->create_build_script();
