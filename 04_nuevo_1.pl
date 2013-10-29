use strict; use warnings;

my $inputFile = shift || die "Pasame input <$0 input>";

open my $input_fh, '<', $inputFile or die "No pude abrir $inputFile";

my @splitted;
while ( my $line = <$input_fh> ) {
    chomp $line;
    my @s
    my $chr_start_stop = 
}

