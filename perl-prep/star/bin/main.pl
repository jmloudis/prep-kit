#!/opt/homebrew/bin/perl


# 1. Add the local 'lib' directory to the search path
use FindBin;
use lib "$FindBin::Bin/../lib";
use Data::Dumper;

use Dancer2;
use Utils::Helper;


my $helper = new Utils::Helper;
print($helper->get_message(), "\n");
print Dumper($helper->{'example'})
# $helper->log_message();

