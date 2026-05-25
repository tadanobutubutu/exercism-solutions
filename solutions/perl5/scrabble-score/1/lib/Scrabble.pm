package Scrabble;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<scrabble_score>;

sub scrabble_score ($word) {
    my %scores;
    @scores{ qw<A E I O U L N R S T> } = (1) x 10;
    @scores{ qw<D G> }                  = (2) x 2;
    @scores{ qw<B C M P> }              = (3) x 4;
    @scores{ qw<F H V W Y> }            = (4) x 5;
    $scores{K} = 5;
    @scores{ qw<J X> }                  = (8) x 2;
    @scores{ qw<Q Z> }                  = (10) x 2;
    my $score = 0;
    $score += $scores{uc $_} for split //, $word;
    return $score;
}

1;
