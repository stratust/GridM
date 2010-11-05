package GridM::Model::GridDB::Utils;

use strict;
use warnings;
use base 'Exporter';
use Config::JFDI;
use FindBin;
use lib "$FindBin::Bin/../lib";
use GridM::Schema;
use Sys::Hostname;

use vars qw/@EXPORT_OK $schema $config/;

@EXPORT_OK = qw/
  schema
  config
  /;


sub config {

	my ($host) = Sys::Hostname::hostname() =~ m/^([^\.]+)/;
    return $config if defined $config;
    $config = Config::JFDI->new(
	   name => 'GridM',
       path => "$FindBin::Bin/../conf/gridm_" . $host.'.conf',
   	)->get;
    return $config;
}

sub schema {
    return $schema if defined $schema;
    $schema = GridM::Schema->connect( @{ config->{'Model::GridDB'}{connect_info} || [] } );
    return $schema;
}

1;
