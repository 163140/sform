#!/usr/bin/env perl vim: foldmethod=marker
#===============================================================================
#         FILE: eac.t
#
#  DESCRIPTION: for EAC.pm testing
#
#      VERSION: 0.0
#      CREATED: 25.04.2023 23:06:50
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

use lib File::Spec->catdir(File::Spec->updir($Bin), 'lib');

use Metadata::EAC qw(:TEST);
my $EAC_TESTDATA	= File::Spec->catdir($Bin, "eac_testdata");

sub read_the_log($Log)
{# {{{1
	say "Reading a $Log";
	try					{ read_text(File::Spec->catfile($EAC_TESTDATA, $Log)); }
	catch ($e)	{ warn "$Log can't be used: $e"; return ''; }
} # }}}1

my @SKELETON = ("EAC logfile version ...",
# {{{1
		{
			file => "0.99.pb3-1-ru.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg	=> "Извлечение версии EAC // get_version"	},
			ripping_date=>	{	result => "24 December 2007",
												msg => "Извлечение даты рипа // ripping_date"	},
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode"},
			disk_CRC		 =>	{	result => "25262401",
												msg => "Чексумма копии // disk_CRC"},
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
); # }}}

my @LOG_0_99_pb3 = ( "EAC logfile version 0.99 prebeta 3", # 4 files
# {{{1
		{
			file => "0.99.pb3-1-ru.log",
			# {{{2.
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "24 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "25262401",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb3-2-ru.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "26 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "655CB5C7",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb3-3-ru.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "26 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "4063F438",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb3-4-ru.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "23 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "EF510829",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
); # }}}

my @LOG_0_99_pb4 = ( "EAC logfile version 0.99 prebeta 4", # 1 files
# {{{1
		{
			file => "0.99.pb4-1.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "16 January 2010",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "3CCAB0FC",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		# UTF-8 ill-formed file
		# file => "0.99.pb4-2-fin.log",
); # }}}

my @LOG_0_99_pb5 = ( "EAC logfile version 0.99 prebeta 5", # 6 files
# {{{1
		{
			file => "0.99.pb5-1-ru.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "23 July 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "341D7876",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb5-2.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "1 January 2010",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb5-3.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "25 October 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "A599B42B",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb5-4.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "25 April 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "3BE5F785",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb5-5.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "14 February 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "8CCFD743",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "0.99.pb5-6.log",
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "11 September 2010",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		# UTF-8 ill-formed files
		# file => "0.99.pb5-7.log",
		# file => "0.99.pb5-8.log",
		# file => "0.99.pb5-9-fin.log",
		# file => "0.99.pb5-10-fin.log",
); # }}}

my @LOG_1_0_b1 = ("EAC logfile version 1.0 beta 1", # 5 files
# {{{1
		{
			file => "1.0.b1-1.log",
			#{{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "15 March 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "56FA15945C33F1CE8415DE725A9882DD39CF198BD31FAC91F17136EECAA57F1F",
												msg => "Чексумма лога // log_checksum"},
		}, #}}}
		{
			file => "1.0.b1-2.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "6 March 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "E1DFC8F7CE07B0CACB16CEEED74F92226A8DB965FC34D8A0222DAE215115CA85",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "1.0.b1-3.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "7 September 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "E5C829128C318347B8E8BA1415A4CCC1E6AEA123C67D68770EF2A00A9DB33835",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "1.0.b1-4.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "22 March 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "79E83F5D",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "CDCA0C1251ED70503F1E0124642B6F868B8659B82A55AE5E5BDF52BF00302048",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "1.0.b1-5.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "12 April 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "48B477315D572887FF82269309E28CDAB80965B7DE40CC5205A58D22B8D9AA9C",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
); # }}}1

my @LOG_1_0_b3 = ("EAC logfile version 1.0 beta 3", # 5 files
# {{{1
		{
			file => "1.0.b3-1.log",
			#{{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "27 February 2014",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "1E1DD436",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "1A7C33E43AAC6D719F96146237A845A5BE9EDF18AB598B1B08A51C3764D5BDEA",
												msg => "Чексумма лога // log_checksum"},
		}, #}}}
		{
			file => "1.0.b3-2.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "5 January 2013",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "20B346B6",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "26F8A709F9304E85A21F3D0B0005AFE6E2B2B1CDA8A6B0795852FD8F2CB208C7",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "1.0.b3-3.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "5 January 2013",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "3B2FF9E3",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "AF5EF86D19F643B6672FDCD358C3995898DEE518E3C75D9EFAE0F4C44A0692DD",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "1.0.b3-4-ru.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "8 March 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "572BBD86",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "934E1ABA5A24D8F93052EE8D0B952ED28D0AD54BE9C4C662D990F131422F1914",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		{
			file => "1.0.b3-5-ru.log",
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "19 September 2013",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "6A7072FA",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "A85D3512FCE5B7631AC4CC74B36059F1D03F18D1A46D88B79FE5D21C3FB42C8E",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
); # }}}1

my @LOG_1_5 = ("EAC logfile version 1.5", # 1 file
# {{{1
		{
			file => "1.5-1.log",
			# {{{2
			get_version =>	{	result => 1.5,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "27 July 2020",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "987253F7",
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => "82160162E96B99E448CCDECF0CF154E6D89A18911B7D87C085A77245EC02E043",
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
); # }}}

my @LOG_UNUSIAL = ("Unusial EAC logfiles (look like very old)", # 2 files
# {{{1
	[
		{
			file => "unusial 12.11.2007.log",
			# {{{2
			get_version =>	{	result => undef,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "12 November 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
		# UTF-8 ill-formed file
		# file => "unusial 18.06.2008-1.log",
		# file => "unusial 18.06.2008-2.log",
		{
			file => "unusial 23.10.2007.log",
			# {{{2
			get_version =>	{	result => 0,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "23 October 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
			checksum		 =>	{	result => undef,
												msg => "Чексумма лога // log_checksum"},
		}, # }}}
	]
); # }}}

sub make_tests($Begin_Msg, @List) { # 4 functions
#{{{
	say $Begin_Msg;
	for (@List) {
		my $Filecontent = read_the_log($_->{file});
		is (get_version		($Filecontent),
											 $_->{get_version}{result},	$_->{get_version}{msg});
		is (ripping_date	($Filecontent),
											 $_->{ripping_date}{result},	$_->{ripping_date}{msg});
		is (accurate_mode	($Filecontent),
											 $_->{accurate_mode}{result},	$_->{accurate_mode}{msg});
		is (disk_CRC			($Filecontent),
											 $_->{disk_CRC}{result},	$_->{disk_CRC}{msg});
		is (log_checksum	($Filecontent),
											 $_->{checksum}{result},			$_->{checksum}{msg});
	}
} # }}}

make_tests(@LOG_0_99_pb3);	# 4
make_tests(@LOG_0_99_pb4);	# 1
make_tests(@LOG_0_99_pb5);	# 6
make_tests(@LOG_1_0_b1);		# 5
make_tests(@LOG_1_0_b3);		# 4
make_tests(@LOG_1_5);			# 1

my $number_of_tests_run = 5 * (
	scalar @LOG_0_99_pb3-1	+
	scalar @LOG_0_99_pb4-1	+
	scalar @LOG_0_99_pb5-1	+
	scalar @LOG_1_0_b1	-1	+
	scalar @LOG_1_0_b3	-1	+
	scalar @LOG_1_5			-1 	+
	0 );

done_testing( $number_of_tests_run );
