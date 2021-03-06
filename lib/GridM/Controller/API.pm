package GridM::Controller::API;

use strict;
use warnings;
use parent 'Catalyst::Controller::REST';
use Data::Dumper;
use DBIx::Class::ResultClass::HashRefInflator;

__PACKAGE__->config( default => 'application/json' );

# Methods used in Flexigrid
#--------------------------------------------
sub grid : Local ActionClass('REST') {

}

sub grid_POST {
    my ( $self, $c ) = @_;

    #if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {
    my ( $tname, $page, $search_by, $search_text, $rows, $sort_by, $sort_order )
      = @{ $c->req->params }{qw/tname page qtype query rp sortname sortorder/};

    s/\W*(\w+).*/$1/ for $sort_by, $sort_order, $search_by; # sql injections bad

    my %data;

    my $rs =
      $c->model("GridDB::$tname")
      ->search( {}, { order_by => "$sort_by $sort_order", } );

    $rs = $rs->search(
        {

            "lower($search_by)" => { 'like', lc($search_text) . '%' }

        }
      )
      if $search_by
          && $search_text;

    my $paged_rs = $rs->search(
        {},
        {
            page => $page,
            rows => $rows,
        }
    );

    my @cols = $rs->result_source->columns;
    my @pks  = $rs->result_source->primary_columns;
    my $pk   = $pks[0];

    $data{total} = $rs->count;
    $data{page}  = $page;

    my @rsall = $paged_rs->all;

    my @row_aux;



    # formating data
    # -------------------------------------------------------------------------
    foreach my $row (@rsall) {

        my %aux;

        unless ( $#pks >= 1 ) {
            $aux{'id'} = $row->$pk;
        }
        else {
            my @ids;
            foreach my $primary_key (@pks) {

                if ( UNIVERSAL::can( $row->$primary_key, 'can' ) ) {

                    push( @ids, $row->$primary_key->$primary_key );

                }
                else {
                    push( @ids, $row->$primary_key );
                }

            }
            $aux{'id'} = join( "_", @ids );
        }

        foreach my $col_name (@cols) {
            

            foreach my $t ( $row->$col_name ) {
                my $ref = ref($t);
                
           
                my $col_info = $rs->result_source->column_info($col_name);
                my $relationship_name = $col_name;

                $relationship_name =~ s/_id$//;

                if ( $col_info->{'is_foreign_key'} && $ref !~ /date/i && $rs->result_source->has_relationship($relationship_name)) {
                    
                    my $text =   $row->$relationship_name->display_name . " (" . $t . ")";

                    push( @{ $aux{'cell'} }, $text );

                }
                elsif ( $ref =~ /date/i && $t ) {

                    push( @{ $aux{'cell'} }, $t->dmy );

                }
                else {

                    $t = '' unless defined $t;

                    push( @{ $aux{'cell'} }, $t );

                }
            }
        }
        push( @row_aux, \%aux );
    }

    $data{rows} = \@row_aux;

=cut
	my $i;
	$data{rows}  = [
        map {
			$i = $_;	 
            +{
                id   => $i->$pk,
                cell => [ map {$i->$_} @cols
				#    $i->member_id,
				#   $i->name,

                    #                    $_->rating,
                    #                    $_->author_list,
                ]
              }
          } @rsall
    ];
=cut

    $self->status_ok( $c, entity => \%data );

    # }
}

sub register : Local ActionClass('REST') {
    my ( $self, $c, $id ) = @_;

    my ($tname) = @{ $c->req->params }{qw/tname/};

    #if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {

    if ( $id =~ m/_/g ) {
        my @ids = split( '_', $id );
        $c->stash( register => $c->model("GridDB::$tname")->find(@ids) );
    }
    else {
        $c->stash( register => $c->model("GridDB::$tname")->find($id) );
    }

    #}
}

sub register_DELETE {
    my ( $self, $c, $id ) = @_;

    #if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {

    $c->stash->{register}->delete
      || $self->status_bad_request( $c,
        message => "Cannot do what you have asked!", );

    if ( scalar @{ $c->error } ) {

        #$c->stash->{thrownError}   = $c->error;
        $self->status_bad_request( $c,
            message => "Cannot do what you have asked!", );
        $c->error(0);
    }

    $self->status_ok( $c, entity => { message => 'success' } );

    #}
}

# Methods used in Advanced Search
# ------------------------------------------

sub asearch : Local ActionClass('REST') {

}

sub asearch_POST {
    my ( $self, $c ) = @_;

    my ( $page, $search_by, $search_text, $rows, $sort_by, $sort_order ) =
      @{ $c->req->params }{qw/page qtype query rp sortname sortorder/};

    s/\W*(\w+).*/$1/ for $sort_by, $sort_order, $search_by; # sql injections bad

    my %data;

    my $rs =
      $c->model("GridDB::Participante")
      ->search( {}, { order_by => "$sort_by $sort_order", } );

    $rs = $rs->search(
        {

            "lower($search_by)" => { 'like', lc($search_text) . '%' }

        }
      )
      if $search_by
          && $search_text;

    # Implementing Joining

    $rs = $rs->search(
        {},
        {
            join => {
                leituras =>
                  { antena_id => { sala_antenas => { sala_id => 'eventos' } } }
            },
            distinct => 1,
        },
    );

    my $paged_rs = $rs->search(
        {},
        {
            page => $page,
            rows => $rows,
        }
    );

    my @rsall = $rs->all;

}

sub searchname : Local ActionClass('REST') {

}

sub searchname_GET {

    my ( $self, $c ) = @_;

    my ($nome) = @{ $c->req->params }{qw/term/};

   #s/\W*(\w+).*/$1/ for $sort_by, $sort_order, $search_by; # sql injections bad

    my %data;

    my $rs =
      $c->model("GridDB::Participante")
      ->search( {}, { order_by => "nome asc", } );

    $rs = $rs->search(
        {

            "lower(nome)" => { 'like', '%' . lc($nome) . '%' }

        }
    ) if $nome;

    # Implementing Joining

    my $paged_rs = $rs->search(
        {},
        {
            page => 1,
            rows => 20,
        }
    );

    #my @rsall = $rs->all;

    my $json = [
        map {
            +{
                id    => $_->participante_id,
                label => $_->nome,
                value => $_->nome,

              }
          } $paged_rs->all
    ];

    $self->status_ok( $c, entity => $json );
}

sub searchgrid : Local ActionClass('REST') {

}

sub searchgrid_POST {
    my ( $self, $c ) = @_;

    #if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {
    my (
        $dia,     $sala,      $evento,      $participante,
        $page,    $search_by, $search_text, $rows,
        $sort_by, $sort_order
      )
      = @{ $c->req->params }
      {qw/dia sala evento participante page qtype query rp sortname sortorder/};

    my %data;

	my @aux;
    #Get rows from leituras given and participante_id
    @aux = $c->model('GridClass')->get_leituras_from_participante($c->req->params) if ($participante);

    # Filtering the rows (<= 2segundos considerar uma leitura)
    my @results = $c->model('GridClass')->filter_resultset(@aux);

    # Retorna o relatorio de presenca
    #my %event = $c->model('GridClass')->calculate_in_out(@aux);
    
    #my $dump = Dumper(%event);
    #$c->log->debug($dump);
   	@results = reverse @results;
	my $start = ($rows * $page) - $rows;
	my $end = ($rows * $page) -1;
	if ($#results  <  $end){
		$end = $#results;
	}
    #$c->log->debug("start: ".$start."  end:".$end);	
	my @results_slice = @results[$start..$end];	

	if ($participante &&  $#results_slice >= 0 ){
	$data{rows} = [
        map {
            +{
                id   => $_->get_column('id'),
                cell => [
                    $_->get_column('nome'),   $_->get_column('dia'),
                    $_->registro,             $_->get_column('sala'),
                    $_->get_column('evento'), $_->get_column('profissao'),
                ]
              }
          } @results_slice
      ];
	 }
	 else{
		$data{rows}	  = [
			{
				id => 'none',
				cell => [
					'none',
				 	'none',
					'none',
					'none',
					'none',
					'none'	
				]
			}
		];
	 }

    $data{total} = $#results + 1;
    $data{page}  = $page;

    $self->status_ok( $c, entity => \%data );

    # }
}

sub reportgrid : Local ActionClass('REST') {

}

sub reportgrid_POST {
    my ( $self, $c ) = @_;

    #if ( $c->user_exists() && $c->assert_user_roles('Administrator') ) {
    my (
        $dia,     $sala,      $evento,      $participante,
        $page,    $search_by, $search_text, $rows,
        $sort_by, $sort_order
      )
      = @{ $c->req->params }
      {qw/dia sala evento participante page qtype query rp sortname sortorder/};

    my %data;

	my @aux;
    #Get rows from leituras given and participante_id
    @aux = $c->model('GridClass')->get_leituras_from_participante($c->req->params) if ($participante);

    # Retorna o relatorio de presenca
    my %event = $c->model('GridClass')->calculate_in_out(@aux);
   
    my @results;
    push (@results, $event{$_} ) foreach ( sort {$a <=> $b} keys %event);

    #@results = reverse @results;
	my $start = ($rows * $page) - $rows;
	my $end = ($rows * $page) -1;
	if ($#results  <  $end){
		$end = $#results;
	}
    #$c->log->debug("start: ".$start."  end:".$end);	
	my @results_slice = @results[$start..$end];	

	if ($participante &&  $#results_slice >= 0 ){
	$data{rows} = [
        map {
            +{
                id   => $_->{'id'},
                cell => [
                    $_->{'evento'},   $_->{'dia'},
                    $_->{'duration'}, $_->{'presence'}, $_->{'percentage'},             $_->{'sala'},
                    $_->{'nome'}, 
                ]
              }
          } @results_slice
      ];
	 }
	 else{
		$data{rows}	  = [
			{
				id => 'none',
				cell => [
					'none',
				 	'none',
					'none',
					'none',
					'none',
					'none'	
				]
			}
		];
	 }

    $data{total} = $#results + 1;
    $data{page}  = $page;

    $self->status_ok( $c, entity => \%data );

    # }
}


1;

