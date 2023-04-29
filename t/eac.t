#
#===============================================================================
#
#         FILE: eac.t
#
#  DESCRIPTION:
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: EA1A87 (), 163140@autistici.org
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 25.04.2023 23:06:50
#     REVISION: ---
#===============================================================================

use v5.36;
use strict;
use warnings;
use feature qw (try);
no warnings "experimental::try";

use Test::More;
use File::Spec;
use FindBin qw($Bin);
use File::Slurper qw(read_text);

use lib File::Spec->catdir(File::Spec->updir($Bin), 'lib');

use Metadata::EAC qw(:TEST);
my $EAC_TESTDATA	= File::Spec->catdir($Bin, "eac_testdata");

sub read_the_log($Log)
{# {{{1
	say "Reading a $Log";
	try					{ read_text File::Spec->catfile($EAC_TESTDATA, $Log); }
	catch ($e)	{ warn "$Log can't be used: $e";
								return '';
							}
} # }}}1

my @SKELETON = ("EAC logfile version ...",
# {{{1
		{
			file => read_the_log( "0.99.pb3-1-ru.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg	=> "Извлечение версии EAC // get_version"	},
			ripping_date=>	{	result => "24 December 2007",
												msg => "Извлечение даты рипа // ripping_date"	},
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode"},
			disk_CRC		 =>	{	result => "25262401",
												msg => "Чексумма копии // disk_CRC"},
		}, # }}}
); # }}}

my @LOG_0_99_pb3 = ( "EAC logfile version 0.99 prebeta 3", # 4 files
# {{{1
		{
			file => read_the_log( "0.99.pb3-1-ru.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "24 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "25262401",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb3-2-ru.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "26 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "655CB5C7",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb3-3-ru.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "26 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "4063F438",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb3-4-ru.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "23 December 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "EF510829",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
); # }}}

my @LOG_0_99_pb4 = ( "EAC logfile version 0.99 prebeta 4", # 1 files
# {{{1
		{
			file => read_the_log( "0.99.pb4-1.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "16 January 2010",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "3CCAB0FC",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		# UTF-8 ill-formed file
		# file => read_the_log( "0.99.pb4-2-fin.log" ),
); # }}}

my @LOG_0_99_pb5 = ( "EAC logfile version 0.99 prebeta 5", # 6 files
# {{{1
		{
			file => read_the_log( "0.99.pb5-1-ru.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "23 July 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "341D7876",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb5-2.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "1 January 2010",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb5-3.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "25 October 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "A599B42B",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb5-4.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "25 April 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "3BE5F785",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb5-5.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "14 February 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "8CCFD743",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "0.99.pb5-6.log" ),
			# {{{2
			get_version =>	{	result => 0.99,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "11 September 2010",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		# UTF-8 ill-formed files
		# file => read_the_log( "0.99.pb5-7.log" ),
		# file => read_the_log( "0.99.pb5-8.log" ),
		# file => read_the_log( "0.99.pb5-9-fin.log" ),
		# file => read_the_log( "0.99.pb5-10-fin.log" ),
); # }}}

my @LOG_1_0_b1 = ("EAC logfile version 1.0 beta 1", # 5 files
# {{{1
		{
			file => read_the_log( "1.0.b1-1.log" ),
			#{{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "15 March 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, #}}}
		{
			file => read_the_log( "1.0.b1-2.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "6 March 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "1.0.b1-3.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "7 September 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "1.0.b1-4.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "22 March 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "1.0.b1-5.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "12 April 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
); # }}}1

my @LOG_1_0_b3 = ("EAC logfile version 1.0 beta 3", # 5 files
# {{{1
		{
			file => read_the_log( "1.0.b3-1.log" ),
			#{{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "27 February 2011",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "1E1DD436",
												msg => "Чексумма копии // disk_CRC" },
		}, #}}}
		{
			file => read_the_log( "1.0.b3-2.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "5 January 2013",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "20B346B6",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "1.0.b3-3.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "5 January 2013",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "3B2FF9E3",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "1.0.b3-4-ru.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "8 March 2012",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "572BBD86",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		{
			file => read_the_log( "1.0.b3-5-ru.log" ),
			# {{{2
			get_version =>	{	result => 1,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "19 September 2013",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "6A7072FA",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
); # }}}1

my @LOG_1_5 = ("EAC logfile version 1.5", # 1 file
# {{{1
		{
			file => read_the_log( "1.5-1.log" ),
			# {{{2
			get_version =>	{	result => 1.5,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "27 July 2020",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => "987253F7",
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
); # }}}

my @LOG_UNUSIAL = ("Unusial EAC logfiles (look like very old)", # 2 files
# {{{1
	[
		{
			file => read_the_log( "unusial 12.11.2007.log" ),
			# {{{2
			get_version =>	{	result => undef,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "12 November 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
		# UTF-8 ill-formed file
		# file => read_the_log( "unusial 18.06.2008-1.log" ),
		# file => read_the_log( "unusial 18.06.2008-2.log" ),
		{
			file => read_the_log( "unusial 23.10.2007.log" ),
			# {{{2
			get_version =>	{	result => 0,
												msg => "Извлечение версии EAC // get_version" },
			ripping_date=>	{	result => "23 October 2007",
												msg => "Извлечение даты рипа // ripping_date" },
			accurate_mode=>	{	result => 1,
												msg => "Режим точного чтения // accurate_mode" },
			disk_CRC		 =>	{	result => undef,
												msg => "Чексумма копии // disk_CRC" },
		}, # }}}
	]
); # }}}

sub make_tests($Begin_Msg, @List) { # 4 functions
#{{{
	say $Begin_Msg;
	for (@List) {
		is (get_version($_->{file}),	$_->{result},	$_->{get_version}{msg});
		is (ripping_date($_->{file}),	$_->{result},	$_->{ripping_date}{msg});
		is (accurate_mode($_->{file}),$_->{result},	$_->{accurate_mode}{msg});
		is (disk_CRC($_->{file}),			$_->{result},	$_->{disk_CRC}{msg});
	}
} # }}}

make_tests(@LOG_0_99_pb3);
make_tests(@LOG_0_99_pb4);
make_tests(@LOG_0_99_pb5);
make_tests(@LOG_1_0_b1);
make_tests(@LOG_1_0_b3);
make_tests(@LOG_1_5);

my $number_of_tests_run = 4 * (
	scalar @LOG_0_99_pb3-1	+ scalar @LOG_0_99_pb4-1 + 
	scalar @LOG_0_99_pb5-1	+ scalar @LOG_1_0_b1	-1 + 
	scalar @LOG_1_0_b3	-1	+ scalar @LOG_1_5			-1 );

done_testing( $number_of_tests_run );
