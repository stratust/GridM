package GridM::Schema::Result::User;

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

GridM::Schema::Result::User

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 user_login

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 user_email

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 user_password

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "user_login",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "user_email",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "user_password",
  { data_type => "varchar", is_nullable => 0, size => 45 },
);
__PACKAGE__->set_primary_key("user_id");

=head1 RELATIONS

=head2 user_roles

Type: has_many

Related object: L<GridM::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "GridM::Schema::Result::UserRole",
  { "foreign.user_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 18:28:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KXIqL8G3/n/qmnZOQFA2Vw


__PACKAGE__->many_to_many( roles => 'user_role', 'role' );

# Have the 'password' column use a SHA-1 hash and 10-character salt
# with hex encoding; Generate the 'check_password" method
__PACKAGE__->add_columns(
    'user_password' => {
        data_type           => "VARCHAR",
        size                => 45,
        is_nullable         => 0,
        encode_column       => 1,
        encode_class        => 'Digest',
        encode_args         => {algorithm => 'MD5',
	   							format => 'base64',
								salt_length => 10},
        encode_check_method => 'check_password',
    },
);

# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
