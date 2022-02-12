#!/usr/bin/perl

use strict;
use warnings;

my $url = "https://ifconfig.me";
my $log = "/var/log/ip.log";

my $time_and_date = localtime();
my $ip = qx(curl $url);
my $output = $time_and_date . ": " . $ip . "\n";

open(my $fh, ">>", $log) or die "cant open";
print $fh $output;
close $fh;
print $output;
