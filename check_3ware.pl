#!/usr/bin/perl -w
#
# NAGIOS Plugin: check_3ware
# Check the status of the 3ware raid controler with tw_cli
#
# COPYRIGHT:
#
# This software is Copyright (c) NETWAYS GmbH, Marius Hein
#                                <support@netways.de>
#
# (Except where explicitly superseded by other copyright notices)
#
#
# LICENSE:
#
# This work is made available to you under the terms of Version 2 of
# the GNU General Public License. A copy of that license should have
# been provided with this software, but in any event can be snarfed
# from http://www.fsf.org.
#
# This work is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301 or visit their web page on the internet at
# http://www.fsf.org.
#
#
# CONTRIBUTION SUBMISSION POLICY:
#
# (The following paragraph is not intended to limit the rights granted
# to you to modify and distribute this software under the terms of
# the GNU General Public License and is only of importance to you if
# you choose to contribute your changes and enhancements to the
# community by submitting them to NETWAYS GmbH.)
#
# By intentionally submitting any modifications, corrections or
# derivatives to this work, or any other work intended for use with
# this Software, to NETWAYS GmbH, you confirm that
# you are the copyright holder for those contributions and you grant
# NETWAYS GmbH a nonexclusive, worldwide, irrevocable,
# royalty-free, perpetual, license to use, copy, create derivative
# works based on those contributions, and sublicense and distribute
# those contributions and any derivatives thereof.
#
# Nagios and the Nagios logo are registered trademarks of Ethan Galstad.


use strict;
use File::Basename;
use Getopt::Long;
use vars qw(
	$opt_unit
	$opt_control
	$opt_help
	$opt_usage
	$opt_warnings
	$opt_oks
	$opt_version
	$progname
	@state_ok
	@state_warning
	$return
	$command
	%conf
	$tmp1
	$tmp2
	$state_out
	$desc_out
	$exit_out
	);

sub print_help();
sub print_usage();
sub print_version();
sub print_warnings();
sub print_okays();

$progname = basename($0);

@state_ok=("OK");
@state_warning=("DEGRADED","OFFLINE");

$conf{'path'} = "sudo /usr/sbin/";
$conf{'bin'} = "tw_cli";
$conf{'cmd_part_first'} = "info";
$conf{'cmd_part_last'} = "status";

Getopt::Long::Configure('bundling');
GetOptions
	(
	"controller=s"	=>	\$opt_control,
	"C=s"		=>	\$opt_control,
	
	"unit=s"	=>	\$opt_unit,
	"U=s"		=>	\$opt_unit,

	"warnings"	=>	\$opt_warnings,
	"W"		=>	\$opt_warnings,

	"version"	=>	\$opt_version,
	"V"		=>	\$opt_version,

	"okays"		=>	\$opt_oks,
	"O"		=>	\$opt_oks,
	
	"h"		=>	\$opt_help,
	"help"		=>	\$opt_help,
	"usage"		=>	\$opt_usage
	) || die "try '$progname --help' for informations.\n";

if (!$opt_control) { $opt_control=0; }
if (!$opt_unit) { $opt_unit=0; }

sub print_help() {
 print "\n";
 print "check 3ware >>HELP<<\n";
 print "\n";
 print "\t --help, -h\t\t\t help screen.\n";
 print "\t --usage\t\t\t little usage\n";
 print "\n";
 print "\t --controller, -C\t\t Controller ID\n";
 print "\t --unit, -U\t\t\t Unit ID\n";
 print "\n";
 print "\t --warnings, -W\t\t\t Displays warning Keywords\n";
 print "\t --okays, -O\t\t\t Displays ok Keywords\n";
 print "\n";
 print "\t --version, -V\t\t\t Display version\n";
 print "\n";
}

sub print_usage() {
 print "\n";
 print "check 3ware >>USAGE<<\n";
 print "\n";
 print "\t$progname -C 0 -U 0 (checks Controller 0 Unit 0 for status)\n";
 print "\t$progname -W (Displays all Warning keywords)\n";
 print "\t$progname -O (Displays all OK keywords)\n";
 print "\t$progname --help (Displays the Helpmessage)\n";
 print "\n";
}

sub print_version() {
 print "0.1";
 exit 0;
}

sub print_warnings() {
 print "Print Warning-Keywords:\n";
 print "\n";
 foreach (@state_warning) {
  print "$_\n";
 }
}

sub print_okays() {
 print "Print OKAY-Keywords:\n";
 print "\n";
 foreach (@state_ok) {
 print "$_\n";
 }
}

if ($opt_help) {
 print_help();
 exit;
}

if ($opt_usage) {
 print_usage();
 exit;
}

if ($opt_warnings) {
 print_warnings();
 exit;
}

if ($opt_oks) {
 print_okays();
 exit;
}
if ($opt_control >= 0 && $opt_unit >= 0)
{
 $command = $conf{'path'}.$conf{'bin'}." ".$conf{'cmd_part_first'}." c$opt_control u$opt_unit ".$conf{'cmd_part_last'};
 $return = qx ( $command );
 ($tmp1,$tmp2) = split(/\s.*?/,$return);

if ($tmp1 && $tmp2) {

 foreach (@state_ok) {
  if ($tmp1 eq $_) {
   $state_out = "OK";
   $desc_out = "Unit $opt_unit at Controller $opt_control is $tmp1";
   $exit_out = 0;
   }
 }
 if (!$state_out) {
  foreach (@state_warning) {
   if ($tmp1 eq $_) {
    $state_out = "WARNING";
    $desc_out = "Unit $opt_unit at Controller $opt_control is $tmp1";
    $exit_out = 1;
    }
  }
 }

}

 if (!$state_out) {
  $state_out = "CRITICAL";
  $desc_out = "Unit $opt_unit at Controller $opt_control is $tmp1";
  $exit_out = 2;
 }

print "$progname: $state_out ($desc_out)\n";
exit $exit_out;

}
 else
 {
  print_help();
  exit;
 }
