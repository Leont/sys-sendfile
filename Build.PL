use strict;
use warnings;
use Config;
use Module::Build;

my $builder = Module::Build->new(
  module_name         => 'Sys::Sendfile',
  ##{ $plugin->get_prereqs ##}
  ##{ $plugin->get_default('share_dir') ##}
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
elsif($^O eq 'gnukfreebsd') {
	$builder->extra_compiler_flags('-I/usr/include/freebsd');
	$builder->extra_linker_flags('-lfreebsd-glue');
}

$builder->create_build_script();
