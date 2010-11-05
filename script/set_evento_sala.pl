#!/usr/bin/perl

use strict;
use warnings;
use 5.10.0;
use GridM::Schema;

my $schema = GridM::Schema->connect('dbi:Pg:dbname=griddb','postgres');

my $rs = $schema->resultset('Evento');

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

my @eventos = $rs->all;


foreach my $evento (@eventos) {
    my $evento_sala = $schema->resultset('EventoSala')->create(
        {
            evento_id => $evento->evento_id,
            sala_id   => $evento->sala_id
        }
    );
    say $evento->evento_id . " => " . $evento->sala_id;
}
