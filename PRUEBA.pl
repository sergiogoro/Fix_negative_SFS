#!/usr/bin/env perl

# Sergio González <sergiogoro86@gmail.com>

# This program will take inputs (define) and create an output file suitable for uploading to DFE-alpha server (ref)

# The inputs will be read by windows, and so, several output files will be created, one for each window.

use strict; use warnings; use feature 'say'; use Getopt::Long; use List::Util qw(sum); use Data::Dumper;

my $help = undef;
my $inputFile;

usage() if (
    @ARGV < 1 or
    !GetOptions(
        'help|h|?'  =>  \$help,
        'input=s'   =>  \$inputFile,
    ) or defined $help);

sub usage {say "Usage: $0 -input <input file> [-help]"};

open (my $inputFile_fh, "<", "$inputFile") or die "Couldn't open $inputFile $!";

my (@window_0f, @window_4f, @m_Dmel_0f, @m_Dmel_4f, @m_Dyak_0f, @m_Dyak_4f, @totalPol_0f, @totalPol_4f, @divergents_0f, @divergents_4f, @vectorSFS_0f, @vectorSFS_4f, @final_vectorSFS_0f, @final_vectorSFS_4f);
my $counter_0f = 0;
my $counter_4f = 0;
my (@AoA_0f, @AoA_4f) = ();
my ($numElementsVectorSFS_0f, $numElementsVectorSFS_4f) = (0, 0);

while (my $line = <$inputFile_fh>) {
    chomp($line);
    my @splitted = split "\t" , $line;
    my ($xfold, $chr_state) = split "-", $splitted[2];
    if ($xfold == 0) {
        my $window_0f = $splitted[1];
        push @window_0f, $window_0f;

        my ($m_Dmel_0f, $m_Dyak_0f) = split "-", $splitted[3];
        push @m_Dmel_0f, $m_Dmel_0f;
        push @m_Dyak_0f, $m_Dyak_0f;
        my ($totalPol_0f, $divergents_0f) = split "-", $splitted[5];
        push @totalPol_0f, $totalPol_0f;
        push @divergents_0f, $divergents_0f;

        #@vectorSFS_0f = split ":", $splitted[8];
        #$numElementsVectorSFS_0f = split ":", $splitted[8];
        my @dummyArray = split ":", $splitted[8];   # dummy array, just to get nº items in next line
        $numElementsVectorSFS_0f = @dummyArray;
        #say "Longitud de dummy array segun scalar(\@dummyArray) <" . scalar(@dummyArray) . ">";             #64
        #say "Longitud de dummy array según \$num = \@dummyArray <" . $numElementsVectorSFS_0f . ">";        #64

        #say "Número elementos en vector SFS 0f \$numElementsVectorSFS_0f '$numElementsVectorSFS_0f'";
        push @vectorSFS_0f, split ":", $splitted[8];

        push @{ $AoA_0f[$counter_0f] }, @vectorSFS_0f;
        $counter_0f++;

    } elsif ($xfold == 4) {
        my $window_4f = $splitted[1];
        push @window_4f, $window_4f;

        my ($m_Dmel_4f, $m_Dyak_4f) = split "-", $splitted[3];
        push @m_Dmel_4f, $m_Dmel_4f;
        push @m_Dyak_4f, $m_Dyak_4f;
        my ($totalPol_4f, $divergents_4f) = split "-", $splitted[5];
        push @totalPol_4f, $totalPol_4f;
        push @divergents_4f, $divergents_4f;

        #@vectorSFS_4f = split ":", $splitted[8];
        #$numElementsVectorSFS_4f = split ":", $splitted[8];
        my @dummyArray = split ":", $splitted[8];   # dummy array, just to get nº items in next line
        $numElementsVectorSFS_4f = @dummyArray;
        push @vectorSFS_4f, split ":", $splitted[8];

        push @{ $AoA_4f[$counter_4f] }, @vectorSFS_4f;
        $counter_4f++;
    }
    ($counter_0f, $counter_4f) = (0, 0);
}


# Open $ print to output files
my $counter_out_0f = 0;
my $counter_out_4f = 0;
foreach my $window (@window_0f) {
    my $outputFile = $inputFile . "_DFE-alpha_" . $window;
    open my $outputFile_fh, '>', $outputFile or die "Couldn't open output file '$outputFile' $!\n";

  #Imprimir 1
    say $outputFile_fh "1";

  #Imprimir 1
    say $outputFile_fh "1";

  #Imprimir fixnum (128)
    say $outputFile_fh "128";

  #Imprimir 1
    say $outputFile_fh "1";

  # Print Total Selective
    say $outputFile_fh $m_Dyak_0f[$counter_out_0f];

  # Print Divergents Selective
    say $outputFile_fh $divergents_0f[$counter_out_0f];

  # Print Total neutral # SUM m_Dyak_4f
    say $outputFile_fh $m_Dyak_4f[$counter_out_0f];

  # Print Divergents Neutral
    say $outputFile_fh $divergents_4f[$counter_out_0f];

  # Calculate header Selective
    my $sumVectorSFS_0f; 
    #foreach my $i (0 .. $numElementsVectorSFS_0f-1) {
    #    $sumVectorSFS_0f += $vectorSFS_0f[$i];
    #}
    foreach (@vectorSFS_0f) {
        $sumVectorSFS_0f += $_;
        #say "foreach \@vectorsSFS_0f <$_>";
    }
    #say "la suma de todos vale \$sumVectorSFS_0f '$sumVectorSFS_0f'";
    my $header_0f = ($m_Dmel_0f[$counter_out_0f]) - $sumVectorSFS_0f;
    #say "IMPRIMO \$counter_out_0f <$counter_out_0f>";
    #say "IMPRIMO \$m_Dmel_0f[\$counter_out_0f] <$m_Dmel_0f[$counter_out_0f]>";
        #say "\$header_0f vale '$header_0f'";
  # Print header Selective   # not newline, header followed by SFSselective vector
    print $outputFile_fh $header_0f ;

  # Format Selective SFS vector
    #@final_vectorSFS_0f = ( (0) x 127 );    # First, fill vector with 127 zeros!
    @final_vectorSFS_0f = ( (0) x 128 );    # First, fill vector with 127 zeros!
    foreach my $j (0 .. $numElementsVectorSFS_0f-1) {   # Then, fill vector with corresponding values
        $final_vectorSFS_0f[$j] = $vectorSFS_0f[$j]
    }

  # Print Selective SFS vector
    foreach (@final_vectorSFS_0f) {
        print $outputFile_fh " $_";
    }
    print $outputFile_fh " \n";

  # Calculate header Neutral
    my $sumVectorSFS_4f; 
    #foreach my $i (0 .. $numElementsVectorSFS_4f-1) {
    #    $sumVectorSFS_4f += $vectorSFS_4f[$i];
    #}
    foreach ( @vectorSFS_4f ) {
        $sumVectorSFS_4f += $_;
    }
    my $header_4f = ($m_Dmel_4f[$counter_out_4f]) - $sumVectorSFS_4f;

  # Print header Neutral   # not newline, header followed by SFSselective vector
    print $outputFile_fh $header_4f ;

  # Format Neutral SFS vector
    #@final_vectorSFS_4f = ( (0) x 127 );    # First, fill vector with 127 zeros!
    @final_vectorSFS_4f = ( (0) x 128 );    # First, fill vector with 127 zeros!
    foreach my $j (0 .. $numElementsVectorSFS_4f-1) {   # Then, fill vector with corresponding values
        $final_vectorSFS_4f[$j] = $vectorSFS_4f[$j]
    }
  # Print Neutral SFS vector
    foreach (@final_vectorSFS_4f) {
        print $outputFile_fh " $_";
    }
    print $outputFile_fh " \n";

$counter_out_0f++;
$counter_out_4f++;
close $outputFile_fh;
}

