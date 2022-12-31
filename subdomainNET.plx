#!/usr/bin/perl

use strict;
use warnings;

use Net::DNS;
use Getopt::Long;

my $domain;
GetOptions("d=s" => \$domain);

# Check if domain was provided
unless ($domain) {
  print "Usage: subdomainNET.plx -d domain\n";
  exit;
}

my $res = Net::DNS::Resolver->new;

# Perform a DNS lookup for the domain
my $query = $res->search($domain);


if ($query) {
  foreach my $rr ($query->answer) {
    next unless $rr->type eq "CNAME";
    print $rr->cname, "\n";
  }
} else {
  print "Error performing DNS lookup for domain $domain: ", $res->errorstring, "\n";
}
