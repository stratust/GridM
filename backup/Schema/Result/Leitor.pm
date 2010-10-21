package GridM::Schema::Result::Leitor;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("leitor");
__PACKAGE__->add_columns(
  "leitor_id",
  {
    data_type => "integer",
    default_value => "nextval('leitor_leitor_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "serie",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "ip",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 15,
  },
);
__PACKAGE__->set_primary_key("leitor_id");
__PACKAGE__->add_unique_constraint("leitor_pk", ["leitor_id"]);
__PACKAGE__->has_many(
  "antenas",
  "GridM::Schema::Result::Antena",
  { "foreign.leitor_id" => "self.leitor_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1CyqiaC5S+2VVILQAsCU3Q

sub display_name{
	my ($self) = @_;
	return $self->serie || '';

}
# You can replace this text with custom content, and it will be preserved on regeneration
1;
