#!/usr/bin/perl

use strict;
use warnings;

use GridM::Schema;

my $schema = GridM::Schema->connect('dbi:Pg:dbname=ash2010','grid','gridT3500');

my $rs = $schema->resultset('Participante');

$rs = $rs->search(
	{ 
		'lower(nome)' => { 'like', 't%' } 
	},
	{
		rows => 10,
#		page => 1,
	}
);

my @users = $rs->all;
foreach my $user (@users) {
	#$user->password('neon0303');
	#$user->update;
	print $user->participante_id."\t".$user->nome."\n";
}
