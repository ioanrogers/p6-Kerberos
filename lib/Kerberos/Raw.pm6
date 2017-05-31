use v6;

unit class Kerberos::Raw;

use NativeCall;

constant KRB5_LIB = 'krb5';
constant KRB5_VER = v3;

class krb5_context is repr('CPointer') { }

# krb5_error_code
sub krb5_init_context(
    Pointer is rw
) is native(KRB5_LIB, KRB5_VER) returns uint32 is export { * }

# krb5_free_context(krb5_context context);
sub krb5_free_context(Pointer) is native(KRB5_LIB, KRB5_VER) is export { * }

# krb5_get_error_message(krb5_context ctx, krb5_error_code code);
sub krb5_get_error_message(
    Pointer,
    uint32
) is native(KRB5_LIB, KRB5_VER) returns Str is export { * }

# krb5_error_code
# krb5_get_default_realm(krb5_context context, char **lrealm);
sub krb5_get_default_realm(
    Pointer,
    CArray[Str],
) is native(KRB5_LIB, KRB5_VER) returns uint32 is export { * }

# krb5_cc_default_name(krb5_context context);
sub krb5_cc_default_name(Pointer) is native(KRB5_LIB, KRB5_VER) returns Str is export { * }

# krb5_error_code
# krb5_parse_name(krb5_context context, const char *name,
sub krb5_parse_name(
    Pointer,
    Str,
    Pointer is rw
) is native(KRB5_LIB, KRB5_VER) returns uint32 is export { * }

# krb5_error_code
# krb5_unparse_name(krb5_context context, krb5_const_principal principal, register char **name)
sub krb5_unparse_name(
    Pointer,
    Pointer,
    CArray[Str],
) is native(KRB5_LIB, KRB5_VER) returns uint32 is export { * }
