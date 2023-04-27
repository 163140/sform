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

use Test::More tests => 4;
use File::Basename;
use File::Spec;
use FindBin qw($Bin);
use lib File::Spec->catdir(File::Spec->updir($Bin), 'lib');

use Metadata::EAC qw(get_version ripping_date);
use v5.36;

use File::Slurper qw(read_text read_lines);

my $EAC_TESTDATA	= File::Spec->catdir($Bin, "eac_testdata");

my $LOG_1_0_b3 		= File::Spec->catfile($EAC_TESTDATA, "1.0.b3-29.08.11.log");
my $LOG_1_5    		= File::Spec->catfile($EAC_TESTDATA, "1.5-20.02.2020.log");


# TODO: надо проверить имеет ли смысл парсить по строки, в плане производительности
#my $File = read_text($Filename);
#my @File = read_lines($Filename);

# ok( ultimate_answer() eq 42,        "Meaning of Life" );
# ok( $foo ne '',     "Got some foo" );

say "\nВерсия EAC 1.0 beta 3 перекодированная из UCS-2 в UTF-8";
ok ( get_version(read_text($LOG_1_0_b3),  read_lines($LOG_1_0_b3)) eq '1.0 beta 3', "Получение версии // get_version" );
ok ( ripping_date(read_text($LOG_1_0_b3), read_lines($LOG_1_0_b3)) eq '27 February 2014', "Получение версии // ripping_date" );

say "\nВерсия EAC 1.0 beta 3 перекодированная из UCS-2 в UTF-8 в Windows 10 блокнотом";
ok ( get_version(read_text($LOG_1_5),  read_lines($LOG_1_5)) eq '1.5', "Получение версии // get_version" );
ok ( ripping_date(read_text($LOG_1_5), read_lines($LOG_1_5)) eq '27 July 2020', "Получение версии // ripping_date" );
