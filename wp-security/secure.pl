#!/usr/bin/perl

use strict;
use warnings;

# Send the minimal required HTTP headers
print "Content-type: text/plain\n\n";

# Put your dyndns record here :-)
my $dyndns_host = 'somehost.homelinux.com';
my $ip = `host $dyndns_host`;

if ($ip =~ m/has\ address/) {

   # Lookup succesfful
   my @ips = split(/ /, $ip) or
      die ("Can't extract IP from the resolve message :-(");
   my $ipaddr = $ips[3];

   my $htaccess = "order deny,allow
deny from all
# whitelist some static address, i. e. office
allow from 1.2.3.4
# whitelist home (dyndns)
allow from $ipaddr
";

   open (HTACCESS, ">", "../wp-admin/.htaccess");
   print HTACCESS $htaccess;
   close (HTACCESS);
   
   print "This seem to have went ok. :-)";
   
} else {

   print "Error during lookup. :-(";

}
