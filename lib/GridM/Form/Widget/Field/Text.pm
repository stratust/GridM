package GridM::Form::Widget::Field::Text;
	
use Moose::Role;
use HTML::Entities;

has 'field_css_class' => ( isa => 'Str|Undef', is => 'rw', default => '' );

sub render {
    my ( $self, $result ) = @_;
	my $css_required;

    $result ||= $self->result;
    my $output = '<input type="text" name="';
    $output .= $self->html_name . '"';
    $output .= ' id="' . $self->id . '"';
    $output .= ' size="' . $self->size . '"' if $self->size;
    $output .= ' maxlength="' . $self->maxlength . '"' if $self->maxlength;
	if ($self->required){
		$css_required .= 'required';
		$css_required .= ' ' if ($self->field_css_class);
	}
    $output .= ' class="' . $css_required.$self->field_css_class . '"' if ($self->field_css_class || $css_required);
	$output .= ' minlength="' . $self->minlength . '"' if $self->minlength;
    $output .= ' value="' . encode_entities($result->fif) . '" />';
    return $self->wrap_field( $result, $output );
}

use namespace::autoclean;
1;
