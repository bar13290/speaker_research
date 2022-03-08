#!/usr/bin/perl
use warnings; #sed replacement for -w perl parameter
# Copyright   2019   BAR MADAR
# Apache 2.0

if (@ARGV != 2) {
  print STDERR "Usage: $0 <path-to-LRE-data> <path-to-output>\n";
  print STDERR "e.g. $0 /common_space_docker/storage_2/TDNN_train/2011_nist_lre_test\n";
  exit(1);
}

($db_base, $out_dir) = @ARGV;

# Handle unlabeled subset.
$out_dir_lre = "$out_dir/lre2011";
if (system("mkdir -p $out_dir_lre")) {
  die "Error making directory $out_dir_lre";
}

$tmp_dir_lre = "$out_dir_lre/tmp";
if (system("mkdir -p $tmp_dir_lre") != 0) {
  die "Error making directory $tmp_dir_lre";
}

open(SPKR, ">$out_dir_lre/utt2spk") || die "Could not open the output file $out_dir_lre/utt2spk";
open(WAV, ">$out_dir_lre/wav.scp") || die "Could not open the output file $out_dir_lre/wav.scp";

if (system("find $db_base/2011_nist_lre_test/data/ -name '*.sph' > $tmp_dir_lre/sph.list") != 0) {
  die "Error getting list of sph files";
}

open(WAVLIST, "<$tmp_dir_lre/sph.list") or die "cannot open wav list";

while(<WAVLIST>) {
  chomp;
  $sph = $_;
  @t = split("/",$sph);
  @t1 = split("[./]",$t[$#t]);
  $utt=$t1[0];
  print WAV "$utt"," sph2pipe -f wav -p -c 1 $sph |\n";
  print SPKR "$utt $utt\n";
}

close(WAV) || die;
close(SPKR) || die;

# Handle minor subset.
#$out_dir_minor= "$out_dir/sre16_minor";
#if (system("mkdir -p $out_dir_minor")) {
#  die "Error making directory $out_dir_minor";
#}

#$tmp_dir_minor = "$out_dir_minor/tmp";
#if (system("mkdir -p $tmp_dir_minor") != 0) {
#  die "Error making directory $tmp_dir_minor";
#}

#open(SPKR, ">$out_dir_minor/utt2spk") || die "Could not open the output file $out_dir_minor/utt2spk";
#open(WAV, ">$out_dir_minor/wav.scp") || die "Could not open the output file $out_dir_minor/wav.scp";

#if (system("find $db_base/data/unlabeled/minor/ -name '*.sph' > $tmp_dir_minor/sph.list") != 0) {
#  die "Error getting list of sph files";
#}

#open(WAVLIST, "<$tmp_dir_minor/sph.list") or die "cannot open wav list";

#while(<WAVLIST>) {
#  chomp;
#  $sph = $_;
#  @t = split("/",$sph);
#  @t1 = split("[./]",$t[$#t]);
#  $utt=$t1[0];
#  print WAV "$utt"," sph2pipe -f wav -p -c 1 $sph |\n";
#  print SPKR "$utt $utt\n";
#}
#close(WAV) || die;
#close(SPKR) || die;

if (system("utils/utt2spk_to_spk2utt.pl $out_dir_lre/utt2spk >$out_dir_lre/spk2utt") != 0) {
  die "Error creating spk2utt file in directory $out_dir_lre";
}
#if (system("utils/utt2spk_to_spk2utt.pl $out_dir_minor/utt2spk >$out_dir_minor/spk2utt") != 0) {
#  die "Error creating spk2utt file in directory $out_dir_minor";
#}
if (system("utils/fix_data_dir.sh $out_dir_lre") != 0) {
  die "Error fixing data dir $out_dir_lre";
}
#if (system("utils/fix_data_dir.sh $out_dir_minor") != 0) {
#  die "Error fixing data dir $out_dir_minor";
#}
