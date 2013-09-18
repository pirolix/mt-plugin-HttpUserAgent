package OMV::HttpUserAgent::L10N::ja;
# $Id$

use strict;
use base 'OMV::HttpUserAgent::L10N';
use vars qw( %Lexicon );

%Lexicon = (
    # *.pl
    "Supply template tags to retrieve the contents with HTTP/HTTPS communications." => "HTTP/HTTPS 通信でコンテンツを取得するテンプレートタグを提供します。",
    # Tags.pm
    "no URL specified" => "URL が指定されていません。",
    "Failed to retrieve MT::new_ua" => "MT::new_ua の取得に失敗しました。",
    "Network error ([_1])" => "通信エラー ([_1])",
);

1;