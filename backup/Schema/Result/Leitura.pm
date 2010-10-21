package GridM::Schema::Result::Leitura;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("leitura");
__PACKAGE__->add_columns(
  "dia",
  {
    data_type => "smallint",
    default_value => undef,
    is_nullable => 0,
    size => 2,
  },
  "registro",
  {
    data_type => "time without time zone",
    default_value => undef,
    is_nullable => 0,
    size => 8,
  },
  "participante_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "antena_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "leitura_id",
  {
    data_type => "bigint",
    default_value => "nextval('leitura_leitura_id_seq'::regclass)",
    is_nullable => 0,
    size => 8,
  },
  "tag",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 70,
  },
);
__PACKAGE__->set_primary_key("leitura_id");
__PACKAGE__->add_unique_constraint("leitura_pk", ["leitura_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qQgGOtpeMm8ZODENBDTDwQ


__PACKAGE__->belongs_to(
  "antena_id",
  "GridM::Schema::Result::Antena",
  { antena_id => "antena_id" },
);

__PACKAGE__->belongs_to(
  "participante_id",
  "GridM::Schema::Result::Participante",
  { "foreign.participante_id" => "self.participante_id" },
);


# You can replace this text with custom content, and it will be preserved on regeneration
1;
