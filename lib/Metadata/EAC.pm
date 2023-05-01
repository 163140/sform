# vim: foldmethod=marker
package Metadata::EAC;

use v5.36;
use utf8;
#binmode(STDOUT, ":utf8");
#binmode(STDIN, ":utf8");
#binmode(STDERR, ":utf8");


use strict;
use warnings;
use Exporter qw(import);
use Memoize;
use feature 'unicode_strings';
use feature "switch";
no warnings qw( experimental::smartmatch );


our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw(eac_parse parse get_version ripping_date accurate_mode disk_CRC log_checksum);
our %EXPORT_TAGS = (TEST => [qw(parse get_version ripping_date accurate_mode disk_CRC log_checksum)]);


sub eac_parse($Filename) { parse($Filename); }
sub parse($Filename) { ... }
sub parse_1_5($File) { ... }
sub parse_1_0($File) { ... }


sub get_version($File) {# return $Ver
	# {{{1
	$File =~ /Audio Copy V(\d.\d\d?).* from/a;
	if		($1 == 0.99)	{	return 0.99; }
	elsif	($1 == 1.0)		{ return 1; }
	elsif	($1 == 1.5)		{ return 1.5; }
	else								{ return undef; }
} # }}}

sub ripping_date($File) {  # return "день месяц год"
	# {{{1
	my ($D, $M, $Y) = $File =~ /
															(?:file\sfrom|,\sвыполненном)\s # англ или рус лог
															(\d+?)\.\s # день
															(\w+?)\s # месяц
															(\d{4}),\s # год
															\d+?:\d+?
														/x;
	$M = month_in_eng($M);
	return join " ", ($D, $M, $Y) if ($D && $M && $Y);
	return "Day: $D or undef | Month: $M or undef | Year: $Y or undef";
# TODO: а если месяц указан на французском и год стоит впереди?. Пока не видел
# года впереди
} # }}}1

sub month_in_eng($Text) { # русский и англ месяца ->  англ имя месяца
	# {{{1
	my $Month = { # to_eng => ; rus =>   ; eng =>    ; 
		to_eng => { #{{{2
			1	=>	"January",	2	=>	"February",	3	=>	"March",
			4	=>	"April",		5	=>	"May",			6	=>	"June",
			7	=>	"July",			8	=>	"August",		9	=>	"September",
			10=>	"October",	11=>	"November",	"12"=>	"December" },

		rus =>(join "\t",("1 января января январю январем январём январе",
											"2 февраль февраля февралю февралем февралём феврале",
											"3 март марта марту мартом марте",
											"4 апрель апреля апрелю апрелем апреле",
											"5 май мая маю маем мае",
											"6 июнь июня июню июнем июне",
											"7 июль июля июлю июлем июле",
											"8 август августа августу августе августом",
											"9 сентябрь сентября сентябрю сентябрем сентябрём 
											сентябре",
											"10 октябрь октября октябрю октябрем октябрём октябре",
											"11 ноябрь ноября ноябрю ноябрем ноябрём ноябре",
											"12 декабрь декабря декабре декабрем декабрём декабре")
					),

		eng =>(join "\t",("1 January"		,	"2 February"	,	"3 March"			,
											"4 April"			,	"5 May"				,	"6 June"			,
											"7 July"			,	"8 August"		,	"9 September"	,
											"10 October"	, "11 November"	,	"12 December"	)
					),
	}; # }}}2

	my $N;
	($N) = $Month->{eng} =~ /(?:^|\t)(\d\d?)[\w ]*$Text[\w ]*(?:\t|$)/i;
	($N) = $Month->{rus} =~ /(?:^|\t)(\d\d?)[\w ]*$Text[\w ]*(?:\t|$)/i unless $N;
	return $Month->{to_eng}->{$N} if defined $N;
	return undef;
} # }}}1

sub accurate_mode($File) { # true/false
	# {{{1
	my ($R) = $File =~ /(?:	Read\smode\s+?:\sSecure|
													Режим\sчтения\s+?:\sДостоверность)
											.*\R*.*
											(?:	Utilize\saccurate\sstream\s+?:\sYes|
													Использование\sточного\sпотока\s+?:\sДа)
											.*\R*.*
											(?:	Defeat\saudio\scache\s+?:\sYes|
													Отключение\sкэша\sаудио\s+?:\sДа)
											.*\R*.*
											(?:	Make\suse\sof\sC2\spointers\s+?:\sNo|
													Использование\sуказателей\sC2\s+?:\sНет)
										/xs;
return $R;
} # }}}1

sub disk_CRC($File) {
	# {{{1
	my ($CRC) = $File =~ /(?:Copy\sCRC|CRC\sкопии)\s+(\w{8})/;
	#TODO: добавить русский вариант
	my ($Its_a_track_CRC) = $File =~ /Track\s+?1.*?Filename.*?CRC/s;
	$CRC = undef if (defined $Its_a_track_CRC);
return $CRC } # }}}1

sub track_len($File, $Track_num) { ... }
sub track_start_end($File, $Track_num) { ...} # ($start, $end);}
sub track_CRC($File) {... } # (CRC, $Value)
sub accurately_ripped($File, $Track_num) { ... } # true/false
sub log_checksum($File) {
	# {{{1
	$File =~ /.*(?:(Log checksum|Контрольная сумма отчёта) (\w*) ====/a);
	return $1;
} # }}}1

#TODO: out data format

=pod

=encoding utf8

=head1 NAME

Metadata::EAC - Извлекатель метаданных из логов Extract Audio Copy

=head1 VERSION

Version 0.00

=cut

our $VERSION = '0.00';


=head1 SYNOPSIS

Извлекает метаданные из логов Extract Audio Copy.

=head1 EXPORT

=head2 L<eac_parse>

Единственная экспортируемая функция, которая  выполняет всю необходимую работу

    use Metadata::EAC;

    my %foo = eac_parse($Filename);

		%foo:
		{
			RIP_DATE => "12 December 2014",
			ACCURATE_RIPPED => 1,
			DISK_CRC => "01234567"
			LOG_HASH => "............"
			...etc
		}

=cut

=head1 OTHER SUBROUTINES

Прочие функции которые не должны экспортироваться кроме особых случаев.

=head2 I<parse>

Алиас функции eac_parse. Удобен для вызова C<Metadata::EAC::parse($File)>

=head2 I<get_version>

=over 2

=item Определяет версию EAC сделавшей копию диска.

=item C<my $Ver = get_version($Filecontent);>

=item C<say $Ver; # 0.99 or 1.0 or 1.5>

=item Старые или неизвестные версии возвращают B<undef>

=back

=head2 I<ripping_date>

=over 2

=item Определяет дату рипа. Возвращает строку вида "ДД Месяц ГГГГ". Например "24 December 2014". Название месяца B<всегда> по-английски.

=item C<my $Date = ripping_date($Filecontent)>

=back

=head2 I<accurate_mode>

=over 2

=item Определяет был ли использован I<точный> режим. Возвращает 1 или B<undef>

=item C<$A = accurate_mode($Filecontent)>

=back

=cut

=head2 I<disk_CRC>

=over 2

=item Извлекает CRC-сумму диска из LOG-файла. При отсуствии возвращает B<undef>

=item C<$CRC = disk_CRC($Filecontent)>

=back

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

=head1 LIMITATIONS

=over 4

=item * Парсятся логи только на английском и русском.

=item * Только некоторые версии EAC распознаются в настоящий момент.

=back

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2023 by Alexander Makarov.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Metadata::EAC

