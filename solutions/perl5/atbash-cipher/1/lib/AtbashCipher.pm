package AtbashCipher;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<encode_atbash decode_atbash>;

sub _atbash ($char) {
    return chr(ord('z') - (ord(lc $char) - ord('a'))) if $char =~ /[a-zA-Z]/;
    return $char if $char =~ /[0-9]/;
    return "";
}

sub encode_atbash ($phrase) {
    my $encoded = "";
    $encoded .= _atbash($_) for split //, lc $phrase;
    $encoded =~ s/(.{5})/$1 /g;
    $encoded =~ s/ $//;
    return $encoded;
}

sub decode_atbash ($phrase) {
    my $decoded = "";
    $decoded .= _atbash($_) for split //, lc $phrase;
    return $decoded;
}

1;
