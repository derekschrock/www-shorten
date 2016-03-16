package WWW::Shorten;

use 5.006;
use strict;
use warnings;

use base qw(WWW::Shorten::generic);
use Carp ();

our $DEFAULT_SERVICE = 'TinyURL';
our @EXPORT          = qw(makeashorterlink makealongerlink);
our $VERSION         = '3.090';
$VERSION = eval $VERSION;

my $style;

sub import {
    my $class = shift;
    $style = shift;
    $style = $DEFAULT_SERVICE unless defined $style;
    my $package = "${class}::${style}";
    eval {
        my $file = $package;
        $file =~ s/::/\//g;
        require "$file.pm";
    };
    Carp::croak($@) if $@;
    $package->import(@_);
}

1;

=head1 NAME

WWW::Shorten - Interface to URL shortening sites.

=head1 SYNOPSIS

  use WWW::Shorten 'Linkz';
  use WWW::Shorten 'TinyURL';

  # Individual modules have have their
  # own syntactic variations.

  # See the documentation for the particular
  # module you intend to use for details, trips
  # and traps.

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

  # If you don't like the function names:
  use WWW::Shorten 'TinyURL', ':short';
  $short_url = short_link( $long_url );
  $long_url = long_link( $short_url );

=head1 ABSTRACT

A Perl interface to URL shortening sites. These sites maintain
databases of long URLs, each of which has a unique identifier.

=head1 DESCRIPTION

The function C<makeashorterlink> will call the relevant web site
passing it your long URL and will return the shorter version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full shortened URL or just the
identifier.

If anything goes wrong, then either function will return C<undef>.

=head1 Subroutines

=head2 import

Called when the module is C<use>d. Loads the correct sub-module

=head2 EXPORT

makeashorterlink, makealongerlink

Or, if you specify C<:short> on the import line, you instead
get C<short_link> and C<long_link>. If you explicitly want the
default set, use C<:default>.

Actually these functions are exported from the relevant subclass.

=head1 COMMAND LINE PROGRAM

A very simple program called F<shorten> is supplied in the
distribution's F<bin> folder. This program takes a URL and
gives you a shortened version of it.

=head1 EXAMPLES and PROGRAMS

Adam Kessel wrote F<shorlfilter>, a program that uses C<WWW::Shorten>
to filter a file, converting long URLs to short ones.

    http://adam.rosi-kessel.org/weblog/2003/09/07/shorlfilter

There is also a F<bin> directory in this distribution which contains a
sample program.

=head1 NO LONGER SUPPORTED

The URL-shortening industry is pretty volatile. Many sites exist for a
while and then go away. The most famous of those is probably Make A Shorter
Link (the site that originally inspired this suite of modules). http://MASL.com has
been acquired by http://TinyURL.com and no longer exists.

Here is a list of sites that were once supported by this module and are no
longer with us:

=over 4

=item http://MakeAShorterLink.com/

=item http://BabyURL.com/

=item http://EkDk.com/

=item http://Metamark.com/

=item http://qURL.com/

=item http://ShortLink.com/

=item http://SmLnk.com/

=item http://URLjr.com/

=item http://V3.com

=back

See Joshua Schachter's blog entry at
L<http://joshua.schachter.org/2009/04/on-url-shorteners.html> for some
very interesting discussion on some problems that can be caused by the
volatility of this part of the web industry.

=head1 RELATED MODULES

=head2 Similar Aim

L<WWW::MakeAShorterLink> is what this module was originally based upon.
That module is obsoleted by L<WWW::Shorten::MakeAShorterLink>, one of
the many subclasses of L<WWW::Shorten>. Of course, with the demise of
Make A Shorter Link, neither the obsolete module nor its replacement are
of any use.

=head2 Same Area, Different Purpose

L<CGI::Shorten> provides building blocks for you to create your own URL
shortening service. It provides routines to shorten a URL, lengthen one,
and it keeps a store. Nice and easy.

=head1 THANKS

Dave Cross for L<WWW::MakeAShorterLink>

Alex Page for the original LWP hacking on which Dave based his code.

Simon Batistoni for giving the C<makealongerlink> idea to Dave.

Eric Hammond for writing the L<WWW::Shorten::NotLong> variant.

Shashank Tripathi <shank@shank.com> for help with L<WWW::Shorten::SnipURL> .

Kevin Gilbertson (Gilby) supplied information on the TinyURL API.

Matt Felsen (mattf) wanted shorter function names.

Ask Bjoern Hansen for providing both Metamark.net and advice on the
module.

Martin Thurn for helping me notice a bug and for a suggestion regarding
L<WWW::Shorten::MASL>.

Jon and William (jon and wjr at http://smlnk.com respectively) for providing
http://SmLnk.com.

P J Goodwin for providing the code for L<WWW::Shorten::OneShortLink>.

And especial thanks to all providers of these services.

=head1 BUGS, REQUESTS, COMMENTS

Support for this module is supplied using the CPAN RT system via the web
or email:

    http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Shorten
    ( shorter URL: http://xrl.us/rfb )

    bug-www-shorten@rt.cpan.org

This makes it much easier for me to track things and thus means
your problem is less likely to be neglected.

=head1 LICENSE AND COPYRIGHT

WWW::Shorten::NotLong copyright (c) Eric Hammond <ehammond@thinksome.com>.

Other modules copyright (c) Magnum Solutions Ltd., 2007. All rights
reserved.

This module is free software.  You can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=head1 AUTHOR

Original Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorterLink by Dave Cross <dave@mag-sol.com>

In 2004 Dave Cross took over the maintenance of this distribution
following the death of Iain Truskett.

=head1 SEE ALSO

L<perl>, L<CGI::Shorten>.

=cut
