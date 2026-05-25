package Wordy;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<answer>;

sub answer ($question) {
    die 'unknown operation' unless $question =~ /^What is/i;
    (my $s = $question) =~ s/^What is\s*//i;
    $s =~ s/\?$//;
    $s =~ s/^\s+|\s+$//g;
    die 'syntax error' if $s eq '';
    my @words = split /\s+/, $s;
    die 'syntax error' if $words[0] !~ /^-?\d+$/;
    my $result = 0 + shift @words;
    while (@words) {
        my $op = shift @words;
        if ($op eq 'plus') { }
        elsif ($op eq 'minus') { }
        elsif ($op eq 'multiplied') { $op = 'multiplied by'; die 'syntax error' unless @words && shift @words eq 'by' }
        elsif ($op eq 'divided') { $op = 'divided by'; die 'syntax error' unless @words && shift @words eq 'by' }
        else {
            die 'syntax error' if $op =~ /^-?\d+$/;
            die 'unknown operation';
        }
        die 'syntax error' if !@words || $words[0] !~ /^-?\d+$/;
        my $num = 0 + shift @words;
        if    ($op eq 'plus')           { $result += $num }
        elsif ($op eq 'minus')          { $result -= $num }
        elsif ($op eq 'multiplied by')  { $result *= $num }
        elsif ($op eq 'divided by')     { $result /= $num }
    }
    $result;
}

1;
