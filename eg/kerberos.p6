#!/usr/bin/env perl6

use v6;
use Kerberos;
use Data::Dump;

my $krb = Kerberos.new;

say '  Default realm: ' ~ $krb.default-realm;
say 'Default CC name: ' ~ $krb.cc-default-name;

my $p = $krb.parse-name(%?ENV<USERNAME>);
my $name = $krb.unparse-name($p);
$name.say;

