package GridM::Model::GridClass;

use strict;
use warnings;
use Moose;
use utf8;
use Carp;
use FindBin;
use lib "$FindBin::Bin/../lib";
use GridM::Model::GridDB::Utils qw/schema config/;
use DateTime;

=head1 NAME

GridM::Model::GridClass - Methods for Grid Event Management

=head1 SYNOPSIS

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<GridM::Schema>

=head1 AUTHOR

Thiago Yukio Kikuchi Oliveira


=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


=head2 get_leituras_from_participante

 Title   : get_leituras_from_participante
 Usage   : get_leituras_from_participante()
 Function: 
 Returns : 
 Args    : 

=cut 

sub get_leituras_from_participante {
    my($self,$attr) = @_;

    my (
        $dia,     $sala,      $evento,      $participante,
        $page,    $search_by, $search_text, $rows,
        $sort_by, $sort_order
      )
      = @{ $attr }
      {qw/dia sala evento participante page qtype query rp sortname sortorder/};

    my $rs =
      schema->resultset("Leitura")->search( 
		  {}, 
		  { order_by => { -asc => [qw/ me.dia registro/] } } 
	  );

	#dia
  	$rs =
      $rs->search( {'evento.dia' => $dia}, {} ) if ($dia);
	#sala
  	$rs =
      $rs->search( {'sala.sala_id' => $sala}, {} ) if ($sala);
	#evento
  	$rs =
      $rs->search( {'evento.evento_id' => $evento}, {} ) if ($evento);




    $rs = $rs->search(
        { 'participante.participante_id' => $participante, 'me.registro' => { -between => \'evento.inicio AND evento.fim' }, 'me.dia' => {'=' => \'evento.dia'} },
        {
            join => [
                'participante',
                { antena => { sala_antenas => { sala => {'evento_salas' => 'evento'} } } }
            ],
            '+select' => [
                'participante.participante_id', 'participante.nome',
                'participante.profissao',       'sala.descricao',
                'evento.descricao',               'me.dia',
                'evento.evento_id',

            ],
            '+as' => [ 'id', 'nome', 'profissao', 'sala', 'evento', 'dia', 'evento_id' ],

#            group_by => ['registro','me.dia'],
        },
    ) if ($participante);

    $rs = $rs->search(
        {

            "lower($search_by)" => { 'like', lc($search_text) . '%' }

        }
      )
      if $search_by
          && $search_text;

    return $rs->all;   
}

=head2 filter_resultset

 Title   : filter_resultset
 Usage   : filter_resultset()
 Function: Filtra o Resultset 
 Returns : 
 Args    : resultset array

=cut 

sub filter_resultset {
    my ( $self, @aux ) = @_;

    my $day_before;
    my $register_before;
    my $hash;
    my @results;

    foreach (@aux) {

        if ( $day_before || $register_before ) {

            unless ( ( $day_before eq $_->get_column('dia') )
                && ( $register_before eq $_->registro ) )
            {
                if ( $day_before eq $_->get_column('dia') ) {

                    my @time_bf  = split( ":", $register_before );
                    my @time_now = split( ":", $_->registro );
                    if (   $time_bf[0] eq $time_now[0]
                        && $time_bf[1] eq $time_now[1] )
                    {
                        if ( ( $time_now[2] - $time_bf[2] ) > 2 ) {

                            push( @results, $hash );

                        }
                    }
                    else {
                        push( @results, $hash );
                    }

                }
                else {
                    push( @results, $hash );
                }

            }
        }

        $hash            = $_;
        $day_before      = $_->get_column('dia');
        $register_before = $_->registro;
    }
    push( @results, $hash ) if $hash;

    return @results;

}


=head2 calculate_in_out

 Title   : calculate_in_out
 Usage   : calculate_in_out()
 Function: 
 Returns : 
 Args    : Resultset array not filtered

=cut 

sub calculate_in_out {
    my ( $self, @resultset ) = @_;

    # Filtering the resultset
    my @filtered_resultset = $self->filter_resultset(@resultset);

    my $last_event_id;

    my %event;

    # Finding IN and OUT
    foreach my $row (@filtered_resultset) {
        push( @{ $event{ $row->get_column('evento_id') } }, $row );
    }

    #    return %event;

    # Calculate presence
    my %presence;

    foreach my $event_id ( keys %event ) {
       
        my @aux = @{ $event{$event_id} };
#        $presence{$event_id}{resultset} = \@aux; 

        # Keep an array of registers
        $presence{$event_id}{registro} = [
            map {
                $_->registro;
            } @aux
        ];
        
        # Store information about event
        $presence{$event_id}{id} = $aux[0]->get_column('id');
        $presence{$event_id}{nome} = $aux[0]->get_column('nome');
        $presence{$event_id}{dia} = $aux[0]->dia;
        $presence{$event_id}{evento} = $aux[0]->get_column('evento');
        $presence{$event_id}{sala} = $aux[0]->get_column('sala');
        
        for ( my $i = 0 ; $i <= $#aux; ) {
            
            if ( $aux[$i+1] ) {

                my $dt1 = DateTime->now();
                my $dt2 = DateTime->now();

                $dt1->set( hour => $1, minute => $2, second => $3 )
                  if ( $aux[$i]->registro =~ /(\d+):(\d+):(\d+)/ );
                $dt2->set( hour => $1, minute => $2, second => $3 )
                  if ( $aux[ $i + 1 ]->registro =~ /(\d+):(\d+):(\d+)/ );
                my $delta = $dt2 - $dt1;
                my $delta_seconds;
                if ( $delta->in_units('minutes') ) {
                    $delta_seconds += $delta->in_units('minutes') * 60;
                }

                $delta_seconds += $delta->in_units('seconds');

                $presence{$event_id}{'presence'} += $delta_seconds;
                

            }
            else {
                my $rs  = schema->resultset('Evento')->find($event_id);
                my $fim = DateTime->now();
                $fim->set( hour => $1, minute => $2, second => $3 )
                  if ( $rs->fim =~ /(\d+):(\d+):(\d+)/ );
                my $dt1 = DateTime->now();
                $dt1->set( hour => $1, minute => $2, second => $3 )
                  if ( $aux[$i]->registro =~ /(\d+):(\d+):(\d+)/ );
                my $delta = $fim - $dt1;
                my $delta_seconds;
                if ( $delta->in_units('minutes') ) {
                    $delta_seconds += $delta->in_units('minutes') * 60;
                }
                $delta_seconds += $delta->seconds;

                $presence{$event_id}{'presence'} += $delta_seconds;

            }
            $i = $i + 2;
        }

        # Duracao do evento
        my $rs  = schema->resultset('Evento')->find($event_id);
        my $fim = DateTime->now();
        $fim->set( hour => $1, minute => $2, second => $3 )
          if ( $rs->fim =~ /(\d+):(\d+):(\d+)/ );
        my $inicio = DateTime->now();
        $inicio->set( hour => $1, minute => $2, second => $3 )
          if ( $rs->inicio =~ /(\d+):(\d+):(\d+)/ );
        my $delta = $fim - $inicio;
        my $delta_seconds;

        if ( $delta->in_units('minutes') ) {
            $delta_seconds += $delta->in_units('minutes') * 60;
        }
        $delta_seconds += $delta->seconds;

        $presence{$event_id}{'duration'} += $delta_seconds;

         $presence{$event_id}{'percentage'} = sprintf("%.2f",($presence{$event_id}{'presence'} / $delta_seconds) * 100)."%" if $delta_seconds;

    }

    return %presence;

}


1;
