package GridM::Schema::Result::Antena;

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

GridM::Schema::Result::Antena

=cut

__PACKAGE__->table("antena");

=head1 ACCESSORS

=head2 antena_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 serie

  data_type: 'integer'
  is_nullable: 0

=head2 leitor_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 porta

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "antena_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "serie",
  { data_type => "integer", is_nullable => 0 },
  "leitor_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "porta",
  { data_type => "smallint", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("antena_id");

=head1 RELATIONS

=head2 leitor

Type: belongs_to

Related object: L<GridM::Schema::Result::Leitor>

=cut

__PACKAGE__->belongs_to(
  "leitor",
  "GridM::Schema::Result::Leitor",
  { leitor_id => "leitor_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 leituras

Type: has_many

Related object: L<GridM::Schema::Result::Leitura>

=cut

__PACKAGE__->has_many(
  "leituras",
  "GridM::Schema::Result::Leitura",
  { "foreign.antena_id" => "self.antena_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sala_antenas

Type: has_many

Related object: L<GridM::Schema::Result::SalaAntena>

=cut

__PACKAGE__->has_many(
  "sala_antenas",
  "GridM::Schema::Result::SalaAntena",
  { "foreign.antena_id" => "self.antena_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 02:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0xBl667pwFTPmSFUBaNl9w


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
