package GridM::Schema::Result::Leitor;

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

GridM::Schema::Result::Leitor

=cut

__PACKAGE__->table("leitor");

=head1 ACCESSORS

=head2 leitor_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 serie

  data_type: 'integer'
  is_nullable: 0

=head2 ip

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=cut

__PACKAGE__->add_columns(
  "leitor_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "serie",
  { data_type => "integer", is_nullable => 0 },
  "ip",
  { data_type => "varchar", is_nullable => 1, size => 15 },
);
__PACKAGE__->set_primary_key("leitor_id");

=head1 RELATIONS

=head2 antenas

Type: has_many

Related object: L<GridM::Schema::Result::Antena>

=cut

__PACKAGE__->has_many(
  "antenas",
  "GridM::Schema::Result::Antena",
  { "foreign.leitor_id" => "self.leitor_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 02:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jM8GKX7ZaDrHTVyHHnnbMg

sub display_name{
	my ($self) = @_;
	return $self->serie || '';

}


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
