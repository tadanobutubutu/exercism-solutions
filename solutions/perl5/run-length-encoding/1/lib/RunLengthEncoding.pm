package RunLengthEncoding;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<encode decode>;

sub encode ($string) {
    $string =~ s/((.)\2*)/length($1) > 1 ? length($1) . $2 : $2/eg;
    return $string;
}

sub decode ($string) {
    $string =~ s/(\d+)(.)/$2 x $1/eg;
    return $string;
}

1;
