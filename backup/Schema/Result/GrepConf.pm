package GridM::Schema::Result::GrepConf;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("grep_conf__");
__PACKAGE__->add_columns(
  "propkey",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "proptext",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 2000,
  },
);
__PACKAGE__->set_primary_key("propkey");
__PACKAGE__->add_unique_constraint("grep_conf___pkey", ["propkey"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WPQKw0AjaQm9cRRu4KuFpw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
