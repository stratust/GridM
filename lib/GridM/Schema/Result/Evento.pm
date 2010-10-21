package GridM::Schema::Result::Evento;

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

GridM::Schema::Result::Evento

=cut

__PACKAGE__->table("evento");

=head1 ACCESSORS

=head2 evento_id

  data_type: 'smallint'
  is_auto_increment: 1
  is_nullable: 0

=head2 descricao

  data_type: 'varchar'
  is_nullable: 0
  size: 250

=head2 dia

  data_type: 'smallint'
  is_nullable: 1

=head2 palestrante

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 sala_id

  data_type: 'integer'
  is_nullable: 1

=head2 tema

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 inicio

  data_type: 'time'
  is_nullable: 1

=head2 fim

  data_type: 'time'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "evento_id",
  { data_type => "smallint", is_auto_increment => 1, is_nullable => 0 },
  "descricao",
  { data_type => "varchar", is_nullable => 0, size => 250 },
  "dia",
  { data_type => "smallint", is_nullable => 1 },
  "palestrante",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "sala_id",
  { data_type => "integer", is_nullable => 1 },
  "tema",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "inicio",
  { data_type => "time", is_nullable => 1 },
  "fim",
  { data_type => "time", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("evento_id");

=head1 RELATIONS

=head2 evento_salas

Type: has_many

Related object: L<GridM::Schema::Result::EventoSala>

=cut

__PACKAGE__->has_many(
  "evento_salas",
  "GridM::Schema::Result::EventoSala",
  { "foreign.evento_id" => "self.evento_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 02:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JeD7PaJVzLN/SFpT2i9F8g


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
