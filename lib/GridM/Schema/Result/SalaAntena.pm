package GridM::Schema::Result::SalaAntena;

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

GridM::Schema::Result::SalaAntena

=cut

__PACKAGE__->table("sala_antena");

=head1 ACCESSORS

=head2 sala_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 antena_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 inicio

  data_type: 'time'
  is_nullable: 0

=head2 fim

  data_type: 'time'
  is_nullable: 1

=head2 dia

  data_type: 'smallint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sala_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "antena_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "inicio",
  { data_type => "time", is_nullable => 0 },
  "fim",
  { data_type => "time", is_nullable => 1 },
  "dia",
  { data_type => "smallint", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("sala_id", "antena_id", "inicio", "dia");

=head1 RELATIONS

=head2 antena

Type: belongs_to

Related object: L<GridM::Schema::Result::Antena>

=cut

__PACKAGE__->belongs_to(
  "antena",
  "GridM::Schema::Result::Antena",
  { antena_id => "antena_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 sala

Type: belongs_to

Related object: L<GridM::Schema::Result::Sala>

=cut

__PACKAGE__->belongs_to(
  "sala",
  "GridM::Schema::Result::Sala",
  { sala_id => "sala_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 02:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1kJlhedNre2HwyZ5IzMGMQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
