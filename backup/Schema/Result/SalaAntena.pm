package GridM::Schema::Result::SalaAntena;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("sala_antena");
__PACKAGE__->add_columns(
  "sala_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "antena_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "inicio",
  {
    data_type => "time without time zone",
    default_value => undef,
    is_nullable => 0,
    size => 8,
  },
  "fim",
  {
    data_type => "time without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "dia",
  {
    data_type => "smallint",
    default_value => undef,
    is_nullable => 0,
    size => 2,
  },
);
__PACKAGE__->set_primary_key("sala_id", "antena_id", "dia", "inicio");
__PACKAGE__->add_unique_constraint("sala_antena_pk", ["sala_id", "antena_id", "dia", "inicio"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iWhSPJtMCCf7rqmx4B07rA

__PACKAGE__->belongs_to(
  "sala_id",
  "GridM::Schema::Result::Sala",
  { sala_id => "sala_id" },
);

__PACKAGE__->belongs_to(
  "antena_id",
  "GridM::Schema::Result::Antena",
  { antena_id => "antena_id" },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
