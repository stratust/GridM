package GridM::Form::Sala;
use HTML::FormHandler::Moose;
use utf8;
extends 'HTML::FormHandler::Model::DBIC';

#with 'HTML::FormHandler::Render::Simple';
# Using my widgets
has '+widget_name_space' =>
  ( default => sub { ['GridM::Form::Widget'] } );

has '+widget_form' => ( default => 'Simple'); 

has '+item_class' => ( default => 'Sala' );

has_field 'descricao' => (
    type     => 'Text',
    label    => 'Descrição',
    size     => 40,
    required => 1,
    maxsize  => 50,
);

has_field 'image' => ( type => 'Text', size => 40, );

has_field 'submit' => ( type => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;
