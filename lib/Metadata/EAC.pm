package Metadata::EAC;

use v5.36;
use strict;
use warnings;
use Exporter qw(import);
use Memoize;
use feature "switch";
no warnings qw( experimental::smartmatch );

our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw(parse get_version ripping_date accurate_mode disk_CRC);
our %EXPORT_TAGS = (TEST => [qw(parse get_version ripping_date accurate_mode disk_CRC)]);


sub parse($Filename) { ... }
sub parse_1_5($File) { ... }
sub parse_1_0($File) { ... }


sub get_version($File) {# return $Ver
	my ($Ver) = $File =~ /Audio Copy V(\d.\d.*) from/;
	given ($Ver) { #нормализуем
		$Ver = 1		when	/1\.0./;
		$Ver = 1.5	when	/1\.5/;
		default { $Ver = undef }
	}
	return $Ver;
}


sub ripping_date($File) {  # return "день месяц год"
	return join " ", $File =~ /file from (\d?\d)\. (.+?) (\d{4}), \d\d:\d\d/;
	# TODO: а если не изъялось ничего или не полностью?
	# TODO: а если месяц указан на французском и год стоит впереди?
}	

sub accurate_mode($File) { # true/false
	return (
	$File =~ /Read mode\s*:\sSecure/ &&
	$File =~ /Utilize accurate stream\s:\sYes/ &&
	$File =~ /Defeat audio cache\s*:\sYes/ &&
	$File =~ /Make use of C2 pointers\s*:\sNo/);
}

sub disk_CRC($File) { $File =~ /Copy CRC (\w{8})/a; return $1 }

sub track_len($File, $Track_num) { ... }
sub track_start_end($File, $Track_num) { ...} # ($start, $end);}
sub track_CRC($File) {... } # (CRC, $Value)
sub accurately_ripped($File, $Track_num) { ... } # true/false
sub log_checksum($File) { ... }

#TODO: out data format




=head1 NAME

Metadata::EAC - Извлекатель метаданных из логов Extract Audio Copy

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Извлекает метаданные из логов Extract Audio Copy.

    use Metadata::EAC;

    my %foo = eac_parse($Filename);

		%foo:
		{
			Album => ....
			Artist => ....
			...etc
		}

=head1 EXPORT

=head1 SUBROUTINES/METHODS

=head2 parse

=cut


#=head2 function2

#=cut

#sub function2 {
#}

=head1 AUTHOR

Alexander Makarov, C<< <163140 at autistici.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-metadata-eac at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Metadata-EAC>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Metadata::EAC


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Metadata-EAC>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Metadata-EAC>

=item * Search CPAN

L<https://metacpan.org/release/Metadata-EAC>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2023 by Alexander Makarov.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Metadata::EAC
