use v6;

unit class Kerberos:auth<github:ioanrogers>:ver<*>;

use NativeCall;
use Kerberos::Raw;
use Data::Dump;

has Pointer $!ctx;

submethod BUILD {
    say "initialising krb5 context";
    my $ctx = Pointer.new;
    my $r = krb5_init_context($ctx);
    die "Failed to initialise kerberos, error $r" unless $r == 0;
    $!ctx = $ctx;
}

submethod DESTROY {
    say "FREEing";
    my $r = krb5_free_context($!ctx);
    say $r;
    return;
}

method default-realm() returns Str {

    # Couldn't get Str to work, found this CArray business in
    # https://github.com/hartenfels/Text-Markdown-Discount
    my $realm = CArray[Str].new;
    $realm[0] = Str;

    my $r = krb5_get_default_realm($!ctx, $realm);
    if ($r != 0) {
        die "Failed to get default realm: " ~ krb5_get_error_message($!ctx, $r);
    }

    return $realm[0];
}

method cc-default-name() returns Str {
    return krb5_cc_default_name($!ctx);
}

method parse-name(Str $name) returns Pointer {
    my Pointer $principal_ptr .= new;
    my $r = krb5_parse_name($!ctx, $name, $principal_ptr);
    if ($r != 0) {
        die "Failed to parse name: " ~ krb5_get_error_message($!ctx, $r);
    }
    return $principal_ptr;
}

method unparse-name(Pointer $principal_ptr) returns Str {
    my $name = CArray[Str].new;
    $name[0] = Str;

    my $r = krb5_unparse_name($!ctx, $principal_ptr, $name);
    if ($r != 0) {
        die "Failed to unparse principal: " ~ krb5_get_error_message($!ctx, $r);
    }

    return $name[0];
}
