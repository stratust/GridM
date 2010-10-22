package GridM::Form::Leitura;
use HTML::FormHandler::Moose;
use utf8;
extends 'HTML::FormHandler::Model::DBIC';

#with 'HTML::FormHandler::Render::Simple';

has '+widget_name_space' => ( default => sub { ['GridM::Form::Widget'] } );

has '+widget_form' => ( default => 'Simple' );

has '+item_class' => ( default => 'Leitura' );

has_field 'tag'        => ( type => 'Text', size => 30, maxlength => 30 );
has_field 'antena' => (
    type     => 'Select',
    required => 1,
	label => 'Antena',
	label_column => 'serie',
	empty_select => '--Escolha--',
);
has_field 'participante' => (
    type         => 'Select',
    required     => 1,
    label        => 'Participante',
    label_column => 'nome',
    empty_select => '--Escolha--'
);
has_field 'registro' => ( type => 'Text', size => 8, required => 1, );
has_field 'dia' => ( type => 'Integer', size => 2, required => 1, );
has_field 'submit' => ( type => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;


