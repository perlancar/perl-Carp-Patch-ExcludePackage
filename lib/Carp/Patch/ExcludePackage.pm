package Carp::Patch::ExcludePackage;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
no warnings;

use Module::Patch;
use base qw(Module::Patch);

our %config;

my $p_source_trace = sub {
};

sub patch_data {
    return {
        v => 3,
        config => {
            -exclude_pat => {
                schema => 're*',
            },
            -include_pat => {
                schema => 're*',
            },
            -show_excluded => {
                schema => 'bool*',
            },
        },
        patches => [
            {
                action      => 'replace',
                sub_name    => 'source_trace',
                code        => $p_source_trace,
            },
        ],
   };
}

1;
# ABSTRACT: Exclude some packages from source trace

=for Pod::Coverage ^()$

=head1 SYNOPSIS

 % PERL5OPT=-MDevel::Confess::Source::Patch::ExcludePackage=-exclude_pat,'^MyApp::' -d:Confess=dump yourscript.pl


=head1 DESCRIPTION


=head1 CONFIGURATION

=head2 -exclude_pat

Regexp pattern. If this is specified then packages matching this regexp pattern
will not be shown in stack traces.

=head2 -include_pat

Regexp pattern. If this is specified then only package matching this regexp
pattern will be shown in stack traces.

=head2 -show_excluded

Bool. If set to true, will show:

 Skipped stack trace level (package $FOO)

lines for excluded stack trace level.

=head1 SEE ALSO
