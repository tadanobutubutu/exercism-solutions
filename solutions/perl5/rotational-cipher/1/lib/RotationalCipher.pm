package RotationalCipher;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<caesar_cipher>;

sub caesar_cipher ( $text, $shift_key ) {
    $shift_key %= 26;
    $text =~ s/([a-z])/chr((ord($1) - ord('a') + $shift_key) % 26 + ord('a'))/eg;
    $text =~ s/([A-Z])/chr((ord($1) - ord('A') + $shift_key) % 26 + ord('A'))/eg;
    return $text;
}

1;
