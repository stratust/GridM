package  GridM::Form::Leitor;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

#with 'HTML::FormHandler::Render::Simple';
# Using my widgets
has '+widget_name_space' =>
  ( default => sub { ['GridM::Form::Widget'] } );

has '+widget_form' => ( default => 'Simple'); 

has '+item_class' => ( default => 'Leitor' );

has_field 'ip'    => ( type => 'Text',    size     => 15, );
has_field 'serie' => ( type => 'Integer', required => 1, );
has_field 'submit'  => ( type => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;
