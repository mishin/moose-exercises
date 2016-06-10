#!/usr/bin/env perl
######################################
# $URL: http://mishin.narod.ru $
# $Date: 2011-12-23 19:53:20 +0300 (Web, 14 Sep 2011) $
# $Author: mishin nikolay $
# $Revision: 1.02 $
# $Source: convert_var_to_yaml.pl $
# $Description: convert perl variables to yaml format $
##############################################################################
#use YAML::Tiny;
#use FindBin '$Bin';
#my $config_name = 'config.yml';
#my $yaml = YAML::Tiny::LoadFile( $Bin . qq{/} . $config_name );
#use Smart::Comments;
my @input_data;

#my $self;

#print ext('my $count_xml = 10000;');
my @data_in_yaml = map { extract_var($_) } @input_data;
print join '', @data_in_yaml;
my @data_get_yaml = map { invoke_yaml($_) } @input_data;
print join '', @data_get_yaml;

sub extract_var {
	my ($string) = @_;
	$reg = '\s*my\s*[\$\@]+(\w+)\s*=\s*([^; ]+)\s*;';
	if ( $string =~ /$reg/g ) {
		$var   = $1;
		$value = $2;
	}
	return $var . ': ' . $value . "\n";
}

sub invoke_yaml {
	my ($string) = @_;
	my $yaml_row;
	$reg = '\s*(my\s*[\$\@](\w+)\s*=)\s*([^; ]+)\s*;';
	if ( $string =~ /$reg/g ) {
		$var      = $1;
		$val_name = $2;
		$yaml_row = $var . '$yaml->{' . $val_name . '};';
	}
	return $yaml_row . "\n";
}

__DATA__
my $count_xml = 10000;
my $test_file = 'test_message.xml';
my $orig_idx_file = 'orig_test_message.xml.idx';
my $commit_size = 1000;
