package GridM::Schema::Result::Sala;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("sala");
__PACKAGE__->add_columns(
  "sala_id",
  {
    data_type => "integer",
    default_value => "nextval('sala_sala_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "descricao",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
  "image",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 40,
  },
);
__PACKAGE__->set_primary_key("sala_id");
__PACKAGE__->add_unique_constraint("sala_pk", ["sala_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:flISDO/Yz2f/oFeboOKtEQ

__PACKAGE__->has_many(
  "eventos",
  "GridM::Schema::Result::Evento",
  { "foreign.sala_id" => "self.sala_id" },
);

__PACKAGE__->has_many(
  "sala_antenas",
  "GridM::Schema::Result::SalaAntena",
  { "foreign.sala_id" => "self.sala_id" },
);


sub display_name{
	my ($self) = @_;
	return $self->descricao || '';

}


# You can replace this text with custom content, and it will be preserved on regeneration
1;
