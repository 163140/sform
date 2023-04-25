#!/usr/bin/perl
#
# eac.pl - парсер EAC лог-файлов
# Copyright (C) 2023  Alexander Makarov
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#===============================================================================
#        USAGE:  a library
#  DESCRIPTION:  Exact Audio Copy log parser
#
# REQUIREMENTS:  perl 5.36
#        NOTES:
#       AUTHOR:  163140@autistici.org
#      COMPANY:
#      CREATED:  25.04.2023 15:15:23
#     RDEPENDS:
#===============================================================================



use v5.36;
use File::Slurper qw(read_text read_lines);
use Memoize;
use feature "switch";
#use subs qw();

my $Filename = "/home/ea1a87/Soft/My/sm2f/eac_testdata/1.0.b3-29.08.11.log";
my $File = read_text($Filename);
my @File = read_lines($Filename);

# TODO: TEST IT!!!
# UNTESTED
get_eac_version($File, @File) { # return $Ver
	# Версия на первой строке
	$File[0] =~ /Audio Copy (V\d.\d.*) from/
	my $Ver =~ $1;
	if (not $1) {
		# нету версии на первой строке, пробуем пробежать весь файл
		$File[0] =~ /Audio Copy (V\d.\d.*) from/
	}
	#нормализуем
	given ($Ver) {
		$Ver = 1 when /1\.0./;
		default { $Ver = 0 }
	}
return $Ver; }

parse_1_5($File) { ... }
parse_1_0_b3 { ... }

ripping_date($File) { ... } # YYYY.MM.DD

accurate_mode($File) { ... } # Read mode == Secure && accurate stream && no audio cache && no C2 pointers

read_offset($File) { ... }

track_len($File, $Track_num) { ... }
track_start_end($File, $Track_num) { ... ($start, $end);}
disk_CRC($File) {... (CRC, $Value)}
track_CRC($File) {... (CRC, $Value)}
accurately_ripped($File, $Track_num) { ... } # true/false
log_checksum($File) { ... }

#TODO: out data format
