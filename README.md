# Sys::Sendfile

## NOTE: Build.PL

Please note that the `Build.PL` file found in this repo is a template
and is not intended to be used directly. You should use `Dist::Zilla`
to manage the building of this software instead (see below).

## Dist::Zilla usage

The distribution is managed with `Dist::Zilla`
(https://metacpan.org/release/Dist-Zilla).  This means than many of
the usual files you might expect are not in the repository, but are
generated at release time (e.g. `Makefile.PL`).

`Dist::Zilla` is a very powerful authoring tool, but requires a number
of author-specific plugins.  If you would like to use it for
contributing, install it from CPAN, then run one of the following
commands, depending on your CPAN client:

    $ cpan `dzil authordeps --missing`

or

    $ dzil authordeps --missing | cpanm

You should then also install any additional requirements not needed by
the `dzil` build but may be needed by tests or other development:

    $ cpan `dzil listdeps --author --missing`

or

    $ dzil listdeps --author --missing | cpanm

Once installed, here are some dzil commands you might try:

    $ dzil build
    $ dzil test
    $ dzil test --release
    $ dzil xtest
    $ dzil listdeps --json
    $ dzil build --notgz

You can learn more about Dist::Zilla at http://dzil.org/.
