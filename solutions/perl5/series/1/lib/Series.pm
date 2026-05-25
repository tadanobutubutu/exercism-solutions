package Series;

use v5.40;

use Carp qw<croak>;
use Exporter qw<import>;
our @EXPORT_OK = qw<slices>;

sub slices ( $series, $slice_length ) {
    croak "series cannot be empty" if $series eq "";
    croak "slice length cannot be negative" if $slice_length < 0;
    croak "slice length cannot be zero" if $slice_length == 0;
    croak "slice length cannot be greater than series length" if $slice_length > length $series;
    my @slices;
    for my $i (0 .. length($series) - $slice_length) {
        push @slices, substr $series, $i, $slice_length;
    }
    return \@slices;
}

1;
