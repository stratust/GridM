package GridM::Form::Participante;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

# with 'HTML::FormHandler::Render::Simple';

has '+widget_name_space' => ( default => sub { ['GridM::Form::Widget'] } );

has '+widget_form' => ( default => 'Simple' );

has '+item_class' => ( default => 'Participante' );

has_field 'nome'            => ( type => 'Text', size => 40, maxlength => 150);
has_field 'tipo'            => ( type => 'Text', size => 40, maxlength => 150);
has_field 'tipoinsc'        => ( type => 'Text',    size     => 5, );
has_field 'profissao'       => ( type => 'Text',    size     => 40, maxlengh => 50, );

has_field 'submit'          => ( type => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;

