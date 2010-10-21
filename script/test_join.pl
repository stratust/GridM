#!/usr/bin/perl

use strict;
use warnings;
use DateTime;
use GridM::Schema;

my $schema =
  GridM::Schema->connect( 'dbi:Pg:dbname=ash2010', 'grid', 'gridT3500' );

my $rs =
  $schema->resultset("Leitura");
  #->search( {}, { order_by => "nome asc", } );

my $search_by = 'nome';
my $search_text = '';
$rs = $rs->search(
    {

		#"lower($search_by)" => { 'like', lc($search_text) . '%' },
		#evento_id => [2,3],
		#'leituras.dia' => '11',
		tipoinsc => 'V5',

    }
  );
#  if $search_by
#      && $search_text;

# Implementing Joining

$rs = $rs->search(
    {},
    {
        join => [
            'participante_id',
              { antena_id => { sala_antenas => { sala_id => 'eventos' } } }
		  ],
		distinct => 1,
		'+select' => ['participante_id.nome','sala_id.descricao', 'eventos.tema'],
		'+as' => ['nome', 'descricao','tema'],
		#group_by => ['leituras.registro','me.nome, me.participante_id, me.tipo, me.tipoinsc', 'me.profissao', 'sala_id.descricao, eventos.tema'],
    },
);
=cut
my $paged_rs = $rs->search(
    {},
    {
        page => $page,
        rows => $rows,
    }
);
=cut
my @rsall = $rs->all;


#my @users = $schema->resultset('Participante')->all;

my $registro_anterior;
my $id_anterior;
foreach my $user (@rsall) {
	if ($id_anterior){
		if ($registro_anterior ne $user->get_column('registro')){

			my $dt_ant = DateTime->new(hour => $1, minute => $2, second => $3) if ($registro_anterior =~ /(\d+)\:(\d+)\:(\d+)/);
			my $now = DateTime->new(hour => $1, minute => $2, second => $3) if ($user->registro =~ /(\d+)\:(\d+)\:(\d+)/);

			if ($now - $dt_ant > 2 ){
		
				print $user->get_column('nome')."\t".$user->get_column('registro')."\t".$user->get_column('descricao')."\t".$user->get_column('tema')."\n";
			}
		}
		
	}
	
	$registro_anterior = $user->get_column('registro');
	$id_anterior = $user->participante_id;
}
