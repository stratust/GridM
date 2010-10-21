package GridM::Form::SalaAntena;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

#with 'HTML::FormHandler::Render::Simple';
# Using my widgets
has '+widget_name_space' => ( default => sub { ['GridM::Form::Widget'] } );

has '+widget_form' => ( default => 'Simple' );

has '+item_class' => ( default => 'SalaAntena' );

has_field 'antena_id' => (
    type         => 'Select',
    required     => 1,
    label        => 'Antena',
    label_column => 'serie',
    empty_select => '--Escolha--'
);
has_field 'sala_id' => (
    type         => 'Select',
    required     => 1,
    label        => 'Sala',
    label_column => 'descricao',
    empty_select => '--Escolha--'
);

has_field 'dia'     => ( type => 'Text',   size     => 2, );
has_field 'inicio'  => ( type => 'Text',   size     => 8, );
has_field 'fim'     => ( type => 'Text',   size     => 8, );

has_field 'submit'    => ( type => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;
