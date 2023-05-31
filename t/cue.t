#!/usr/bin/env perl vim: foldmethod=marker
#===============================================================================
#         FILE: cue.t
#
#  DESCRIPTION: for CUE.pm testing
#
#      VERSION: 0.0
#      CREATED: 27.05.2023 15:34
#===============================================================================

use utf8;
use v5.36;
use strict;
use warnings;
use feature qw (try);
no warnings "experimental::try";
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");
binmode(STDERR, ":utf8");
use open ':encoding(UTF-8)';
use feature 'unicode_strings';

use Test::More;
use Test::More::UTF8;
use File::Spec;
use FindBin qw($Bin);
use File::Slurper qw(read_text);
use Data::Dumper::Concise;
use constant DEBUG => 1;
# use Smart::Comments;

use lib File::Spec->catdir(File::Spec->updir($Bin), 'lib');

use Metadata::CUE qw(:TEST);
my $CUE_TESTDATA	= File::Spec->catdir($Bin, "cue_testdata");

sub read_the_cue($Cue)
{# {{{1
	say "Reading a $Cue";
	try					{ read_text(File::Spec->catfile($CUE_TESTDATA, $Cue)); }
	catch ($e)	{ warn "$Cue can't be used: $e"; return ''; }
} # }}}1

my %MSG =( # выводимые сообщения при тестировании
	# {{{1
			get_date			=> "Извлечение годы выхода альбома // get_date",
			get_genre			=> "Определение жанра // get_genre",
			get_diskid		=> "Определение ID диска // get_giscid",
			get_album			=> "Извлечения названия альбома // get_album",
			get_totaldiscs=> "Определение кол-ва дисков // get_totaldiscs",
			get_catalognum=> "Извлечение номера каталога // get_catalognum",
			get_comment		=> "Извлечение полезного коментария // get_comment",
			get_reissue		=> "Извлечение перевыпуска альбома // get_reissue" ,
			track					=> "Извлечение данных трека № "
); # }}}1

my @SKELETON = ( # образец
# {{{1
			{
				filename			=> "01.cue",
				# {{{2
				get_date			=> 2000,
				get_genre			=> "Black Metal",
				get_diskid		=> undef,
				get_album			=> "",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' => {
						TRACKNUM	=>"01",
						TITLE			=>"",
						PERFORMER	=>"",
						DISCNUMBER=>undef },
					'02' => {
						TRACKNUM	=>"02",
						TITLE			=>"",
						PERFORMER	=>"",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
); # }}}

my @CUE_list_1 = ( # лист с куями
# {{{1
			{
				filename			=> "01.cue",
				# {{{2
				get_date			=> 2005,
				get_genre			=> "Black Metal",
				get_diskid		=> undef,
				get_album			=> "Joulu-single",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
				# }}}2
				# {{{2
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Teuras",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Kansallispäivä",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
				}
				# }}}2
			},
			{
				filename			=> "02.cue",
				# {{{2
				get_date			=> 2007,
				get_genre			=> "Black Metal",
				get_diskid		=> undef,
				get_album			=> "Kalmanto",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				# }}}2
				# {{{2
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Ilkitie",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
					'07' =>{
						TRACKNUM	=>"07",
						TITLE			=>"Naimalaulu",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
				}
				# }}}2
			},
			{
				filename			=> "03.cue",
				# {{{2
				get_date			=> 2011,
				get_genre			=> "Black Metal",
				get_diskid		=> undef,
				get_album			=> "Murhat",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				# }}}2
				# {{{2
				track => {
					'04' =>{
						TRACKNUM	=>"04",
						TITLE			=>"Aura",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
					'09' => {
						TRACKNUM	=>"09",
						TITLE			=>"Veljet",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
				}
				# }}}2
			},
			{
				filename			=> "04.cue",
				# {{{2
				get_date			=> 2009,
				get_genre			=> "Acoustic",
				get_diskid		=> undef,
				get_album			=> "Noitumaa",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				# }}}2
				# {{{2
				track => {
					'03' =>{
						TRACKNUM	=>"03",
						TITLE			=>"Mitä Kuolema Parantaa?",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
					'08' =>{
						TRACKNUM	=>"08",
						TITLE			=>"Säkeitä Riippuneesta Lihasta",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
				}
				# }}}2
			},
			{
				filename			=> "05.cue",
				# {{{2
				get_date			=> 2004,
				get_genre			=> "Dark & Black Metal",
				get_diskid		=> undef,
				get_album			=> "Tyhjyys",
				get_totaldiscs=> 1,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				# }}}2
				# {{{2
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Intro",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
					'10' =>{
						TRACKNUM	=>"10",
						TITLE			=>"Tyhjyydestä",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
				}
				# }}}2
			},
			{
				filename			=> "06.cue",
				# {{{2
				get_date			=> 2006,
				get_genre			=> "Black Metal",
				get_diskid		=> undef,
				get_album			=> "Äpäre",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Hurmasta",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Kaato",
						PERFORMER	=>"Ajattara",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "07.cue",
				# {{{2
				get_date			=> 2007,
				get_genre			=> "Black Metal",
				get_diskid		=> "5609D607",
				get_album			=> "Extermination Followed by Cryptic Silence",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Voices From the Crypts",
						PERFORMER	=>"Amystery",
						DISCNUMBER=>undef },
					'07' =>{
						TRACKNUM	=>"07",
						TITLE			=>"Icy Kingdom",
						PERFORMER	=>"Amystery",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "08.cue",
				# {{{2
				get_date			=> 1999,
				get_genre			=> "Electronic/Industrial Metal",
				get_diskid		=> "820BFE0A",
				get_album			=> "Animatronic",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> "Reissue 2009",
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Mirrors Paradise",
						PERFORMER	=>"The Kovenant",
						DISCNUMBER=>undef },
					'09' =>{
						TRACKNUM	=>"09",
						TITLE			=>"Spaceman",
						PERFORMER	=>"The Kovenant",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "09.cue",
				# {{{2
				get_date			=> 2011,
				get_genre			=> "Black Metal",
				get_diskid		=> "65098C08",
				get_album			=> "Blood Magick Necromance",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"In Blood - Devour this Sanctity",
						PERFORMER	=>"Belphegor",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Rise to Fall and Fall to Rise",
						PERFORMER	=>"Belphegor",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "10.cue",
				# {{{2
				get_date			=> 1993,
				get_genre			=> "Black Metal",
				get_diskid		=> "25054004",
				get_album			=> "Bloodbath In Paradise",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Bloodbath In Paradise",
						PERFORMER	=>"Belphegor",
						DISCNUMBER=>1 },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Graves Of Sorrow",
						PERFORMER	=>"Belphegor",
						DISCNUMBER=>1 },
				},
				# }}}2
			},
			{
				filename			=> "11.cue",
				# {{{2
				get_date			=> 1997,
				get_genre			=> "Black Metal",
				get_diskid		=> "86086D09",
				get_album			=> "Blutsabbath",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Abschworung",
						PERFORMER	=>"Belphegor",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Blackest Ecstasy",
						PERFORMER	=>"Belphegor",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "12.cue",
				# {{{2
				get_date			=> 2008,
				get_genre			=> "NS Black Metal",
				get_diskid		=> "4D0BAA06",
				get_album			=> "Europa; Or, The Spirit Among The Ruins",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Heathen Mysticism pt I",
						PERFORMER	=>"Flame of War",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"05",
						TITLE			=>"Long Live Death!",
						PERFORMER	=>"Flame of War",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "13.cue",
				# {{{2
				get_date			=> 2009,
				get_genre			=> "NS Black Metal",
				get_diskid		=> "1F0D6E03",
				get_album			=> "Transcendence",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Transcendence",
						PERFORMER	=>"Flame of War",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Unity",
						PERFORMER	=>"Flame of War",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "14.cue",
				# {{{2
				get_date			=> 2012,
				get_genre			=> undef,
				get_diskid		=> "7C0B320A",
				get_album			=> "The Lord of Steel [Hammer ed.]",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"The Lord of Steel",
						PERFORMER	=>"Manowar",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Manowariors",
						PERFORMER	=>"Manowar",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "15.cue",
				# {{{2
				get_date			=> undef,
				get_genre			=> undef,
				get_diskid		=> undef,
				get_album			=> "Vexilla Regis Prodeunt Inferni",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Mirrorland",
						PERFORMER	=>"Noctes",
						DISCNUMBER=>undef },
					'09' =>{
						TRACKNUM	=>"09",
						TITLE			=>"Persephone",
						PERFORMER	=>"Noctes",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "16.cue",
				# {{{2
				get_date			=> 1994,
				get_genre			=> "Black Metal",
				get_diskid		=> "910CB70B",
				get_album			=> "Black Arts Lead to Everlasting Sins",
				get_totaldiscs=> undef,
				get_catalognum=> undef, # 0000000000000 means undef
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Lord of the Abyss (Necromantia)",
						PERFORMER	=>"Necromantia & Varathron",
						DISCNUMBER=>undef },
					'06' =>{
						TRACKNUM	=>"06",
						TITLE			=>"The Cult of the Dragon (Varathron)",
						PERFORMER	=>"Necromantia & Varathron",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "17.cue",
				# {{{2
				get_date			=> 2000,
				get_genre			=> "Symphonic Black Metal",
				get_diskid		=> "880C2C0A",
				get_album			=> "Nexus Polaris",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> "Reissue 2009",
				track => {
					'01' =>{
						TRACKNUM	=>"09",
						TITLE			=>"New World Order",
						PERFORMER	=>"The Kovenant",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"10",
						TITLE			=>"New World Order",
						PERFORMER	=>"The Kovenant",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "18.cue",
				# {{{2
				get_date			=> 1999,
				get_genre			=> "Black Death Doom Metal",
				get_diskid		=> "A50F0F0C",
				get_album			=> "Nocturne",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"11",
						TITLE			=>"At Parting",
						PERFORMER	=>"Radigost",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Until",
						PERFORMER	=>"Radigost",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "19.cue",
				# {{{2
				get_date			=> 2003,
				get_genre			=> "Gothic Industrial Metal",
				get_diskid		=> "BE12300E",
				get_album			=> "SETI",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> "Reissue 2009",
				track => {
					'01' =>{
						TRACKNUM	=>"13",
						TITLE			=>"Subtopia",
						PERFORMER	=>"The Kovenant",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"14",
						TITLE			=>"The Memory Remains",
						PERFORMER	=>"The Kovenant",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "20.cue",
				# {{{2
				get_date			=> 2011,
				get_genre			=> undef,
				get_diskid		=> "5C0B7707",
				get_album			=> "Celestial Lineage",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Thuja Magus Imperium",
						PERFORMER	=>"Wolves In The Throne Room",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Permanent Changes In Consciousness",
						PERFORMER	=>"Wolves In The Throne Room",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "21.cue",
				# {{{2
				get_date			=> 1996,
				get_genre			=> "Atmospheric Black Metal",
				get_diskid		=> undef,
				get_album			=> "Winterfrost",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Intro",
						PERFORMER	=>"Forsth",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Waldpfad",
						PERFORMER	=>"Forsth",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "22.cue",
				# {{{2
				get_date			=> 2010,
				get_genre			=> "Black Metal",
				get_diskid		=> "7907C509",
				get_album			=> "Demonicon",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"The Leader of Fallens (Azazel)",
						PERFORMER	=>"Besatt",
						DISCNUMBER=>undef },
					'03' =>{
						TRACKNUM	=>"03",
						TITLE			=>"The Ninth Spirit (Paimon)",
						PERFORMER	=>"Besatt",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "23.cue",
				# {{{2
				get_date			=> 2006,
				get_genre			=> "Black Metal",
				get_diskid		=> "5D09BD08",
				get_album			=> "Black Mass",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Black Mass",
						PERFORMER	=>"Besatt",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Born to Revange",
						PERFORMER	=>"Besatt",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "24.cue",
				# {{{2
				get_date			=> 2009,
				get_genre			=> "Black Metal",
				get_diskid		=> "990E180C",
				get_album			=> "Visionary",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Apenbaring",
						PERFORMER	=>"Dødsengel",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Word of Uncreation",
						PERFORMER	=>"Dødsengel",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "25.cue",
				# {{{2
				get_date			=> undef,
				get_genre			=> undef,
				get_diskid		=> undef,
				get_album			=> "Storm of The Light's Bane",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'05' =>{
						TRACKNUM	=>"05",
						TITLE			=>"Retribution - Storm of the Light's Bane",
						PERFORMER	=>"Dissection",
						DISCNUMBER=>undef },
					'08' =>{
						TRACKNUM	=>"08",
						TITLE			=>"No Dreams Breed In Breathless Sleep",
						PERFORMER	=>"Dissection",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "26.cue",
				# {{{2
				get_date			=> 2001,
				get_genre			=> "Black Metal",
				get_diskid		=> "140A2C3D",
				get_album			=> "Death's Design",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"1st Movement: Nerves In Rush",
						PERFORMER	=>"Diabolical Masquerade",
						DISCNUMBER=>undef },
					'53' =>{
						TRACKNUM	=>"53",
						TITLE			=>"17th Movement: Still Part of the Design - The Hunt (Part III)",
						PERFORMER	=>"Diabolical Masquerade",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "27.cue",
				# {{{2
				get_date			=> 2011,
				get_genre			=> "Black Metal",
				get_diskid		=> "0205E001",
				get_album			=> "Spectres Over Transylvania",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Spectres Over Transylvania",
						PERFORMER	=>"Cultes Des Ghoules",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "28.cue",
				# {{{2
				get_date			=> 2012,
				get_genre			=> "Other",
				get_diskid		=> "94126F0A",
				get_album			=> "Midnight In The Labyrinth",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"A Gothic Romance (Red Roses For the Devils Whore)",
						PERFORMER	=>"Cradle of Filth",
						DISCNUMBER=>1 },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"The Forest Whispers My Name",
						PERFORMER	=>"Cradle of Filth",
						DISCNUMBER=>1 },
				},
				# }}}2
			},
			{
				filename			=> "29.cue",
				# {{{2
				get_date			=> 2012,
				get_genre			=> "Other",
				get_diskid		=> "7C0F2409",
				get_album			=> "Midnight In The Labyrinth",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"11",
						TITLE			=>"The Rape and Ruin of Angels (Hosannas In Extremis)",
						PERFORMER	=>"Cradle of Filth",
						DISCNUMBER=>2 },
					'02' =>{
						TRACKNUM	=>"12",
						TITLE			=>"Dusk and Her Embrace",
						PERFORMER	=>"Cradle of Filth",
						DISCNUMBER=>2 },
				},
				# }}}2
			},
			{
				filename			=> "30.cue",
				# {{{2
				get_date			=> undef,
				get_genre			=> undef,
				get_diskid		=> "4E0E0406",
				get_album			=> "Bleak...",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"When Even Tomorrow Looks Away",
						PERFORMER	=>"Austere",
						DISCNUMBER=>undef },
					'05' =>{
						TRACKNUM	=>"05",
						TITLE			=>"Mosaic",
						PERFORMER	=>"Isolation",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "31.cue",
				# {{{2
				get_date			=> 2003,
				get_genre			=> "Symphonic Metal",
				get_diskid		=> "FD10B012",
				get_album			=> "Reflections (Revised)",
				get_totaldiscs=> undef,
				get_catalognum=> "0602498658307",
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Prologue (Apprehension)",
						PERFORMER	=>"Apocalyptica",
						DISCNUMBER=>undef },
					'14' =>{
						TRACKNUM	=>"14",
						TITLE			=>"Seemann",
						PERFORMER	=>"Apocalyptica",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "32.cue",
				# {{{2
				get_date			=> 2010,
				get_genre			=> "Metal",
				get_diskid		=> "8A0D820C",
				get_album			=> "7th Symphony",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'03' =>{
						TRACKNUM	=>"03",
						TITLE			=>"Not Strong Enough",
						PERFORMER	=>"Apocalyptica",
						DISCNUMBER=>undef },
					'09' =>{
						TRACKNUM	=>"09",
						TITLE			=>"Bring Them to Light",
						PERFORMER	=>"Apocalyptica",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "33.cue",
				# {{{2
				get_date			=> 2010,
				get_genre			=> "Metal",
				get_diskid		=> "BE0FD20F",
				get_album			=> "7th Symphony (Japanese Edition)",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'13' =>{
						TRACKNUM	=>"13",
						TITLE			=>"Spiral Architect",
						PERFORMER	=>"Apocalyptica",
						DISCNUMBER=>undef },
					'14' =>{
						TRACKNUM	=>"14",
						TITLE			=>"Path",
						PERFORMER	=>"Apocalyptica",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "34.cue",
				# {{{2
				get_date			=> 2000,
				get_genre			=> "Black Metal / Grindcore",
				get_diskid		=> "7B0B950A",
				get_album			=> "Total Fucking Necro",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'04' =>{
						TRACKNUM	=>"04",
						TITLE			=>"Carnage",
						PERFORMER	=>"Anaal Nathrakh",
						DISCNUMBER=>undef },
					'07' =>{
						TRACKNUM	=>"07",
						TITLE			=>"L.E.T.H.A.L. : Diabolic",
						PERFORMER	=>"Anaal Nathrakh",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "35.cue",
				# {{{2
				get_date			=> 2006,
				get_genre			=> "Metal",
				get_diskid		=> "2003C403",
				get_album			=> "Ruines Humaines",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Bonheur Ampute",
						PERFORMER	=>"Amesoeurs",
						DISCNUMBER=>undef },
					'02' =>{
						TRACKNUM	=>"02",
						TITLE			=>"Ruines Humaines",
						PERFORMER	=>"Amesoeurs",
						DISCNUMBER=>undef },
				},
				# }}}2
			},
			{
				filename			=> "36.cue",
				# {{{2
				get_date			=> 2006,
				get_genre			=> "Black Metal",
				get_diskid		=> "690AB408",
				get_album			=> "Silva Nordica",
				get_totaldiscs=> undef,
				get_catalognum=> undef,
				get_comment		=> undef,
				get_reissue		=> undef,
				track => {
					'01' =>{
						TRACKNUM	=>"01",
						TITLE			=>"Summer's End",
						PERFORMER	=>"Alastor",
						DISCNUMBER=>undef },
					'05' =>{
						TRACKNUM	=>"05",
						TITLE			=>"Prologue",
						PERFORMER	=>"Alastor",
						DISCNUMBER=>undef },
				},
				# }}}2
			}
); # }}}1

# TODO: доделать тестирование извлекателя треков
sub make_tests($Msg, @List) { # 8 functions
#{{{
	### @List
	### $Msg
	for my $File (@List) {
		### $File
		my $Filecontent = read_the_cue($File->{filename});
		my %Funcs_to_test = (
				get_date			=> \&get_date,
				get_genre			=> \&get_genre,
				get_diskid		=> \&get_diskid,
				get_album			=> \&get_album,
				get_totaldiscs=> \&get_totaldiscs,
				get_catalognum=> \&get_catalognum,
				get_comment		=> \&get_comment,
				get_reissue		=> \&get_reissue
		);

		foreach my $Testing_func (sort keys %Funcs_to_test) {
			### Обработка файла
			my $Func = $Funcs_to_test{$Testing_func};
			my $Out = $Testing_func;
			### $Out
			### $Func
			### $File->{$Out} VALUE: $File->{$Out}
			### $Msg->{$Out} VALUE: $Msg->{$Out}
			is ( $Func->($Filecontent), $File->{$Out}, $Msg->{$Out}  )
		}




	}
} # }}}

make_tests(\%MSG, @CUE_list_1);

my $number_of_tests_run = 8 * (
	scalar @CUE_list_1 +
	0 );

done_testing( $number_of_tests_run );
