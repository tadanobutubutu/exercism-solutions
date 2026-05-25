package AffineCipher;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<encode decode>;

use Carp qw<croak>;

sub _modinv ($a) {
    for my $i (1 .. 25) {
        return $i if ($a * $i) % 26 == 1;
    }
    return undef;
}

sub encode ( $phrase, $a, $b ) {
    croak "a and m must be coprime." if !defined _modinv($a);
    my $encoded = "";
    $phrase = lc $phrase;
    $phrase =~ s/[^a-z0-9]//g;
    for my $c (split //, $phrase) {
        if ($c =~ /[a-z]/) {
            my $x = ord($c) - ord('a');
            $encoded .= chr(($a * $x + $b) % 26 + ord('a'));
        } else {
            $encoded .= $c;
        }
    }
    $encoded =~ s/(.{5})/$1 /g;
    $encoded =~ s/ $//;
    return $encoded;
}

sub decode ( $phrase, $a, $b ) {
    my $mmi = _modinv($a);
    croak "a and m must be coprime." if !defined $mmi;
    my $decoded = "";
    $phrase =~ s/\s//g;
    for my $c (split //, $phrase) {
        if ($c =~ /[a-z]/) {
            my $y = ord($c) - ord('a');
            $decoded .= chr(($mmi * ($y - $b)) % 26 + ord('a'));
        } else {
            $decoded .= $c;
        }
    }
    return $decoded;
}

1;
