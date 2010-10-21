package GridM::Schema::Result::Leitura;

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

GridM::Schema::Result::Leitura

=cut

__PACKAGE__->table("leitura");

=head1 ACCESSORS

=head2 dia

  data_type: 'smallint'
  is_nullable: 0

=head2 registro

  data_type: 'time'
  is_nullable: 0

=head2 leitura_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 tag

  data_type: 'varchar'
  is_nullable: 0
  size: 70

=head2 participante_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 antena_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 qtd

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "dia",
  { data_type => "smallint", is_nullable => 0 },
  "registro",
  { data_type => "time", is_nullable => 0 },
  "leitura_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "tag",
  { data_type => "varchar", is_nullable => 0, size => 70 },
  "participante_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "antena_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "qtd",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("leitura_id", "participante_id", "antena_id");

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

=head2 participante

Type: belongs_to

Related object: L<GridM::Schema::Result::Participante>

=cut

__PACKAGE__->belongs_to(
  "participante",
  "GridM::Schema::Result::Participante",
  { participante_id => "participante_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 02:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tiAOJOVwdE70k1E0mtKxHQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
