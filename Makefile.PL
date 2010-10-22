#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'GridM';
all_from 'lib/GridM.pm';

requires 'Catalyst::Runtime' => '5.80017';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::ConfigLoader::Multi';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Authorization::Roles';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::Compress';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Catalyst::Plugin::Unicode::Encoding';
requires 'parent';
requires 'Catalyst::Controller::REST';
requires 'Catalyst::View::TT';
requires 'Catalyst::Model::DBIC::Schema';
requires 'HTML::FormHandler';
requires 'HTML::FormHandler::Model::DBIC';
requires 'DBIx::Class::EncodedColumn';
requires 'Config::JFDI';
requires 'String::MkPasswd';


# Se for no ubuntu instalar do DBD:Pg via apt-get:
# apt-get install libdbd-pg-perl
requires 'DBD:Pg';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
