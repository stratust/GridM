package GridM::Schema::Result::UserRole;

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

GridM::Schema::Result::UserRole

=cut

__PACKAGE__->table("user_role");

=head1 ACCESSORS

=head2 user_user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 role_role_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "role_role_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("user_user_id", "role_role_id");

=head1 RELATIONS

=head2 role_role

Type: belongs_to

Related object: L<GridM::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role_role",
  "GridM::Schema::Result::Role",
  { role_id => "role_role_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 user_user

Type: belongs_to

Related object: L<GridM::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user_user",
  "GridM::Schema::Result::User",
  { user_id => "user_user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 18:07:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:i92FjA/QLbmUpbuc23Mi8Q


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
