package GridM::Schema::Result::Antena;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("antena");
__PACKAGE__->add_columns(
  "antena_id",
  {
    data_type => "integer",
    default_value => "nextval('antena_antena_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "serie",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "leitor_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "porta",
  {
    data_type => "smallint",
    default_value => undef,
    is_nullable => 1,
    size => 2,
  },
);
__PACKAGE__->set_primary_key("antena_id");
__PACKAGE__->add_unique_constraint("antena_pk", ["antena_id"]);
__PACKAGE__->belongs_to(
  "leitor_id",
  "GridM::Schema::Result::Leitor",
  { leitor_id => "leitor_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hArkf0rw0Q0rpBe/ILjiLQ



__PACKAGE__->has_many(
  "leituras",
  "GridM::Schema::Result::Leitura",
  { "foreign.antena_id" => "self.antena_id" },
);

__PACKAGE__->has_many(
  "sala_antenas",
  "GridM::Schema::Result::SalaAntena",
  { "foreign.antena_id" => "self.antena_id" },
);

sub display_name{
	my ($self) = @_;
	return $self->serie || '';

}


# You can replace this text with custom content, and it will be preserved on regeneration
1;
