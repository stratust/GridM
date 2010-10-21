package GridM::Form::Antena;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

#with 'HTML::FormHandler::Render::Simple';

# Using my widgets
has '+widget_name_space' =>
  ( default => sub { ['GridM::Form::Widget'] } );

has '+widget_form' => ( default => 'Simple'); 

has '+item_class' => ( default => 'Antena' );

has_field 'porta'     => ( type => 'Text',    size     => 2, );
has_field 'serie'     => ( type => 'Integer', required => 1, );
has_field 'leitor_id' => (
    type         => 'Select',
    label        => 'Leitor',
    required     => 1,
    label_column => 'serie',
    empty_column => '--Escolha--'
);
has_field 'submit' => ( type => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;

