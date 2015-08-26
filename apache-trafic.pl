use strict;
use warnings;
use Apache::Log::Parser;
use feature 'say';
use Data::Dumper;

open(my $h, '<', './access_log');

my $sum = 0;
my $monthly = {};
my $parser = Apache::Log::Parser->new( fast => 1 );

while (my $line = <$h>) {
    my $log = $parser->parse($line);
    my ($mday, $mon, $year) = split('/', $log->{date});
    if ($log->{bytes} ne '-') {
        $monthly->{$year} ||= {};
        $monthly->{$year}->{$mon} ||= 0;
        $monthly->{$year}->{$mon} += $log->{bytes};
        $sum += $log->{bytes};
    }
}

say "sum is $sum";
say Dumper($monthly);

