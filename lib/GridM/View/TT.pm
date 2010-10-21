package GridM::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
	
	# Encoding
	ENCODING     => 'utf-8',
    # Change default TT extension
    TEMPLATE_EXTENSION => '.tt2',

    # Set the location for TT files
    INCLUDE_PATH => [ GridM->path_to( 'root', 'src' ), ],

   # This is your wrapper template located in the 'root/src'
    WRAPPER => 'wrapper.tt2',
);

=head1 NAME

GridM::View::TT - TT View for GridM

=head1 DESCRIPTION

TT View for GridM.

=head1 SEE ALSO

L<GridM>

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
