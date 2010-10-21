package GridM::Schema::Result::Evento;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("evento");
__PACKAGE__->add_columns(
  "evento_id",
  {
    data_type => "smallint",
    default_value => "nextval('evento_evento_id_seq'::regclass)",
    is_nullable => 0,
    size => 2,
  },
  "descricao",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 250,
  },
  "dia",
  {
    data_type => "smallint",
    default_value => undef,
    is_nullable => 1,
    size => 2,
  },
  "palestrante",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 200,
  },
  "sala_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "tema",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "inicio",
  {
    data_type => "time without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "fim",
  {
    data_type => "time without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
);
__PACKAGE__->set_primary_key("evento_id");
__PACKAGE__->add_unique_constraint("evento_pk", ["evento_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EspOjx8rVQrHQ6RGrnTEFQ

__PACKAGE__->belongs_to(
  "sala_id",
  "GridM::Schema::Result::Sala",
  { sala_id => "sala_id" },
);


# You can replace this text with custom content, and it will be preserved on regeneration
1;
