package Printable;
use Moose::Role;

requires 'to_string';

no Moose;

__PACKAGE__->meta->make_immutable;

1;

