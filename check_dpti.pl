#!/usr/bin/perl -w
#
# NAGIOS Plugin: check_dpti
# Check the status of alls disks 
# Author: Gerd Mueller <gmueller@netways.de>
# NETWAYS GmbH, www.netways.de, info@netways.de

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
	$progname
	$command
	%conf
	$state_out
	$desc_out
	$exit_out
	);

sub print_help();
sub print_usage();
sub print_warnings();
sub print_okays();

$progname = basename($0);

Getopt::Long::Configure('bundling');
GetOptions
	(
	"controller=s"	=>	\$opt_control,
	"C=s"		=>	\$opt_control,
	
	"h"		=>	\$opt_help,
	"help"		=>	\$opt_help,
	"usage"		=>	\$opt_usage
	) || die "try '$progname --help' for informations.\n";

if (!$opt_control) { $opt_control=0; }
if (!$opt_unit) { $opt_unit=0; }

sub print_help() {
 print "\n";
 print "check_dpti >>HELP<<\n";
 print "\n";
 print "\t --help, -h\t\t\t help screen.\n";
 print "\t --usage\t\t\t little usage\n";
 print "\n";
 print "\t --controller, -C\t\t Controller ID\n";
 print "\n";
}

sub print_usage() {
 print "\n";
 print "check_dpti >>USAGE<<\n";
 print "\n";
 print "\t$progname -C 0  (checks Controller 0)\n";
 print "\t$progname --help (Displays the Helpmessage)\n";
 print "\n";
}

if ($opt_help) {
 print_help();
 exit;
}

if ($opt_usage) {
 print_usage();
 exit;
}

if ($opt_control >= 0)
{
	
 $exit_out=0;
 $state_out="OK";
 open(IN,"< /proc/scsi/dpt_i2o/".$opt_control)
 	|| die ("Can't open filehandle: $!\n");
 while(<IN>) {
 	chomp();
 	if(m/TID/ && ! m/online/) {
 		if($exit_out==0) {
 			$exit_out = 2 ;
 			$state_out="CRITICAL";
 		}
 		
 		$desc_out.=$_."<br>";
 	}
 }
 close(IN);
 if(defined($desc_out)) {
 	$desc_out="- offline devices!<br>".$desc_out;
 } else {
 	$desc_out=" - no offline devices.";
 }
 print "$progname: $state_out $desc_out\n";
 exit $exit_out;

}
 else
 {
  print_help();
  exit;
 }
