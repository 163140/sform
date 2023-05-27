# vim: foldmethod=marker tabstop=2
package Metadata::CUE;

use v5.36;
use utf8;
use open 'encoding(UTF-8)';
use feature 'unicode_strings';
use warnings;
use strict;

use Exporter qw(import);
use File::Slurper 'read_text';

our @ISA					= qw(Exporter);
our @EXPORT				= qw(cue_parse);
our @EXPORT_OK		= qw(parse);

our %EXPORT_TAGS	= (TEST =>
											[qw(parse)]);

sub cue_parse($Filename) { parse($Filename); }
sub parse($Filename) {
	my $File = read_text($Filename);
	return {
		...
		#RIP_DATE			=> ripping_date($File	),
		#ACCURATE_MODE	=> accurate_mode($File),
		#DISK_CRC			=> disk_CRC($File			),
		#LOG_CHKSUM		=> log_checksum($File	)
	}
}

# Utility functions

sub get_tag($File, $Tag, $Pattern) {
	$File =~ /REM\s+$Tag\s+"?($Pattern)"?.*\n/;
	return $1;
}

sub get_one_track_meta($File, $Tracknum) {
	my ($Title, $Performer) =
			$File =~ /TRACK\s+$Tracknum\sAUDIO.*?TITLE\s+"(.*?)".*?
								PERFORMER\s"(.*?)".*?INDEX
							 /xs
	return {
						TRACKNUM=>$Tracknum,
						TITLE =>$Title,
						PERFORMER => $Performer
						DISCNUMBER => get_disk_number($File)
				 };
}
#

sub get_date				($File)	{ get_tag($File, "DATE"				, '\d{4}'		); }
sub get_genre				($File)	{ get_tag($File, "GENRE"			, '.*?'			); }
sub get_diskid			($File)	{ get_tag($File, "DISKID"			, '\w{8}'		); }
sub get_album				($File)	{ get_tag($File, "TITLE"			, '.*?'			); }
sub get_totaldiscs 	($File) { get_tag($File, "TOTALDISCS"	,	'\d+'			); }
sub get_catalognum 	($File) { get_tag($File, "CATALOG"		,	'\w+'			); }

#sub get_genre	($File)	{ $File =~ /REM\s+GENRE\s+"(.*?)"\n/	; return $1; }
#sub get_diskid($File)	{ $File =~ /REM\s+DISCID\s+(\w{8})/		; return $1; }
#sub get_album	($File)	{ $File =~ /REM\s+TITLE\s+"(.*?)"\n/	; return $1; }

sub get_comment($File){
	my ($Comment) = ($File =~ /REM\s+COMMENT\s+"(.*?)"/);

	my $Useless=0; 
	$Useless = 1 if $Comment =~ /ExactAudioCopy/; # других значений я не видел

	return undef		if $Useless	;
	return $Comment							;
}


sub get_tracks_meta($File) {
	my @Tracks = $File =~ /TRACK\s+(\d+)\s+AUDIO/g;
	my %Meta = map {$_ => get_one_track_meta($File, $_)} @Tracks;
}

sub get_reissue($File) {
	$File =~ /TITLE\s+"?.*?
						[\(\[] # как выглядит как [Reissue 2009] но могут быть
									 # такие скобки ()
						([Rr]eissue\s.*?)
						[\)\]]
						.*?"?/x;
	return $1;
}


sub get_disk_number	($File, $Tracknum){
	$File =~ /.*REM\s+DISCNUMBER\s+(\d+).+
						TRACK\s+$Tracknum
					 /xs;
	return $1;
}

=pod

=encoding utf8

=head1 NAME

Metadata::CUE - Извлекатель метаданных из CUE файлов

=head1 VERSION

Version 0.00

=cut

our $VERSION = '0.00';


=head1 SYNOPSIS

Извлекает метаданные из CUE-файлов.

=head1 EXPORT

=head2 L<cue_parse>

Единственная экспортируемая функция, которая  выполняет всю необходимую работу

    use Metadata::CUE;

    my %foo = cue_parse($Filename);

		%foo:
		{
			SPLIT => undef								# или "Abba & Queen" когда сплит
			COMMENT => undef							# или текст если содержимое полезно
			DISKID => "520E7B07"					# или undef при отсутствии
			ALBUM => "Joulu-single 2005",
			ALBUM_DATE => 2005,
			GENRE => "Black Metal",
			REISSUE => 2009,							# если это перевыпуск альбома или undef
			TOTALDISKS => 2								# или undef
			TRACKS => {
									01 => {	
													ISRC => PLA640906601, # или undef
													TRACKNUM => 01,
													PERFORMER => "Ajattara",
													TITLE => "Teuras"
													DISKNUMBER => 1				# или undef
												},
									02 => {
													TRACKNUM => 02,
													PERFORMER => "Ajattara",
													TITLE => "Kansallispäivä"
													INFO => "Bonus Track"
													DISKNUMBER => 2				# или undef
												}
								}
			...etc
		}

но можно сделать вызов напрямую:

 my %foo = Metadata::CUE::parse($Filename);

	%foo:
		{
			SPLIT => undef								# или "Abba & Queen" когда сплит
			COMMENT => undef							# или текст если содержимое полезно
			DISKID => "520E7B07"					# или undef при отсутствии
			ALBUM => "Joulu-single 2005",
			ALBUM_DATE => 2005,
			GENRE => "Black Metal"
			REISSUE => 2009,							# если это перевыпуск альбома или undef
			TRACKS => {
									01 => {	
													ISRC => PLA640906601, # или undef
													TRACKNUM => 01,
													PERFORMER => "Ajattara",
													TITLE => "Teuras"
												},
									02 => {
													TRACKNUM => 02,
													PERFORMER => "Ajattara",
													TITLE => "Kansallispäivä"
													INFO => "Bonus Track"
												}
								}
			...etc
		}

=cut

=head1 OTHER SUBROUTINES

Прочие функции которые не должны экспортироваться кроме особых случаев.

=head2 I<parse>

Алиас функции cue_parse. Удобен для вызова C<Metadata::CUE::parse($File)>

=head2 I<get_version>

=over 2

=item Определяет версию EAC сделавшей копию диска.

=item C<my $Ver = get_version($Filecontent);>

=item C<say $Ver; # 0.99 or 1.0 or 1.5>

=item Старые или неизвестные версии возвращают B<undef>

=back

=head1 AUTHOR

Alexander Makarov, C<< <163140 at autistici.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-metadata-eac at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Metadata-EAC>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Metadata::CUE


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

=head1 LIMITATIONS

=over 4

=item * Не определены.

=back

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2023 by Alexander Makarov.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

1; # End of Metadata::CUE
