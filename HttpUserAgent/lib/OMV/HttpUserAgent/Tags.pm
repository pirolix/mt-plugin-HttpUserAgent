package OMV::HttpUserAgent::Tags;
# $Id$

use strict;
use warnings;
use MT;
use MT::Util;

use vars qw( $VENDOR $MYNAME $FULLNAME );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[0, 1]);

sub instance { MT->component($FULLNAME); }



### Common method for HTTP communication.
sub _http_request {
    my ($ctx, $args, $_method) = @_;

    my $url = $args->{url}
        or return $ctx->error (&instance->translate ("no URL specified"));
    if (defined $args->{query_string}) {
        $url .= ($url =~ /\?/ ? '?' : '&' ). $args->{query_string};
    }
    $args->{query_hash} ||= {};

    my $ua = MT->new_ua
        or return $ctx->error (&instance->translate ("Failed to retrieve MT::new_ua"));
    my $res = $ua->$_method ($url, %{$args->{query_hash}})
        or return $ctx->error (&instance->translate ("Network error ([_1])", __LINE__));
    if (!$res->is_success) {
        return defined $args->{on_error}
            ? $args->{on_error}
            : $ctx->error (&instance->translate ("Network error ([_1])", $res->status_line));
    }
    return Encode::decode (MT->config->PublishCharset, $res->content);
}



### <mt:HttpGet> function tag
sub HttpGet {
    my ($ctx, $args) = @_;

    return _http_request ($ctx, $args, 'get');
}

### <mt:HttpGetQuery> block tag
### <mt:HttpPost> block tag
sub HttpGetQuery {
    my ($ctx, $args, $cond) = @_;

    # build inner block
    defined (my $out = $ctx->slurp ($args, $cond))
        or return;
    # parse inner contents into key/value pairs
    my %query;
    foreach (split /[\r\n]/, $out) {
        my ($key, $val) = /^\s*(\S+)\s*=\s*(.*?)\s*$/;
        defined $key or next;
        $query{$key} = $val || '';
    }
    $args->{query_hash} = \%query;

    return $ctx->this_tag =~ /httpget/
        ? _http_request ($ctx, $args, 'get')
        : _http_request ($ctx, $args, 'post');
}

1;