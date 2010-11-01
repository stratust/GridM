package GridM::Schema::Result::Sala;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn");

=head1 NAME

GridM::Schema::Result::Sala

=cut

__PACKAGE__->table("sala");

=head1 ACCESSORS

=head2 sala_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 descricao

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 image

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=cut

__PACKAGE__->add_columns(
  "sala_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "descricao",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "image",
  { data_type => "varchar", is_nullable => 1, size => 40 },
);
__PACKAGE__->set_primary_key("sala_id");

=head1 RELATIONS

=head2 evento_salas

Type: has_many

Related object: L<GridM::Schema::Result::EventoSala>

=cut

__PACKAGE__->has_many(
  "evento_salas",
  "GridM::Schema::Result::EventoSala",
  { "foreign.sala_id" => "self.sala_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sala_antenas

Type: has_many

Related object: L<GridM::Schema::Result::SalaAntena>

=cut

__PACKAGE__->has_many(
  "sala_antenas",
  "GridM::Schema::Result::SalaAntena",
  { "foreign.sala_id" => "self.sala_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 02:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:suCZ9nhNt9t+BfeyRyDBxg


__PACKAGE__->many_to_many( eventos => 'evento_salas', 'evento' );

sub display_name{
	my ($self) = @_;
	return $self->descricao || '';

}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
