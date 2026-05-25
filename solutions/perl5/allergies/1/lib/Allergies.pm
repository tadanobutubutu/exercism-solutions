package Allergies;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<allergic_to list_allergies>;

use constant ALLERGENS => [qw<eggs peanuts shellfish strawberries tomatoes chocolate pollen cats>];

sub allergic_to ( $item, $score ) {
    my %allergen = map { ALLERGENS->[$_] => 2**$_ } 0 .. $#{(+ALLERGENS)};
    $score & $allergen{$item} ? !0 : !1;
}

sub list_allergies ($score) {
    [ grep { allergic_to($_, $score) } ALLERGENS->@* ];
}

1;
