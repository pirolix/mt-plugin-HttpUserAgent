package MT::Plugin::Template::OMV::HttpUserAgent;
# HttpUserAgent (C) 2013 Piroli YUKARINOMIYA (Open MagicVox.net)
# This program is distributed under the terms of the GNU Lesser General Public License, version 3.
# $Id$

use strict;
use warnings;
use MT 5;

use vars qw( $VENDOR $MYNAME $FULLNAME $VERSION );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[-2, -1]);
(my $revision = '$Rev$') =~ s/\D//g;
$VERSION = 'v0.10'. ($revision ? ".$revision" : '');

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new ({
    id => $FULLNAME,
    key => $FULLNAME,
    name => $MYNAME,
    version => $VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    plugin_link => 'http://www.magicvox.net/archive/2013/09172046/', # Blog
    doc_link => "http://lab.magicvox.net/trac/mt-plugins/wiki/$MYNAME", # tracWiki
    description => <<'HTMLHEREDOC',
<__trans phrase="Description">
HTMLHEREDOC
    l10n_class => "${FULLNAME}::L10N",

    registry => {
        tags => {
            help_url => "http://lab.magicvox.net/trac/mt-plugins/wiki/$MYNAME#tag-%t",
            function => {
                HttpGet => "${FULLNAME}::Tags::HttpGet",
            },
            block => {
                HttpGetQuery => "${FULLNAME}::Tags::HttpGetQuery",
                HttpPost => "${FULLNAME}::Tags::HttpGetQuery",
                HttpPostQuery => "${FULLNAME}::Tags::HttpGetQuery",
            },
        },
    },
});
MT->add_plugin ($plugin);

sub instance { $plugin; }

1;