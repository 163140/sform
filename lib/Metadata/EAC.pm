package Metadata::EAC;

use 5.36;
use strict;
use warnings;
use Exporter qw(import);

our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw(parse get_version ripping_date);
our %EXPORT_TAGS = (TEST => [qw(parse get_version ripping_date)]);

sub parse($Filename) {
	...
}

# use File::Slurper qw(read_text read_lines);
use Memoize;
use feature "switch";

# TODO: надо проверить имеет ли смысл парсить по строки, в плане производительности
# my $File = read_text($Filename);
# my @File = read_lines($Filename);

# TODO: TEST IT!!!
# UNTESTED
get_version($File, @File) { # return $Ver
	# Версия на первой строке
	$File[0] =~ /Audio Copy (V\d.\d.*) from/
	my $Ver =~ $1;
	if (not $1) {
		# нету версии на первой строке, пробуем пробежать весь файл
		$File =~ /Audio Copy (V\d.\d.*) from/
	}
	#нормализуем
	given ($Ver) {
		$Ver = 1 when /1\.0./;
		default { $Ver = 0 }
	}
return $Ver; }

parse_1_5($File) { ... }
parse_1_0 { ... }

# TODO: TEST IT!!!
# UNTESTED
ripping_date($File, @File) {  # return "день месяц год"
	# Обычно дата рипа на третьей строке
	$File[2] =~ /logfile from (\d?\d)\. (.+?) (\d\d\d\d), \d\d:\d\d/;
	my @Date = ($1, $2, $3);
	# но мало ли что
	if (not $1) {
		$File =~ /logfile from (\d?\d)\. (.+?) (\d\d\d\d), \d\d:\d\d/;
		@Date = ($1, $2, $3);
	}
	return $Date[0] . " " . $Date[1] . " " . $Date[2];
	# TODO: а если не изъялось ничего или не полностью?
	# TODO: а если месяц указан на французском и год стоит впереди?
}	

accurate_mode($File) { ... } # Read mode == Secure && accurate stream && no audio cache && no C2 pointers

read_offset($File) { ... }

track_len($File, $Track_num) { ... }
track_start_end($File, $Track_num) { ... ($start, $end);}
disk_CRC($File) {... (CRC, $Value)}
track_CRC($File) {... (CRC, $Value)}
accurately_ripped($File, $Track_num) { ... } # true/false
log_checksum($File) { ... }

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
