# Declare package 'Bob'
package Bob;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<hey>;

sub hey ($msg) {
    $msg =~ s/\s+$//;
    return "Fine. Be that way!" if $msg eq "";

    my $is_shouting = $msg =~ /[A-Z]/ && $msg !~ /[a-z]/;
    my $is_question = $msg =~ /\?$/;

    return "Calm down, I know what I'm doing!" if $is_shouting && $is_question;
    return "Whoa, chill out!" if $is_shouting;
    return "Sure." if $is_question;
    return "Whatever.";
}

1;
