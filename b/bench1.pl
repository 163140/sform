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

use Benchmark qw(timethese);
use File::Spec;
use FindBin qw($Bin);
use v5.36;
use File::Slurper qw(read_text read_lines);
use Data::Dumper;

my $DATA	= File::Spec->catfile($Bin, "bench1.dat");

my $File = read_text($DATA);
my @File = read_lines($DATA);

say "Вариант 1. Чтение файла в каждой иттерации";
timethese(100_000, {
		'Чтение по линиям и паттер матчинг' => sub {
				my @File = read_lines($DATA);
				$File[0] =~ /Audio Copy V(\d.\d.*) from/;
		},
		'Чтение всего файла' => sub {
				my $File = read_text($DATA);
				$File =~ /Audio Copy V(\d.\d.*) from/;
		},
	});

say "Вариант 2. Чтение файлоы вне иттераций";
my @File2 = read_lines($DATA);
my $File2 = read_text($DATA);
timethese(10_000_000, {
		'Чтение по линиям и паттер матчинг' => sub {
				$File2[0] =~ /Audio Copy V(\d.\d.*) from/;
		},
		'Чтение всего файла' => sub {
				$File2 =~ /Audio Copy V(\d.\d.*) from/;
		},
	});

say "Разница между вариантами во времени чтения файла. Нет принципиальной разницы между паттерн-мэтчингом всего файла или одной строки из него"
