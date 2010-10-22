#!/usr/bin/perl

use strict;
use warnings;

use GridM::Schema;

my $schema = GridM::Schema->connect('dbi:mysql:dbname=griddb','root');

my $rs = $schema->resultset('Participante');

=cut
$rs = $rs->search(
	{ 
		'lower(nome)' => { 'like', 't%' } 
	},
	{
		rows => 10,
#		page => 1,
	}
);
=cut

open(my $in,"<",$ARGV[0] );

while (<$in>){

    my @aux = split(/\t/,$_);
    my $user = $rs->find($aux[4]);
    
    print $_ if $user;


}
close($in);
