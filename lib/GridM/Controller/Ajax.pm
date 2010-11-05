package GridM::Controller::Ajax;
use Moose;
use strict;
use warnings;
use Data::Dumper;
# load forms
use GridM::Form::Evento;
use GridM::Form::Sala;
use GridM::Form::SalaAntena;
use GridM::Form::Antena;
use GridM::Form::Leitor;
use GridM::Form::Leitura;
use GridM::Form::Participante;

BEGIN { extends 'Catalyst::Controller'; }

sub index : Path Args(0) {
    my ( $self, $c ) = @_;

    if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {

    }
    else {

        $c->detach('/access_denied');

    }

}

sub end : ActionClass('RenderView') {

}

sub instance : Chained('/') PathPrefix CaptureArgs(1) {
    my ( $self, $c, $tname ) = @_;

	# Filtering table names
	$tname = "Evento" if ($tname =~ /^evento$/i);
	$tname = "Sala" if ($tname =~ /^sala$/i);
	$tname = "SalaAntena" if ($tname =~ /^salaantena$/i);
	$tname = "Antena" if ($tname =~ /^antena$/i);
	$tname = "Leitor" if ($tname =~ /^leitor$/i);
	$tname = "Leitura" if ($tname =~ /^leitura$/i);
	$tname = "Participante" if ($tname =~ /^participante$/i);

	#if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {
        $c->stash->{tablename} = $tname;
	#}
	#else {

	#    $c->detach('/access_denied');

	#}
}    # do something with $c->req->captures->[ 0 ]

sub view : Chained('instance') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(
        no_wrapper => '0',
        template   => 'ajax.tt'
    );

    my $tb = $c->stash->{tablename};

    my $rs = $c->model("GridDB::$tb");

	#$c->stash->{rows} = [ $rs->all ];

    # Get primary keys
    my @pks = $rs->result_source->primary_columns;

    # Get collumns names
    my @columns = $rs->result_source->columns;

    # Getting PKs and FKs
    for ( my $i = 0 ; $i <= $#columns ; $i++ ) {

        foreach my $pk (@pks) {

            $columns[$i] .= " (PK)" if $columns[$i] eq $pk;

        }

        $columns[$i] .= " (FK)"
          if $rs->result_source->has_relationship( $columns[$i] );

    }

    $c->stash->{columns}  = \@columns;
    $c->stash->{sortname} = shift @pks;

}

sub register_form_add : Local CaptureArgs(1) {
    my ( $self, $c, $tname ) = @_;

	#if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {

        my $register = $c->model("GridDB::$tname")->new_result( {} );
		$c->log->debug("$tname");
        return $self->form( $c, $register, $tname );
	#}

=cut
    my $form = $c->stash->{form};

    if ( $form->submitted_and_valid ) {
        my $book = $c->model('DB::Book')->new_result( {} );
        $form->model->update($book);
    }
    else {
        my @author_objs = $c->model("DB::Author")->all();
        my @authors;
        foreach ( sort { $a->last_name cmp $b->last_name } @author_objs ) {
            push( @authors, [ $_->id, $_->last_name ] );
        }
        my $select = $form->get_element( { type => 'Select' } );
        $select->options( \@authors );
    }
=cut

}

sub register_form_edit : Local CatptureArgs(2) {
    my ( $self, $c, ,$tname,$id ) = @_;
    
	my $object;

    if ( $id =~ m/_/g ) {
        my @ids = split( '_', $id );
        $object = $c->model("GridDB::$tname")->find(@ids);
    }
    else {
        $object = $c->model("GridDB::$tname")->find($id);
    }

    return $self->form( $c, $object, $tname );

}

sub form {
    my ( $self, $c, $register, $tname ) = @_;
	
    my $form = "GridM::Form::$tname"->new;

    # Set the template
    $c->stash( template => 'admin/edit.tt2', form => $form, no_wrapper => 1 );
	#$form->process( action => "/ajax/register_form_add/$tname", item => $register, params => $c->req->params );
    $form->process( action => "", item => $register, params => $c->req->params );
    return unless $form->validated;

    #$c->flash( message => 'Member Type created' );
    # Redirect the user back to the list page
    #$c->response->redirect( $c->uri_for($self->action_for('list')) );

}

sub search : Local {
    my ( $self, $c ) = @_;
    
	$c->stash( template => 'search.tt2');

	# Searching days
    my $evento_rs = $c->model('GridDB::Evento')->search( 
			{}, 
			{ columns => ['dia'],
				group_by => ['dia'], 
				order_by => 'dia asc' }
		);
	my @dias = $evento_rs->all;
	$c->stash( dias => \@dias);
	

	# Eventos
	$evento_rs = $c->model('GridDB::Evento')->search( 
			{}, 
			{ 
				order_by => 'me.descricao asc' }
		);
	my @eventos = $evento_rs->all;
	$c->stash( eventos => \@eventos);

	# Salas
	my $sala_rs = $c->model('GridDB::Sala')->search( 
			{}, 
			{ 
				order_by => 'me.descricao asc' }
		);
	my @salas = $sala_rs->all;
	$c->stash( salas => \@salas);


}

sub report : Local {
    my ( $self, $c ) = @_;
    
	$c->stash( template => 'report.tt2');

	# Searching days
    my $evento_rs = $c->model('GridDB::Evento')->search( 
			{}, 
			{ columns => ['dia'],
				group_by => ['dia'], 
				order_by => 'dia asc' }
		);
	my @dias = $evento_rs->all;
	$c->stash( dias => \@dias);
	

	# Eventos
	$evento_rs = $c->model('GridDB::Evento')->search( 
			{}, 
			{ 
				order_by => 'me.descricao asc' }
		);
	my @eventos = $evento_rs->all;
	$c->stash( eventos => \@eventos);

	# Salas
	my $sala_rs = $c->model('GridDB::Sala')->search( 
			{}, 
			{ 
				order_by => 'me.descricao asc' }
		);
	my @salas = $sala_rs->all;
	$c->stash( salas => \@salas);


}
1;
