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

use strict;
use warnings;

use Test::More tests => 8;
use File::Basename;
use File::Spec;
use FindBin qw($Bin);
use lib File::Spec->catdir(File::Spec->updir($Bin), 'lib');

use Metadata::EAC qw(:TEST);
use v5.36;

use File::Slurper qw(read_text read_lines);

my $EAC_TESTDATA	= File::Spec->catdir($Bin, "eac_testdata");

my $LOG_1_0_b3 		= read_text File::Spec->catfile($EAC_TESTDATA, "1.0.b3-29.08.11.log");
my $LOG_1_5    		= read_text File::Spec->catfile($EAC_TESTDATA, "1.5-20.02.2020.log");

say "\nВерсия логов EAC 1.0 beta 3 перекодированная из UCS-2 в UTF-8";
is ( get_version($LOG_1_0_b3),	'1',								"Получение версии // get_version" );
is ( ripping_date($LOG_1_0_b3),	'27 February 2014',	"Получение версии // ripping_date" );
is ( accurate_mode($LOG_1_0_b3),1,									"Точное чтение? // accurate_mode" );
is ( disk_CRC($LOG_1_0_b3),			"1E1DD436",					"Чексумма диска // disk_CRC");

say "\nВерсия логов EAC 1.5 перекодированная из UCS-2 в UTF-8 в Windows 10 блокнотом";
is ( get_version($LOG_1_5),		'1.5',								"Получение версии // get_version" );
is ( ripping_date($LOG_1_5),	'27 July 2020',				"Получение версии // ripping_date" );
is ( accurate_mode($LOG_1_5),	1,										"Точное чтение? // accurate_mode" );
is ( disk_CRC($LOG_1_5),			"987253F7",						"Чексумма диска // disk_CRC");
