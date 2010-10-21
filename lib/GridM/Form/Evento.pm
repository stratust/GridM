package GridM::Form::Evento;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

#with 'HTML::FormHandler::Render::Simple';

# Using my widgets
has '+widget_name_space' =>
  ( default => sub { ['GridM::Form::Widget'] } );

has '+widget_form' => ( default => 'Simple'); 

has '+item_class' => ( default => 'Evento' );


has_field 'dia' => ( type => 'Text', required => 1, size => 2, maxlength => 2, );
has_field 'inicio' => ( type => 'Text', required => 1, size => 8, );
has_field 'fim'    => ( type => 'Text', required => 1, size => 8, );
has_field 'sala_id' => (
    type         => 'Select',
    required     => 1,
    label        => 'Sala',
    label_column => 'descricao',
    empty_select => '--Escolha--'
);
has_field 'tema'   => ( type => 'Text', required => 1, size => 30, maxsize => 100 );
has_field 'palestrante' => ( type => 'Text', required => 1, size => 30 );
has_field 'descricao' => (
    type     => 'TextArea',
    required => 1,
    rows     => 5,
    cols     => 40,
);
has_field 'submit' => ( type => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;

