package GridM::Model::Ash2010;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'GridM::Schema',
    
    connect_info => {
        dsn => 'dbi:Pg:dbname=ash2010',
        user => 'grid',
        password => 'gridT3500',
    }
);

=head1 NAME

GridM::Model::Ash2010 - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<GridM>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<GridM::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.35

=head1 AUTHOR



=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
