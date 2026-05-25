use v5.40;
use experimental qw<class>;

class SimpleCipher;

field $key :reader :param = '';

ADJUST {
    if ($key eq '') {
        $key = join '', map { chr(97 + int rand 26) } 1 .. 100;
    }
    die "invalid key" unless $key =~ /^[a-z]+$/;
}

method encode ($plaintext) {
    join '', map {
        my $i = $_;
        chr(97 + (ord(substr($plaintext, $i, 1)) - 97 + ord(substr($key, $i % length($key), 1)) - 97) % 26);
    } 0 .. length($plaintext) - 1;
}

method decode ($ciphertext) {
    join '', map {
        my $i = $_;
        chr(97 + (ord(substr($ciphertext, $i, 1)) - 97 - (ord(substr($key, $i % length($key), 1)) - 97) + 26) % 26);
    } 0 .. length($ciphertext) - 1;
}

1;
