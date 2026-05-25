package Meetup;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<meetup>;

use Time::Piece;

my %month_num = qw<January 1 February 2 March 3 April 4 May 5 June 6 July 7 August 8 September 9 October 10 November 11 December 12>;
my %dow = qw<Sunday 0 Monday 1 Tuesday 2 Wednesday 3 Thursday 4 Friday 5 Saturday 6>;

sub meetup ($desc) {
    my ($ordinal, $dow_name, $mon_name, $yr) = $desc =~ /^(\S+) (\S+) of (\S+) (\d+)$/
        or return;
    my ($mon, $target_dow) = ($month_num{$mon_name} - 1, $dow{$dow_name});

    if ($ordinal eq 'Teenth') {
        my $tp = Time::Piece->strptime("$yr-06-13", '%Y-%m-%d');
        $tp = Time::Piece->strptime("$yr-" . ($mon+1) . "-13", '%Y-%m-%d');
        my $diff = ($target_dow - $tp->day_of_week + 7) % 7;
        $tp += $diff * 86400;
        return $tp->strftime('%Y-%m-%d');
    }
    elsif ($ordinal eq 'Last') {
        my $tp = Time::Piece->strptime("$yr-" . ($mon+1) . "-01", '%Y-%m-%d');
        $tp += 86400 * 32;
        $tp = Time::Piece->strptime($tp->strftime('%Y-%m') . '-01', '%Y-%m-%d');
        $tp -= 86400;
        my $diff = ($tp->day_of_week - $target_dow + 7) % 7;
        $tp -= $diff * 86400;
        return $tp->strftime('%Y-%m-%d');
    }
    else {
        my %ord = qw<First 1 Second 2 Third 3 Fourth 4>;
        my $tp = Time::Piece->strptime("$yr-" . ($mon+1) . "-01", '%Y-%m-%d');
        my $diff = ($target_dow - $tp->day_of_week + 7) % 7;
        $tp += ($diff + 7 * ($ord{$ordinal} - 1)) * 86400;
        return $tp->strftime('%Y-%m-%d');
    }
}

1;
