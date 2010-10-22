package GridM::Schema::Result::Participante;

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

GridM::Schema::Result::Participante

=cut

__PACKAGE__->table("participante");

=head1 ACCESSORS

=head2 participante_id

  data_type: 'integer'
  is_nullable: 0

=head2 nome

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 tipo

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 tipoinsc

  data_type: 'varchar'
  is_nullable: 1
  size: 5

=head2 profissao

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "participante_id",
  { data_type => "integer", is_nullable => 0 },
  "nome",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "tipo",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "tipoinsc",
  { data_type => "varchar", is_nullable => 1, size => 5 },
  "profissao",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);
__PACKAGE__->set_primary_key("participante_id");

=head1 RELATIONS

=head2 leituras

Type: has_many

Related object: L<GridM::Schema::Result::Leitura>

=cut

__PACKAGE__->has_many(
  "leituras",
  "GridM::Schema::Result::Leitura",
  { "foreign.participante_id" => "self.participante_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 02:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6SbTlJSVASdFxmQOuRN27Q

sub display_name {
    my ($self) = @_;
    return $self->nome || '';
}

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
