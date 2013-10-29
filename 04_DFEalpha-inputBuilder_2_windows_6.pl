#!/usr/bin/env perl

# Sergio González <sergiogoro86@gmail.com>
# This program will take inputs (define) and create an output file suitable for uploading to DFE-alpha server (ref)
# The inputs will be read by windows, and so, several output files will be created, one for each window.


# # # Preamble
use strict; use warnings; use feature 'say'; use Getopt::Long; use List::Util qw(sum); use Data::Dumper;


# # # Main
my $inputFile = shift || die "Pásame un input";
my $inputFile_fh = openFile_in($inputFile);
readInput($inputFile_fh);


# # # Subroutines
sub openFile_in {
    my $inputFile = shift;
    open (my $inputFile_fh, "<", "$inputFile") or die "Couldn't open $inputFile $!";
    return $inputFile_fh;
}

sub openFile_out {
    my $outputFile = shift;
    open (my $outputFile_fh, ">", "$outputFile") or die "Couldn't open $outputFile $!";
    return $outputFile_fh;
}

sub readInput {
    my $inputFile_fh = shift;
    my %hash = ();
    my ($num_0f, $num_4f) = (0, 0);

    while ( my $line = <$inputFile_fh> ) {
        chomp $line;
        my @splitted = split "\t", $line;
        my ($xfold, $chr_state) = split '-', $splitted[2];
        if ( $xfold == 0 ) {
            $num_0f++;
            say "\$num_0f <$num_0f>";
            #$hash->{"XFOLD"} = "zero_fold";
            push @{ $hash{XFOLD} }, "zero_fold";
            push @{ $hash{XFOLD} }, 
            $hash{XFOLD}{'Num_0f'} => $num_0f;

        } elsif ( $xfold == 4 ) {
            $num_4f++;
            #$hash->{"XFOLD"} = "four_fold";
            push @{ $hash{'XFOLD'} }, "four_fold";
            #$hash{'XFOLD'}{'Num_4f'} = $num_4f;

        } else { say "Xfold is neither 0 nor 4 <$xfold>" }
    } # Ends while my line
    print Dumper  \%hash;
} # Ends readInput



#   my ($window_0f_aref, $window_4f_aref, $m_Dmel_0f_aref, $m_Dyak_0f_aref, $m_Dmel_4f_aref, $m_Dyak_4f_aref, $totalPol_0f_aref, $totalPol_4f_aref, 
#           $divergents_0f_aref, $divergents_4f_aref, $vectorSFS_0f_aref, $vectorSFS_4f_aref, $AoA_0f_aref, $AoA_4f_aref) = readInput($inputFile_fh);
#   
#       # TEST
#       #foreach ( @{ $m_Dyak_0f_aref } ) { say "Elemento de \@{ \$m_Dyak_0f_aref } <$_>" }
#   
#       #my ( @sergio1, @sergio2 ) = ( @{ $m_Dyak_0f_aref }, @{ $m_Dmel_0f_aref } );
#       #foreach ( @sergio1 ) { say "Elemento de \@sergio1 <$_>" }
#       #foreach ( @sergio2 ) { say "Elemento de \@sergio2 <$_>" }
#   
#   my $arrayOutputFile_fh_aref = openOutputs($window_0f_aref, $inputFile);
#   
#   foreach my $outputFile_fh ( @{ $arrayOutputFile_fh_aref } ) {
#       #print $outputFile_fh "PRUEBA";
#       writeOutput($outputFile_fh, $window_0f_aref, $window_4f_aref, $m_Dmel_0f_aref, $m_Dyak_0f_aref, $m_Dmel_4f_aref, $m_Dyak_4f_aref, $totalPol_0f_aref, $totalPol_4f_aref, 
#           $divergents_0f_aref, $divergents_4f_aref, $vectorSFS_0f_aref, $vectorSFS_4f_aref, $AoA_0f_aref, $AoA_4f_aref);
#   }
#   
#   
#   
#   # # # Subroutines
#   
#   sub openFile_in {
#       my $inputFile = shift;
#       open (my $inputFile_fh, "<", "$inputFile") or die "Couldn't open $inputFile $!";
#       return $inputFile_fh;
#   }
#   
#   sub openFile_out {
#       my $outputFile = shift;
#       open (my $outputFile_fh, ">", "$outputFile") or die "Couldn't open $outputFile $!";
#       return $outputFile_fh;
#   }
#   
#   sub openOutputs {
#       my $window_0f_aref = shift;
#       my $inputFile =  shift;
#       my @arrayOutputFile_fh;
#   
#       foreach my $window ( @{ $window_0f_aref } ) {
#           say "digo Window de win0f <$window>";
#           my $outputFile = $inputFile . "_DFE-alpha_" . $window;
#           my $outputFile_fh = openFile_out($outputFile);
#   
#           push @arrayOutputFile_fh, $outputFile_fh;
#       }
#       return (\@arrayOutputFile_fh);
#   
#   }
#   
#   sub readInput {
#       my $inputFile_fh = shift;
#       my (@window_0f, @window_4f, @m_Dmel_0f, @m_Dyak_0f, @m_Dmel_4f, @m_Dyak_4f, @totalPol_0f, @totalPol_4f, 
#           @divergents_0f, @divergents_4f, @vectorSFS_0f, @vectorSFS_4f, @AoA_0f, @AoA_4f);
#       my ($counter_0f, $counter_4f) = (0, 0);
#       my ($m_Dmel_0f, $m_Dyak_0f, $m_Dmel_4f, $m_Dyak_4f);
#       my ($totalPol_0f, $divergents_0f, $totalPol_4f, $divergents_4f);
#   
#       while ( my $line = <$inputFile_fh> ) {
#           chomp $line;
#           my @splitted = split "\t", $line;
#               my ($xfold, $chr_state) = split "-", $splitted[2];
#               if ($xfold == 0) {
#                   push @window_0f, $splitted[1];
#   
#                   ($m_Dmel_0f, $m_Dyak_0f) = split '-', $splitted[3];
#                       say "\$m_Dmel_0f, \$m_Dyak_0f $m_Dmel_0f, $m_Dyak_0f";
#                   push @m_Dmel_0f, $m_Dmel_0f;
#                   push @m_Dyak_0f, $m_Dyak_0f;
#   
#                   ($totalPol_0f, $divergents_0f) = split '-', $splitted[5];
#                       say "\$totalPol_0f, \$divergents_0f $totalPol_0f $divergents_0f";
#                   push @totalPol_0f, $totalPol_0f;
#                   push @divergents_0f, $divergents_0f;
#   
#                   #my @dummyArray = split ':', $splitted[8];   # dummy array, just to get nº items in next line
#                   #    say "\@dummyArray @dummyArray";
#                   #    say "scalar (\@dummyArray) " . scalar(@dummyArray);
#                   #    say "\$\#dummyArray " . $#dummyArray;
#                   push @vectorSFS_0f, split ':', $splitted[8];
#   
#                   #push @{ $AoA_0f[$counter_0f] }, @vectorSFS_0f;
#                   @{ $AoA_0f[$counter_0f] } = @vectorSFS_0f;
#                   $counter_0f++;
#   
#               } elsif ($xfold == 4) { #Ends if xfold==0
#                   push @window_4f, $splitted[1];
#   
#                   ($m_Dmel_4f, $m_Dyak_4f) = split '-', $splitted[3];
#                       say "\$m_Dmel_4f, \$m_Dyak_4f $m_Dmel_4f, $m_Dyak_4f";
#                   push @m_Dmel_4f, $m_Dmel_4f;
#                   push @m_Dyak_4f, $m_Dyak_4f;
#   
#                   ($totalPol_4f, $divergents_4f) = split '-', $splitted[5];
#                       say "\$totalPol_4f, \$divergents_4f $totalPol_4f $divergents_4f";
#                   push @totalPol_4f, $totalPol_4f;
#                   push @divergents_4f, $divergents_4f;
#   
#                   push @vectorSFS_4f, split ':', $splitted[8];
#   
#                   push @{ $AoA_4f[$counter_4f] }, @vectorSFS_4f;
#                   $counter_4f++;
#   
#               } #Ends if xfold==4
#   
#       } #Ends while line
#       return (\@window_0f, \@window_4f, \@m_Dmel_0f, \@m_Dyak_0f, \@m_Dmel_4f, \@m_Dyak_4f, \@totalPol_0f, \@totalPol_4f, 
#           \@divergents_0f, \@divergents_4f, \@vectorSFS_0f, \@vectorSFS_4f, \@AoA_0f, \@AoA_4f);
#   } # Ends sub readInput
#   
#   sub writeOutput {   # Open $ print to output files
#   
#       my ($outputFile_fh, $window_0f_aref, $window_4f_aref, $m_Dmel_0f_aref, $m_Dyak_0f_aref, 
#           $m_Dmel_4f_aref, $m_Dyak_4f_aref, $totalPol_0f_aref, $totalPol_4f_aref, 
#           $divergents_0f_aref, $divergents_4f_aref, $vectorSFS_0f_aref, $vectorSFS_4f_aref, 
#           $AoA_0f_aref, $AoA_4f_aref) = @_;
#   
#       # Dereference the arrays
#       my @window_0f = @{ $window_4f_aref };
#       my @window_4f = @{ $window_4f_aref };
#       my @m_Dmel_0f = @{ $m_Dmel_0f_aref };
#       my @m_Dyak_0f = @{ $m_Dyak_0f_aref };
#       my @m_Dmel_4f = @{ $m_Dmel_4f_aref };
#       my @m_Dyak_4f = @{ $m_Dyak_4f_aref };
#       my @totalPol_0f = @{ $totalPol_0f_aref };
#       my @totalPol_4f = @{ $totalPol_4f_aref };
#       my @divergents_0f = @{ $divergents_0f_aref };
#       my @divergents_4f = @{ $divergents_4f_aref };
#       my @vectorSFS_0f = @{ $vectorSFS_0f_aref };
#       my @vectorSFS_4f = @{ $vectorSFS_4f_aref };
#       my @AoA_0f = @{ $AoA_0f_aref };
#       my @AoA_4f = @{ $AoA_4f_aref };
#   
#       # Test
#       #say "\@window_0f";
#       #say @window_0f;
#   
#       #say "\@window_4f";
#       #say  @window_4f;
#   
#       #say "\@m_Dmel_0f";
#       #say @m_Dmel_0f;
#   
#       #say "\@m_Dyak_0f";
#       #say @m_Dyak_0f;
#   
#       #say "\@m_Dmel_4f";
#       #say @m_Dmel_4f;
#   
#       #say "\@m_Dyak_4f";
#       #say @m_Dyak_4f;
#   
#       #say "\@totalPol_0f";
#       #say @totalPol_0f;
#   
#       #say "\@totalPol_4f";
#       #say @totalPol_4f;
#   
#       #say "\@divergents_0f";
#       #say @divergents_0f;
#   
#       #say "\@divergents_4f";
#       #say @divergents_4f;
#   
#       #say "\@vectorSFS_0f";
#       #say @vectorSFS_0f;
#   
#       #say "\@vectorSFS_4f";
#       #say @vectorSFS_4f;
#   
#       #say "\@AoA_0f";
#       #say @AoA_0f;
#   
#       #say "\@AoA_4f";
#       #say @AoA_4f;
#   
#   
#       #say "\@m_Dyak_0f_aref[0]" . ${ $m_Dyak_0f_aref }[0];
#       ##say "\@m_Dyak_0f_aref[1]" . ${ $m_Dyak_0f_aref }[1];
#   
#       #say "\@m_Dyak_4f_aref[0]" . ${ $m_Dyak_4f_aref }[0];
#       ##say "\@m_Dyak_4f_aref[1]" . ${ $m_Dyak_4f_aref }[1];
#   
#       #foreach ( @m_Dyak_0f ) {
#       #    say "Elemento de \@m_Dyak_0f <$_>";
#       #}
#   
#       #foreach ( @m_Dyak_4f ) {
#       #    say "Elemento de \@m_Dyak_4f <$_>";
#       #}
#   
#        my $counter_out_0f = 0;
#        my $counter_out_4f = 0;
#   
#        foreach my $window ( @{ $window_0f_aref } ) {
#            say $outputFile_fh "1";                             # Imprimir 1
#            say $outputFile_fh "1";                             # Imprimir 1
#            say $outputFile_fh "128";                           # Imprimir fixnum (128)
#            say $outputFile_fh "1";                             # Imprimir 1
#            say $outputFile_fh $m_Dyak_0f[$counter_out_0f];     # Print Total Selective
#            say $outputFile_fh $divergents_0f[$counter_out_0f]; # Print Divergents Selective
#            say $outputFile_fh $m_Dyak_4f[$counter_out_0f];     # Print Total neutral # SUM m_Dyak_4f
#            say $outputFile_fh $divergents_4f[$counter_out_0f]; # Print Divergents Neutral
#   
#            # # Selective
#            # Calculate header Selective
#            my $sumVectorSFS_0f = 0;
#            foreach my $i (0 .. $#vectorSFS_0f) { $sumVectorSFS_0f += $vectorSFS_0f[$i] };
#            my $header_0f = ($m_Dmel_0f[$counter_out_0f]) - $sumVectorSFS_0f;
#   
#            # Print header Selective. Not newline, header followed by SFSselective vector
#            print $outputFile_fh $header_0f;
#   
#            # Format Selective SFS vector
#            my @final_vectorSFS_0f = ( (0) x 128 );    # First, fill vector with 127 zeros!
#            foreach my $j (0 .. $#vectorSFS_0f) {   # Then, fill vector with corresponding values
#                $final_vectorSFS_0f[$j] += $vectorSFS_0f[$j];
#                #say "tiro vector 0f <\t" . $vectorSFS_0f[$j] . "\t>";
#            }
#   
#            # Print Selective SFS vector
#            foreach (@final_vectorSFS_0f) {
#                print $outputFile_fh " $_";
#            }
#            print $outputFile_fh " \n";
#   
#   
#            # # Neutral
#            # Calculate header Neutral
#            my $sumVectorSFS_4f = 0;
#            foreach my $i (0 .. $#vectorSFS_4f) { $sumVectorSFS_4f += $vectorSFS_4f[$i] };
#            my $header_4f = ($m_Dmel_4f[$counter_out_4f]) - $sumVectorSFS_4f;
#   
#            # Print header Neutral   # not newline, header followed by SFSselective vector
#            print $outputFile_fh $header_4f;
#   
#            # Format Neutral SFS vector
#            my @final_vectorSFS_4f = ( (0) x 128 );
#            foreach my $j (0 .. $#vectorSFS_4f) {
#                $final_vectorSFS_4f[$j] += $vectorSFS_4f[$j];
#            }
#   
#            # Print Neutral SFS vector
#            foreach (@final_vectorSFS_4f) {
#                print $outputFile_fh " $_";
#            }
#            print $outputFile_fh " \n";
#   
#           $counter_out_0f++;
#           $counter_out_4f++;
#       } # Ends foreach window 0f
#       close $outputFile_fh;
#   } # Ends writeOutput
#   
#   
#   
#   
#   # # # # OLD CODE BELOW:
#   
#   #my (@window_0f, @window_4f, @m_Dmel_0f, @m_Dmel_4f, @m_Dyak_0f, @m_Dyak_4f, @totalPol_0f, @totalPol_4f, @divergents_0f, @divergents_4f, @vectorSFS_0f, @vectorSFS_4f, @final_vectorSFS_0f, @final_vectorSFS_4f);
#   #my $counter_0f = 0;
#   #my $counter_4f = 0;
#   #my (@AoA_0f, @AoA_4f) = ();
#   #
#   #while (my $line = <$inputFile_fh>) {
#   #    chomp($line);
#   #    my @splitted = split "\t" , $line;
#   #    my ($xfold, $chr_state) = split "-", $splitted[2];
#   #    if ($xfold == 0) {
#   #        my $window_0f = $splitted[1];
#   #        push @window_0f, $window_0f;
#   #
#   #        my ($m_Dmel_0f, $m_Dyak_0f) = split "-", $splitted[3];
#   #        push @m_Dmel_0f, $m_Dmel_0f;
#   #        push @m_Dyak_0f, $m_Dyak_0f;
#   #        my ($totalPol_0f, $divergents_0f) = split "-", $splitted[5];
#   #        push @totalPol_0f, $totalPol_0f;
#   #        push @divergents_0f, $divergents_0f;
#   #
#   #        #@vectorSFS_0f = split ":", $splitted[8];
#   #        my @dummyArray = split ":", $splitted[8];   # dummy array, just to get nº items in next line
#   #        push @vectorSFS_0f, split ":", $splitted[8];
#   #
#   #        push @{ $AoA_0f[$counter_0f] }, @vectorSFS_0f;
#   #        $counter_0f++;
#   #
#   #    } elsif ($xfold == 4) {
#   #        my $window_4f = $splitted[1];
#   #        push @window_4f, $window_4f;
#   #
#   #        my ($m_Dmel_4f, $m_Dyak_4f) = split "-", $splitted[3];
#   #        push @m_Dmel_4f, $m_Dmel_4f;
#   #        push @m_Dyak_4f, $m_Dyak_4f;
#   #        my ($totalPol_4f, $divergents_4f) = split "-", $splitted[5];
#   #        push @totalPol_4f, $totalPol_4f;
#   #        push @divergents_4f, $divergents_4f;
#   #
#   #        #@vectorSFS_4f = split ":", $splitted[8];
#   #        my @dummyArray = split ":", $splitted[8];   # dummy array, just to get nº items in next line
#   #        push @vectorSFS_4f, split ":", $splitted[8];
#   #
#   #        push @{ $AoA_4f[$counter_4f] }, @vectorSFS_4f;
#   #        $counter_4f++;
#   #    }
#   #}
#   
#   
#   #   #   # Open $ print to output files
#   #   #   my $counter_out_0f = 0;
#   #   #   my $counter_out_4f = 0;
#   #   #   foreach my $window (@window_0f) {
#   #   #       my $outputFile = $inputFile . "_DFE-alpha_" . $window;
#   #   #       open my $outputFile_fh, '>', $outputFile or die "Couldn't open output file '$outputFile' $!\n";
#   #   #   
#   #   #     #Imprimir 1
#   #   #       say $outputFile_fh "1";
#   #   #   
#   #   #     #Imprimir 1
#   #   #       say $outputFile_fh "1";
#   #   #   
#   #   #     #Imprimir fixnum (128)
#   #   #       say $outputFile_fh "128";
#   #   #   
#   #   #     #Imprimir 1
#   #   #       say $outputFile_fh "1";
#   #   #   
#   #   #     # Print Total Selective
#   #   #       say $outputFile_fh $m_Dyak_0f[$counter_out_0f];
#   #   #   
#   #   #     # Print Divergents Selective
#   #   #       say $outputFile_fh $divergents_0f[$counter_out_0f];
#   #   #   
#   #   #     # Print Total neutral # SUM m_Dyak_4f
#   #   #       say $outputFile_fh $m_Dyak_4f[$counter_out_0f];
#   #   #   
#   #   #     # Print Divergents Neutral
#   #   #       say $outputFile_fh $divergents_4f[$counter_out_0f];
#   #   #   
#   #   #     # Calculate header Selective
#   #   #       my $sumVectorSFS_0f; 
#   #   #       #foreach my $i (0 .. $numElementsVectorSFS_0f-1) {
#   #   #       # HERE SUBSTITUTE the variable num for something like $# OR scalar(@)
#   #   #       foreach my $i (0 .. $#vectorSFS_0f) {
#   #   #           $sumVectorSFS_0f += $vectorSFS_0f[$i];
#   #   #       }
#   #   #           #say "la suma de todos vale \$sumVectorSFS_0f '$sumVectorSFS_0f'";
#   #   #       my $header_0f = ($m_Dmel_0f[$counter_out_0f]) - $sumVectorSFS_0f;
#   #   #           #say "\$header_0f vale '$header_0f'";
#   #   #     # Print header Selective   # not newline, header followed by SFSselective vector
#   #   #       print $outputFile_fh $header_0f ;
#   #   #   
#   #   #     # Format Selective SFS vector
#   #   #       #@final_vectorSFS_0f = ( (0) x 127 );    # First, fill vector with 127 zeros!
#   #   #       @final_vectorSFS_0f = ( (0) x 128 );    # First, fill vector with 127 zeros!
#   #   #       #foreach my $j (0 .. $numElementsVectorSFS_0f-1) {   # Then, fill vector with corresponding values
#   #   #       foreach my $j (0 .. $#vectorSFS_0f) {   # Then, fill vector with corresponding values
#   #   #           $final_vectorSFS_0f[$j] += $vectorSFS_0f[$j];
#   #   #           say "tiro vector 0f <\t" . $vectorSFS_0f[$j] . "\t>";
#   #   #       }
#   #   #   
#   #   #     # Print Selective SFS vector
#   #   #       foreach (@final_vectorSFS_0f) {
#   #   #           print $outputFile_fh " $_";
#   #   #       }
#   #   #       print $outputFile_fh " \n";
#   #   #   
#   #   #     # Calculate header Neutral
#   #   #       my $sumVectorSFS_4f; 
#   #   #       foreach my $i (0 .. $#vectorSFS_4f) {
#   #   #           $sumVectorSFS_4f += $vectorSFS_4f[$i];
#   #   #       }
#   #   #       my $header_4f = ($m_Dmel_4f[$counter_out_4f]) - $sumVectorSFS_4f;
#   #   #   
#   #   #     # Print header Neutral   # not newline, header followed by SFSselective vector
#   #   #       print $outputFile_fh $header_4f ;
#   #   #   
#   #   #     # Format Neutral SFS vector
#   #   #       #@final_vectorSFS_4f = ( (0) x 127 );    # First, fill vector with 127 zeros!
#   #   #       @final_vectorSFS_4f = ( (0) x 128 );    # First, fill vector with 127 zeros!
#   #   #       foreach my $j (0 .. $#vectorSFS_4f) {   # Then, fill vector with corresponding values
#   #   #           $final_vectorSFS_4f[$j] += $vectorSFS_4f[$j];
#   #   #       }
#   #   #     # Print Neutral SFS vector
#   #   #       foreach (@final_vectorSFS_4f) {
#   #   #           print $outputFile_fh " $_";
#   #   #       }
#   #   #       print $outputFile_fh " \n";
#   #   #   
#   #   #   $counter_out_0f++;
#   #   #   $counter_out_4f++;
#   #   #   close $outputFile_fh;
#   #   #   }
#   #   #   
