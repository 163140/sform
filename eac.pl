#!/usr/bin/perl
#
# sform - simple script  for music tagging, renaming and converting
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
#       AUTHOR:  163140@autistici.org, 
#      COMPANY:  
#      CREATED:  25.04.2023 15:15:23
#     RDEPENDS:  
#===============================================================================


use v5.36

get_eac_version($File) { ;; }

parse_1_5($File) { ;; }

ripping_date($File) { ;; } # YYYY.MM.DD

accurate_mode($File) { ;; } # Read mode == Secure && accurate stream && no audio cache && no C2 pointers

read_offset($File) { ;; }

track_len($File, $Track_num) { ;; }
track_start_end($File, $Track_num) { ;; ($start, $end);}
disk_CRC($File) {;; (CRC, $Value)}
track_CRC($File) {;; (CRC, $Value)}
accurately_ripped($File, $Track_num) {;;} # true/false
log_checksum($File) {;;}

#TODO: out data format
