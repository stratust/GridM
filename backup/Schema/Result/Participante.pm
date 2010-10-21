package GridM::Schema::Result::Participante;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "EncodedColumn", "Core");
__PACKAGE__->table("participante");
__PACKAGE__->add_columns(
  "participante_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "nome",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 200,
  },
  "tipo",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "tipoinsc",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 5,
  },
  "profissao",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
);
__PACKAGE__->set_primary_key("participante_id");
__PACKAGE__->add_unique_constraint("participante_pkey", ["participante_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-03 14:20:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HgxCbZxJc+EU3HWec9IoGA

__PACKAGE__->has_many(
  "leituras",
  "GridM::Schema::Result::Leitura",
  { "foreign.participante_id" => "self.participante_id" },
);

sub display_name{
	my ($self) = @_;
	return $self->nome || '';

}

# You can replace this text with custom content, and it will be preserved on regeneration
1;
