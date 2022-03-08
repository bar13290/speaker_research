#!/bin/bash
# Copyright      2017   David Snyder
#                2017   Johns Hopkins University (Author: Daniel Garcia-Romero)
#                2017   Johns Hopkins University (Author: Daniel Povey)
# Apache 2.0.
#
# See README.txt for more info on data required.
# Results (mostly EERs) are inline in comments below.


#ETDNN
#VOXCELEB full to train the ETDNN
#1M of augmented voxceleb to train the PLDA
# downsample the voxceleb before the processing to 8KHz using downample.py
#Using the 2 SSD 4T:
# storage_2 - data , storage_4TSSD - kaldi, storage_6 - nnet models


# SRE20 eval - same data for LDA and centering(mean)
# V1 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - SRE18_full_combined , PLDA - voxceleb_8k_combined_PLDA_1M,  adaptation - SRE18_full_combined
#     5.50  0.338 0.873

# V2 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - SRE18_19_full_combined , PLDA - voxceleb_8k_combined_PLDA_1M,  adaptation - SRE18_19_full_combined
#     5.22	0.327	0.867

# V3 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - SRE18_19_full_combined , PLDA - swbd_sre_combined,  adaptation - SRE18_19_full_combined
#     5.24 	0.313 0.891

# V4 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined , PLDA - swbd_sre_combined,  adaptation - without
#     7.50	0.388	0.995

# V5 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined , PLDA - swbd_sre_combined,  adaptation - SRE18_19_full_combined
#     5.83  0.298	0.890

# V5_2 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined , PLDA - swbd_sre_combined,  adaptation - SRE18_19_full_combined_no_sil, Test - no_sil
#     5.81	0.284	0.887

# V5_3_ASnorm -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined_no_sil , PLDA - swbd_sre_combined_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - swbd_sre_combined_no_sil, Test - no_sil
#     4.38	0.180	0.387

# V6 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined , PLDA - voxceleb_8k_combined_PLDA_1M,  adaptation - swbd_sre_combined
#     7.52	0.407	0.985

# V7 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined , PLDA - swbd_sre_combined,  adaptation - SRE18_19_full_combined, centering(mean) - SRE18_19_full_combined
#     5.33	0.300	0.864

# V7_2 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined , PLDA - swbd_sre_combined,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     5.13	0.286	0.861

# V7_3 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined_no_sil , PLDA - swbd_sre_combined_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     4.98	0.285	0.860

# V8 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_18_19_combined , PLDA - voxceleb_8k_combined_PLDA_1M,  adaptation - swbd_sre_18_19_combined
#     5.54	0.338	0.887

# V9 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_18_19_combined , PLDA - swbd_sre_18_19_combined,  adaptation - SRE18_19_full_combined, centering(mean) - SRE18_19_full_combined
#     5.59	0.334	0.845

# V10 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined , PLDA - swbd_sre_18_19_combined,  adaptation - SRE18_19_full_combined, centering(mean) - SRE18_19_full_combined
#     5.47	0.320	0.860

# V11 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_18_19_combined , PLDA - swbd_sre_combined,  adaptation - SRE18_19_full_combined, centering(mean) - SRE18_19_full_combined
#     5.38	0.304	0.868

# V11_2 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_18_19_combined_no_sil , PLDA - swbd_sre_combined_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil
#

# V12 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined_no_sil , PLDA - swbd_sre_combined_no_sil,  adaptation - SRE18_19_full_combined_SP09_no_sil, centering(mean) - swbd_sre_combined_no_sil, Test - no_sil
#     5.84	0.285	0.886

# V13 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - vox_swbd_sre_combined_1M_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - vox_swbd_sre_combined_1M_no_sil, Test - no_sil
#     3.78  0.183   0.341

# V14 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - vox_swbd_sre_combined_1M_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.68  0.179   0.336

# V15 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - vox_swbd_sre_combined_1M_no_sil ,Whitening - SRE18_19_full_combined_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.94  0.185   0.345

# V16 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - SRE18_19_full_combined_no_sil ,Whitening - SRE18_19_full_combined_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     4.11  0.186   0.347

# V17 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - vox_swbd_sre_combined_1M_no_sil ,Whitening - vox_swbd_sre_combined_1M_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.46  0.176   0.330

# V_E_17 -SRE20 xvectors extracted from "xvector_nnet_ETDNN_voxswbdsre_8k"
#     LDA - vox_swbd_sre_combined_1M_no_sil ,Whitening - vox_swbd_sre_combined_1M_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.39  0.183   0.327

# V18 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - vox_swbd_sre_combined_1M_no_sil_coral ,Whitening - vox_swbd_sre_combined_1M_no_sil_coral , PLDA - vox_swbd_sre_combined_1M_no_sil_coral,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Coral - SRE18_19_full_combined_no_sil,  Test - no_sil
#     3.81  0.203

# V19 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined_no_sil, PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.68  0.173

# V20 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_18_19_combined_no_sil, PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - swbd_sre_18_19_combined_no_sil, centering(mean) - swbd_sre_18_19_combined_no_sil, Test - no_sil
#     3.80  0.175

# V21 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_combined_no_sil, Whitening - swbd_sre_combined_no_sil, PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.64  0.172


# V22 -SRE20 xvectors extracted from "xvector_nnet_FTDNN_skip_voxceleb_8k"
#     LDA - swbd_sre_lre_combined_no_sil , PLDA - swbd_sre_lre_combined_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - swbd_sre_lre_combined_no_sil, Test - no_sil
#     5.26  0.226

. cmd.sh
. path.sh
set -e
mfccdir=`pwd`/mfcc
vaddir=`pwd`/mfcc

#trials
sre19_trials=data/sre19_eval_test/trials
sre20_trials=data/sre20_eval_test/trials
sre20_trials_cal=data/sre20_test_val/trials
sre20_test_sre18unlabeled_trials=data/sre20_eval_test/sre20test_sre18unlabeled_trials.tsv
sre20_enroll_sre18unlabeled_trials=data/sre20_eval_enroll/sre20enroll_sre18unlabeled_trials.tsv

#net
#nnet_dir=exp/xvector_nnet_FTDNN_skip_voxceleb_8k
#nnet_dir=/common_space_docker/storage_6/xvector_nnet_ETDNN_voxswbdsre_8k
nnet_dir=/common_space_docker/storage_6/xvector_nnet_EFTDNN_voxswbdsre_8k

#data
data_root=/common_space_docker/storage_2
scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software20/system_output
scoring_software_path=/common_space_docker/storage_4TSSD/scoring_software20
stage=38
export CUDA_VISIBLE_DEVICES=0,1,2,3
if [ $stage -eq 100000 ]; then
  echo "TRYYYYYYYY"
fi


###########################Prepare data######################
if [ $stage -eq 1 ]; then
  # Prepare NIST SRE 2020 data.
  echo "STARTING prepare SRE20 eval data (enrollment and test)"
  local/make_sre20_eval.pl $data_root/corpora5/SRE20/LDC2020E28 data
  echo "FINISHED prepare SRE20 eval data (enrollment and test)"
fi

if [ $stage -eq 2 ]; then
  # Prepare NIST SRE 2020_validation data.
  echo "STARTING prepare SRE20 validation data (enrollment and test)"
  local/make_sre20_cal_val.pl $data_root/corpora5/SRE20/LDC2020E28/validation_data data
  echo "FINISHED prepare SRE20 eval data (enrollment and test)"
fi

if [ $stage -eq 1 ]; then
  # Path to some, but not all of the training corpora

  # Prepare telephone and microphone speech from Mixer6.
  echo "STARTING prepare mx6 - LDC2013S03"
  #local/make_mx6.sh $data_root/TDNN_train/LDC2013S03 data/
  echo "FINISHED prepare mx6 - LDC2013S03"

  # Prepare SRE10 test and enroll. Includes microphone interview speech.
  # NOTE: This corpus is now available through the LDC as LDC2017S06.
  echo "STARTING prepare SRE10 eval - LDC2017S06"
  #local/make_sre10.pl $data_root/TDNN_train/LDC2017S06/eval/ data/
  echo "FINISHED prepare SRE10 eval - LDC2017S06"

  # Prepare SRE08 test and enroll. Includes some microphone speech. -> we missed some trial files to proccess this data
  echo "STARTING prepare SRE08 test and train - LDC2011S08 & LDC2011S05"
  local/make_sre08.pl $data_root/TDNN_train/SRE08/LDC2011S08_test $data_root/TDNN_train/SRE08/LDC2011S05_train data/
  echo "FINISHED prepare SRE08 test and enroll - LDC2011S08 & LDC2011S05"

  # This prepares the older NIST SREs from 2004-2006.
  echo "STARTING prepare SRE04,SRE05,SRE06"
  local/make_sre.sh $data_root/TDNN_train data/
  echo "FINISHED prepare SRE04,SRE05,SRE06"
fi

if [ $stage -eq 2 ]; then
  # Prepare NIST SRE 2018 data(enrollment  test and unlabeled to adapt the PLDA) - in domain data.
  echo "STARTING prepare SRE18 eval data"
  local/make_sre18_eval_SPH.pl $data_root/corpora5/SRE18/SRE18_eval_SPH data
  echo "FINISHED prepare SRE18 eval data"
  echo "STARTING prepare SRE18 dev data"
  local/make_sre18_dev_SPH.pl $data_root/corpora5/SRE18/SRE18_dev_SPH data
  echo "FINISHED prepare SRE18 eval data"
  echo "STARTING preparing SRE18 unlabeled data"
  local/make_sre18_unlabeled.pl $data_root/corpora5/SRE18/LDC2018E46_SRE18_Development_Set data
  echo "FINISHED preparing SRE18 unlabeled data"
  echo "Starting combined SRE18 eval test and unlabeled to SRE18_full"
  utils/combine_data.sh data/sre18_full data/sre18_eval_enroll data/sre18_eval_test data/sre18_dev_enroll data/sre18_dev_test data/sre18_unlabeled
  utils/fix_data_dir.sh data/sre18_full
  echo "FINISHED combined SRE18 eval test and unlabeled to sre18_full"
fi

if [ $stage -eq 3 ]; then
  # Prepare NIST SRE 2019 data.
  echo "STARTING prepare SRE19 eval data (enrollment and test)"
  local/make_sre19_eval.pl $data_root/corpora5/SRE19/LDC2019E58 data
  echo "FINISHED prepare SRE19 eval data (enrollment and test)"
  echo "Starting combined SRE19 eval test to SRE19_full"
  utils/combine_data.sh data/sre19_full data/sre19_eval_enroll data/sre19_eval_test
  utils/fix_data_dir.sh data/sre19_full      # Total - 14951 utterances
  echo "FINISHED combined SRE19 eval test and unlabeled to sre19_full"
fi

  # Combine all SREs (04,05,06,08,10) and Mixer6 into one dataset for TDNN training
if [ $stage -eq 4 ]; then
  echo "STARTING combine SRE (04,05,06,08,10) and MIXER06 for TDNN training"
  utils/combine_data.sh data/sre \
    data/sre2004 data/sre2005_train \
    data/sre2005_test data/sre2006_train \
    data/sre2006_test_1 data/sre2006_test_2 data/sre08 \
    data/sre10 data/mx6
  utils/validate_data_dir.sh --no-text --no-feats data/sre
  utils/fix_data_dir.sh data/sre
  echo "FINISHED combine SRE (04,05,06,08,10) and MIXER06 for TDNN training"
fi

if [ $stage -eq 5 ]; then
  # Prepare NIST LRE 2011 data.
  echo "STARTING prepare LRE2011 test data"
  local/make_lre.pl $data_root/TDNN_train/2011_nist_lre_test data
  echo "FINISHED prepare LRE2011 testl data"
fi

if [ $stage -eq 6 ]; then
    # Prepare VoxCeleb Corpora - 1281762 utterances
    echo "STARTING Prepare VoxCeleb1,2 data set"
    # The trials file is downloaded by local/make_voxceleb1.pl.
    voxceleb1_trials=data/voxceleb1_test/trials
    voxceleb1_8k_root=$data_root/voxceleb1_8k
    voxceleb2_8k_root=$data_root/voxceleb2_8k
    echo "STARTING Prepare VoxCeleb1 train"
    local/make_voxceleb1_v2.pl $voxceleb1_8k_root dev data/voxceleb1_8k_train
    echo "FINISHED Prepare VoxCeleb1 train"
    echo "STARTING Prepare VoxCeleb1 test"
    local/make_voxceleb1_v2.pl $voxceleb1_8k_root test data/voxceleb1_8k_test
    echo "FINISHED Prepare VoxCeleb1 test"
    echo "STARTING Prepare VoxCeleb2 train"
    local/make_voxceleb2.pl $voxceleb2_8k_root dev data/voxceleb2_8k_train
    echo "FINISHED Prepare VoxCeleb2 train"
    echo "STARTING Prepare VoxCeleb2 test"
    local/make_voxceleb2.pl $voxceleb2_8k_root test data/voxceleb2_8k_test
    echo "FINISHED Prepare VoxCeleb2 test"
    echo "FINISHED Prepare VoxCeleb1,2 data set"
    # Combine all voxceleb corpora into one dataset.
    echo "STARTING combine all VoxCeleb_8k corpora into one dataset"
    utils/combine_data.sh data/voxceleb_8k \
      data/voxceleb1_8k_train data/voxceleb1_8k_test \
      data/voxceleb2_8k_train data/voxceleb2_8k_test
    echo "FINISHED combine all VoxCeleb_8k corpora into one dataset "
fi

if [ $stage -eq 6 ]; then
  # Prepare SWBD corpora.
  echo "STARTING prepare SWBD"
    echo "STARTING prepare LDC2001S13"
  local/make_swbd_cellular1.pl $data_root/TDNN_train/LDC2001S13 \
    data/swbd_cellular1_train
	echo "Finished prepare LDC2001S13"

	echo "STARTING prepare LDC2004S07"
  local/make_swbd_cellular2.pl $data_root/TDNN_train/LDC2004S07 \
    data/swbd_cellular2_train
	echo "FINISHED prepare LDC2004S07"

	echo "STARTING prepare LDC98S75"
  local/make_swbd2_phase1.pl $data_root/TDNN_train/LDC98S75 \
    data/swbd2_phase1_train
	echo "FINISHED prepare LDC98S75"

	echo "STARTING prepare LDC99S79"
  local/make_swbd2_phase2.pl $data_root/TDNN_train/LDC99S79 \
    data/swbd2_phase2_train
	echo "FINISHED prepare LDC99S79"

	echo "STARTING prepare LDC2002S06"
  local/make_swbd2_phase3.pl $data_root/TDNN_train/LDC2002S06 \
    data/swbd2_phase3_train
	echo "FINISHED prepare LDC2002S06"
  echo "Finished prepare SWBD"
  # Combine all SWB corpora into one dataset.
  echo "STARTING combine all SWB corpora into one dataset"
  utils/combine_data.sh data/swbd \
    data/swbd_cellular1_train data/swbd_cellular2_train \
    data/swbd2_phase1_train data/swbd2_phase2_train data/swbd2_phase3_train
  echo "FINISHED combine all SWB corpora into one dataset "
fi

if [ $stage -eq 7 ]; then
  echo "Starting combined swbd and sre to swbd_sre"
  utils/combine_data.sh data/swbd_sre data/swbd data/sre
  utils/fix_data_dir.sh data/swbd_sre
  echo "FINISHED combined swbd and sre to swbd_sre"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/swbd_sre
  frame_shift=0.01
  awk -v frame_shift=$frame_shift '{print $1, $2*frame_shift;}' data/swbd_sre/utt2num_frames > data/swbd_sre/reco2dur
  echo "FINISHED create swbd_sre utt2num_frames"
fi

################# Mfcc extraction and VAD calculation section ######################
#first, we need extract mfcc and calculate VAD to the raw data
#This stage extract MFCC to the raw data - without augmentation
#after the augmentation we will extract the mfcc again but we will use the same vad calculated on the raw data
if [ $stage -eq 8 ]; then
  # Make filterbanks and compute the energy-based VAD for each dataset
  echo "STARTING making MFCC and VAD to lre2011 data set"
  for name in sre20_test_val sre20_enrollment_val   ; do
    echo "!!!!!!!!STARTING MFCC for ${name} data set!!!!!!!!!!"
    steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --write-utt2dur true --write-utt2num-frames true --nj 40 --cmd "$train_cmd" \
      data/${name} exp/make_mfcc $mfccdir
    utils/fix_data_dir.sh data/${name}
    echo "!!!!!!!!FINISHED MFCC for ${name} data set!!!!!!!!!!"
    echo "!!!!!!!!STARTING VAD for ${name} data set!!!!!!!!!"
    sid/compute_vad_decision.sh --nj 40 --cmd "$train_cmd" \
      data/${name} exp/make_vad $vaddir
    utils/fix_data_dir.sh data/${name}
	echo "!!!!!!!!FINISHED VAD for ${name} data set!!!!!!!!!"
  done
  echo "FINISHED making MFCC and VAD for lre2011 set"
fi

################# Augmentation section ######################
# In this section, we augment the data with reverberation,
# noise, music, and babble to creata "data_aug"
# and combined it with the clean data to create "data_combined"

if [ $stage -eq 9 ]; then
  # Make a reverberated version of the SRE18_full + SRE19_full data.
  if [ ! -d "RIRS_NOISES" ]; then
    # Download the package that includes the real RIRs, simulated RIRs, isotropic noises and point-source noises
    wget --no-check-certificate http://www.openslr.org/resources/28/rirs_noises.zip
    unzip rirs_noises.zip
  fi
  for name in swbd_sre voxceleb_8k; do
    rvb_opts=()
    rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/smallroom/rir_list")
    rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/mediumroom/rir_list")
    echo "STARTING reverberate ${name} data"
    python3 steps/data/reverberate_data_dir.py \
      "${rvb_opts[@]}" \
      --speech-rvb-probability 1 \
      --pointsource-noise-addition-probability 0 \
      --isotropic-noise-addition-probability 0 \
      --num-replications 1 \
      --source-sampling-rate 8000 \
      data/${name} data/${name}_reverb
    cp data/${name}/vad.scp data/${name}_reverb/
    utils/copy_data_dir.sh --utt-suffix "-reverb" data/${name}_reverb data/${name}_reverb.new
    rm -rf data/${name}_reverb
    mv data/${name}_reverb.new data/${name}_reverb
    echo "FINISHED reverberate ${name} data"
  done
fi

if [ $stage -eq 10 ]; then
  # Prepare the MUSAN corpus, which consists of music, speech, and noise for additive augmentation
  echo "STARTING prepare MUSAN data - 8Khz"
  steps/data/make_musan.sh --sampling-rate 8000 $data_root/TDNN_train/musan data
  echo "FINISHED prepare MUSAN data - 8Khz"
  #echo "STARTING prepare MUSAN data - 16Khz"
  #steps/data/make_musan_16k.sh --sampling-rate 16000 $data_root/musan data
  #echo "FINISHED prepare MUSAN data - 16Khz"
fi

if [ $stage -eq 11 ]; then
  for name in speech noise music; do
    echo "STARTING calculate duration of musan_${name} data"
    utils/data/get_utt2dur.sh data/musan_${name}
    mv data/musan_${name}/utt2dur data/musan_${name}/reco2dur
    echo "FINISHED calculate duration of musan_${name} data"
    #utils/data/get_utt2dur.sh data/musan_16k_${name}
    #mv data/musan_16k_${name}/utt2dur data/musan_16k_${name}/reco2dur
  	#echo "FINISHED calculate duration of musan_16k_${name} data"
  done
fi

if [ $stage -eq 12 ]; then
  for name in swbd_sre voxceleb_8k; do
      echo "STARTING Augmented the ${name} data set with MUSAN data"   # Uncomment the desired data to agumented
      # Augment with musan_noise
      echo "STARTING Augment with musan_noise"
      python3 steps/data/augment_data_dir.py --utt-suffix "noise" --fg-interval 1 --fg-snrs "15:10:5:0" --fg-noise-dir "data/musan_noise" data/${name} data/${name}_noise
      echo "FINISHED Augment with musan_noise"
      # Augment with musan_music
      echo "STARTING Augment with musan_music"
      python3 steps/data/augment_data_dir.py --utt-suffix "music" --bg-snrs "15:10:8:5" --num-bg-noises "1" --bg-noise-dir "data/musan_music" data/${name} data/${name}_music
      echo "FINISHED Augment with musan_music"
      # Augment with musan_speech
      echo "STARTING Augment with musan_speech"
      python3 steps/data/augment_data_dir.py --utt-suffix "babble" --bg-snrs "20:17:15:13" --num-bg-noises "3:4:5:6:7" --bg-noise-dir "data/musan_speech" data/${name} data/${name}_babble
      echo "FINISHED Augment with musan_speech"
      echo "FINISHED Augmented the ${name} data set with MUSAN data"
  done
fi

if [ $stage -eq 13 ]; then
  #in total 123216 utterances
  echo "STARTING combine all the LRE2011 reverb, noise,music and babble on the same directory(for the PLDA adaptation"
   # Combine reverb, noise, music, and babble into one directory.
  utils/combine_data.sh data/lre2011_aug data/lre2011_reverb data/lre2011_noise data/lre2011_music data/lre2011_babble
  utils/fix_data_dir.sh data/lre2011_aug
  echo "FINISHED combine all the Voxceleb reverb, noise,music and babble on the same directory - sre18_full_aug"
fi

if [ $stage -eq 14 ]; then
  #in total 63132 utterances
  echo "STARTING combine all the SRE18 reverb, noise,music and babble on the same directory(for the PLDA adaptation"
   # Combine reverb, noise, music, and babble into one directory.
  utils/combine_data.sh data/sre18_full_aug data/sre18_full_reverb data/sre18_full_noise data/sre18_full_music data/sre18_full_babble
  utils/fix_data_dir.sh data/sre18_full_aug
  echo "FINISHED combine all the Voxceleb reverb, noise,music and babble on the same directory - sre18_full_aug"
fi
if [ $stage -eq 15 ]; then
  #in total 59804 utterances
  echo "STARTING combine all the sre19_full reverb, noise,music and babble on the same directory(for the PLDA adaptation)"
   # Combine reverb, noise, music, and babble into one directory.
  utils/combine_data.sh data/sre19_full_aug data/sre19_full_reverb data/sre19_full_noise data/sre19_full_music data/sre19_full_babble
  utils/fix_data_dir.sh data/sre19_full_aug
  echo "FINISHED combine all the sre19_full reverb, noise,music and babble on the same directory - sre19_full_aug"
fi

if [ $stage -eq 16 ]; then
  #in total 5127048 utterances
  echo "STARTING combine all the voxceleb, noise,music and babble on the same directory(for the PLDA adaptation"
   # Combine reverb, noise, music, and babble into one directory.
  utils/combine_data.sh data/voxceleb_8k_aug data/voxceleb_8k_reverb data/voxceleb_8k_noise data/voxceleb_8k_music data/voxceleb_8k_babble
  utils/fix_data_dir.sh data/voxceleb_8k_aug
  echo "FINISHED combine all the Voxceleb reverb, noise,music and babble on the same directory voxceleb_aug"
fi

if [ $stage -eq 17 ]; then
  #in total 364944 utterances
  echo "STARTING combine all the swbd_sre reverb, noise,music and babble on the same directory"
   # Combine reverb, noise, music, and babble into one directory.
  utils/combine_data.sh data/swbd_sre_aug data/swbd_sre_reverb data/swbd_sre_noise data/swbd_sre_music data/swbd_sre_babble
  utils/fix_data_dir.sh data/swbd_sre_aug
  echo "FINISHED combine all the swbd_sre reverb, noise,music and babble on the same directory - swbd_sre_aug"
fi

# Extract MFCC to the augmented data
if [ $stage -eq 18 ]; then
  echo "STARTING making MFCC Proccess"
  for name in swbd_sre_aug voxceleb_8k_aug   ; do
    echo "!!!!!!!!STARTING MFCC for ${name} data set!!!!!!!!!!"
    steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --write-utt2dur true --write-utt2num-frames true --nj 40 --cmd "$train_cmd" \
      data/${name} exp/make_mfcc $mfccdir
    utils/fix_data_dir.sh data/${name}
    echo "!!!!!!!!FINISHED MFCC for ${name} data set!!!!!!!!!!"
  done
  echo "FINISHED making MFCC Proccess"
fi

if [ $stage -eq 19 ]; then
  # voxceleb_8k_combined - total 6408810 utterances
  echo "STARTING combined the voxceleb_8k clean and augmented data"
  utils/combine_data.sh data/voxceleb_8k_combined data/voxceleb_8k_aug data/voxceleb_8k
  utils/fix_data_dir.sh data/voxceleb_8k_combined
  echo "FINISHED combined the voxceleb_8k clean and augmented data"
fi

if [ $stage -eq 20 ]; then
  echo "STARTING create a random subset of the voxceleb_combined (550k) - for PLDA training"
  utils/subset_data_dir.sh data/voxceleb_8k_combined_no_sil 544990 data/voxceleb_8k_combined_no_sil_PLDA_550k
  utils/fix_data_dir.sh data/voxceleb_8k_combined_no_sil_PLDA_550k
  echo "FINISHED create a random subset of the voxceleb_combined (1M)"
fi

if [ $stage -eq 21 ]; then
  # lre2011_combined - total 154020 utterances
  echo "STARTING combined the voxceleb_8k clean and augmented data"
  utils/combine_data.sh data/lre2011_combined data/lre2011_aug data/lre2011
  utils/fix_data_dir.sh data/lre2011_combined
  echo "FINISHED combined the voxceleb_8k clean and augmented data"
fi

if [ $stage -eq 21 ]; then
  # Combine the clean and augmented sre lists.
  # SRE18_full_combined - total X utterances
  # SRE19_full_combined - Total 74755 utterances
  for name in sre18 sre19; do
    echo "STARTING combined the ${name} clean and augmented data"
    utils/combine_data.sh data/${name}_full_combined data/${name}_full_aug data/${name}_full
    utils/fix_data_dir.sh data/${name}_full_combined
    echo "FINISHED combined the sre18_full clean and augmented data"
  done
  # SRE18_19_full_combined - total 162375 utterances
  echo "STARTING combined the sre18_full_combined and sre19_full_combined together"
  utils/combine_data.sh data/sre18_19_full_combined data/sre18_full_combined data/sre19_full_combined
  utils/fix_data_dir.sh data/sre18_19_full_combined
  echo "FINISHED combined the sre18_full_combined and sre19_full_combined together"
fi

if [ $stage -eq 22 ]; then
  # swbd_sre_combined -  Total 456180 utterances
  echo "STARTING combined the swbd_sre clean and augmented data"
  utils/combine_data.sh data/swbd_sre_combined data/swbd_sre_aug data/swbd_sre
  utils/fix_data_dir.sh data/swbd_sre_combined
  echo "FINISHED combined the swbd_sre clean and augmented data"
fi

if [ $stage -eq 23 ]; then
  # swbd_sre_lre_combined -  Total 610200 utterances
  echo "STARTING combined the swbd_sre clean and augmented data"
  utils/combine_data.sh data/swbd_sre_lre_combined data/swbd_sre_combined data/lre2011_combined
  utils/fix_data_dir.sh data/swbd_sre_lre_combined
  echo "FINISHED combined the swbd_sre clean and augmented data"
fi

if [ $stage -eq 23 ]; then
  # swbd_sre_lre_combined_no_sil -  Total 610200 utterances
  echo "STARTING combined the swbd_sre clean and augmented data"
  utils/combine_data.sh data/swbd_sre_lre_combined_no_sil data/swbd_sre_combined_no_sil data/lre2011_combined
  utils/fix_data_dir.sh data/swbd_sre_lre_combined
  echo "FINISHED combined the swbd_sre clean and augmented data"
fi

if [ $stage -eq 23 ]; then
  # swbd_sre_18_19_combined -  Total 618555 utterances
  echo "STARTING combined the swbd_sre_combined and sre18_19_full_combined"
  utils/combine_data.sh data/swbd_sre_18_19_combined data/swbd_sre_combined data/sre18_19_full_combined
  utils/fix_data_dir.sh data/swbd_sre_18_19_combined
  echo "FINISHED combined the swbd_sre_combined and sre18_19_full_combined"
fi

if [ $stage -eq 24 ]; then
  # vox_swbd_sre_combined_no_sil_1M -  Total 1000000 utterances
  echo "STARTING combined the swbd_sre_combined and portion from voxceleb_combined data"
  utils/combine_data.sh data/vox_swbd_sre_combined_no_sil_1M data/swbd_sre_combined_no_sil data/voxceleb_8k_combined_no_sil_PLDA_550k
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_no_sil_1M
  echo "FINISHED combined the swbd_sre_combined and portion from voxceleb_combined data"
fi

if [ $stage -eq 25 ]; then
  # vox_swbd_sre_lre_combined_1M -  Total 1M utterances (FTDNN training)
  echo "STARTING combined the swbd_sre_combined and voxceleb_8k_combined data"
  utils/combine_data.sh data/vox_swbd_sre_lre_combined_1M data/swbd_sre_lre_combined data/voxceleb_8k_combined_PLDA_400k
  utils/fix_data_dir.sh data/vox_swbd_sre_lre_combined_1M
  echo "FINISHED combined the swbd_sre_combined and voxceleb_8k_combined data"
fi

if [ $stage -eq 26 ]; then
  # vox_swbd_sre_combined -  Total 6864990 utterances (FTDNN training)
  echo "STARTING combined the swbd_sre_combined and voxceleb_8k_combined data"
  utils/combine_data.sh data/vox_swbd_sre_combined data/swbd_sre_combined data/voxceleb_8k_combined
  utils/fix_data_dir.sh data/vox_swbd_sre_combined
  echo "FINISHED combined the swbd_sre_combined and voxceleb_8k_combined data"
fi

################# Applying CMVN and removes non-speech fames using VAD section ######################
# This script applies CMVN and removes nonspeech frames.  Note that this is somewhat
# wasteful, as it roughly doubles the amount of training data on disk.  After
# creating training examples, this can be removed.
if [ $stage -eq 27 ]; then
  #vox_swbd_sre_combined_no_sil - Total 6863820 utterances
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the TDNN train"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/vox_swbd_sre_combined data/vox_swbd_sre_combined_no_sil exp/vox_swbd_sre_combined_no_sil
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/vox_swbd_sre_combined_no_sil
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_no_sil
  echo "FINISHED calculate number of frames of each utterance"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 28 ]; then
  #voxceleb_8k_combined_no_sil - Total 6863820 utterances
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the TDNN train"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/voxceleb_8k_combined data/voxceleb_8k_combined_no_sil exp/voxceleb_8k_combined_no_sil
  utils/fix_data_dir.sh data/voxceleb_8k_combined_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/voxceleb_8k_combined_no_sil
  utils/fix_data_dir.sh data/voxceleb_8k_combined_no_sil
  echo "FINISHED calculate number of frames of each utterance"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 29 ]; then
  # swbd_sre_combined_no_sil - Total 455010 utterances
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA train"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd"  --compress true \
    data/swbd_sre_combined data/swbd_sre_combined_no_sil exp/swbd_sre_combined_no_sil
  utils/fix_data_dir.sh data/swbd_sre_combined_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/swbd_sre_combined_no_sil
  utils/fix_data_dir.sh data/swbd_sre_combined_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 28 ]; then
  # swbd_sre_lre_combined_no_sil - Total 609030 utterances
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA train"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd"  --compress true \
    data/swbd_sre_lre_combined data/swbd_sre_lre_combined_no_sil exp/swbd_sre_lre_combined_no_sil
  utils/fix_data_dir.sh data/swbd_sre_lre_combined_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/swbd_sre_lre_combined_no_sil
  utils/fix_data_dir.sh data/swbd_sre_lre_combined_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 28 ]; then
  # swbd_sre_18_19_combined_no_sil - Total 618555 utterances
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA train"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd"  --compress true \
    data/swbd_sre_18_19_combined data/swbd_sre_18_19_combined_no_sil exp/swbd_sre_18_19_combined_no_sil
  utils/fix_data_dir.sh data/swbd_sre_18_19_combined_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/swbd_sre_18_19_combined_no_sil
  utils/fix_data_dir.sh data/swbd_sre_18_19_combined_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 29 ]; then
  # vox_swbd_sre_combined_1M_no_sil
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA train"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd"  --compress true \
    data/vox_swbd_sre_combined_1M data/vox_swbd_sre_combined_1M_no_sil exp/vox_swbd_sre_combined_1M_no_sil
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_1M_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/vox_swbd_sre_combined_1M_no_sil
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_1M_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 30 ]; then
  # sre18_19_full_combined
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA adaptation"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre18_19_full_combined data/sre18_19_full_combined_no_sil exp/sre18_19_full_combined_no_sil
  utils/fix_data_dir.sh data/sre18_19_full_combined_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/sre18_19_full_combined_no_sil
  utils/fix_data_dir.sh data/sre18_19_full_combined_no_sil
  echo "FINISHED calculate number of frames of each utterance"
  echo "Starting compute VAD-MFCC to sre18_19_full_combined_no_sil data!"   # We will need the VAD for the x-vector extraction
  sid/compute_vad_decision.sh --nj 40 --cmd "$train_cmd" \
    data/sre18_19_full_combined_no_sil exp/make_vad $vaddir
  utils/fix_data_dir.sh data/sre18_19_full_combined_no_sil
  echo "FINISHED compute VAD-MFCC to ssre18_19_full_combined_no_sil data!"
fi


if [ $stage -eq 32 ]; then
  # lre2011 - 30804 utterances
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA adaptation"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/lre2011 data/lre2011_no_sil exp/lre2011_no_sil
  utils/fix_data_dir.sh data/lre2011_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/lre2011_no_sil
  utils/fix_data_dir.sh data/lre2011_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 32 ]; then
  # sre20_eval_enroll_no_sil and sre20_eval_test_no_sil
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA adaptation"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre20_eval_enroll data/sre20_eval_enroll_no_sil exp/sre20_eval_enroll_no_sil
  utils/fix_data_dir.sh data/sre20_eval_enroll_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/sre20_eval_enroll_no_sil
  utils/fix_data_dir.sh data/sre20_eval_enroll_no_sil
  echo "FINISHED calculate number of frames of each utterance"
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA adaptation"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre20_eval_test data/sre20_eval_test_no_sil exp/sre20_eval_test_no_sil
  utils/fix_data_dir.sh data/sre20_eval_test_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/sre20_eval_test_no_sil
  utils/fix_data_dir.sh data/sre20_eval_test_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 33 ]; then
  # sre20_enrollment_val_no_sil and sre20_test_val_no_sil
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA adaptation"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre20_enrollment_val data/sre20_enrollment_val_no_sil exp/sre20_enrollment_val_no_sil
  utils/fix_data_dir.sh data/sre20_enrollment_val_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/sre20_enrollment_val_no_sil
  utils/fix_data_dir.sh data/sre20_enrollment_val_no_sil
  echo "FINISHED calculate number of frames of each utterance"
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the PLDA adaptation"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre20_test_val data/sre20_test_val_no_sil exp/sre20_test_val_no_sil
  utils/fix_data_dir.sh data/sre20_test_val_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/sre20_test_val_no_sil
  utils/fix_data_dir.sh data/sre20_test_val_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 33 ]; then
  # sre19_eval_enroll_no_sil and sre19_eval_test_no_sil
  echo "STARTING applies sliding window and cmvn and remove silent frames "
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre19_eval_enroll data/sre19_eval_enroll_no_sil exp/sre19_eval_enroll_no_sil
  utils/fix_data_dir.sh data/sre19_eval_enroll_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/sre19_eval_enroll_no_sil
  utils/fix_data_dir.sh data/sre19_eval_enroll_no_sil
  echo "FINISHED calculate number of frames of each utterance"
  echo "STARTING applies sliding window and cmvn and remove silent frames "
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre19_eval_test data/sre19_eval_test_no_sil exp/sre19_eval_test_no_sil
  utils/fix_data_dir.sh data/sre19_eval_test_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/sre19_eval_test_no_sil
  utils/fix_data_dir.sh data/sre19_eval_test_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 34 ]; then
  # Now, we need to remove features that are too short after removing silence
  # frames.  We want at least 4s (400 frames) per utterance.
  echo "STARTING remove features that are to short"
  min_len=400
  mv data/vox_swbd_sre_combined_no_sil/utt2num_frames data/vox_swbd_sre_combined_no_sil/utt2num_frames.bak
  awk -v min_len=${min_len} '$2 > min_len {print $1, $2}' data/vox_swbd_sre_combined_no_sil/utt2num_frames.bak > data/vox_swbd_sre_combined_no_sil/utt2num_frames
  utils/filter_scp.pl data/vox_swbd_sre_combined_no_sil/utt2num_frames data/vox_swbd_sre_combined_no_sil/utt2spk > data/vox_swbd_sre_combined_no_sil/utt2spk.new
  mv data/vox_swbd_sre_combined_no_sil/utt2spk.new data/vox_swbd_sre_combined_no_sil/utt2spk
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_no_sil
  echo "FINISHED remove features that are to short"
fi

if [ $stage -eq 35 ]; then
  # We also want several utterances per speaker. Now we'll throw out speakers
  # with fewer than 8 utterances.
  # Before - Total 6863820 utterances
  # After -  Total 6394660 utterances
  echo "STARTING remove speakers with fewer than 8 utterance"
  min_num_utts=8
  awk '{print $1, NF-1}' data/vox_swbd_sre_combined_no_sil/spk2utt > data/vox_swbd_sre_combined_no_sil/spk2num
  awk -v min_num_utts=${min_num_utts} '$2 >= min_num_utts {print $1, $2}' data/vox_swbd_sre_combined_no_sil/spk2num | utils/filter_scp.pl - data/vox_swbd_sre_combined_no_sil/spk2utt > data/vox_swbd_sre_combined_no_sil/spk2utt.new
  mv data/vox_swbd_sre_combined_no_sil/spk2utt.new data/vox_swbd_sre_combined_no_sil/spk2utt
  utils/spk2utt_to_utt2spk.pl data/vox_swbd_sre_combined_no_sil/spk2utt > data/vox_swbd_sre_combined_no_sil/utt2spk

  utils/filter_scp.pl data/vox_swbd_sre_combined_no_sil/utt2spk data/vox_swbd_sre_combined_no_sil/utt2num_frames > data/vox_swbd_sre_combined_no_sil/utt2num_frames.new
  mv data/vox_swbd_sre_combined_no_sil/utt2num_frames.new data/vox_swbd_sre_combined_no_sil/utt2num_frames

  # Now we're ready to create training examples.
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_no_sil
  echo "FINISHED remove speakers with fewer than 8 utterance"
fi

################# TDNN TRaining section ######################

if [ $stage -eq 36 ]; then
# Now we are training the net with all the combined data using the run_xvector.sh script with the extended architecture
# voxceleb_combined_no_sil - 5944225 utterances
# vox_swbd_sre_combined_no_sil - 6394660 utterances
  echo "STARTING train the F-Extended network for the X-VECTOR with vox_swbd_sre_combined_no_sil"
  local/nnet3/xvector/run_xvector_EFTDNN_skip.sh --stage 6 --train-stage -1 \
  --data data/vox_swbd_sre_combined_no_sil --nnet-dir $nnet_dir \
  --egs-dir $nnet_dir/egs
  echo "FINISHED train the F-Extended network for the X-VECTOR with vox_swbd_sre_combined_no_sil"
fi

################# X-VECTOR Extraction section ################

if [ $stage -eq 37 ]; then
  # SRE20 test and enroll data
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre20_test"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/sre20_eval_test \
    exp/xvectors_sre20_eval_test_EF_skip_8k
  echo "FINISHED extract X_VECTOR for sre20_test"
  # The SRE20 enroll data
  echo "STARTING extract X_VECTOR for sre20_enroll"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/sre20_eval_enroll \
    exp/xvectors_sre20_eval_enroll_EF_skip_8k
  echo "FINISHED extract X_VECTOR for sre20_enroll"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 38 ]; then
  echo "$(date +"Starting on %m-%d-%y at %T")"
  # The SRE20 enroll data no_sil
  echo "STARTING extract X_VECTOR for sre20_enroll_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/sre20_eval_enroll_no_sil \
    exp/xvectors_sre20_eval_enroll_no_sil_EF_skip_8k
  echo "FINISHED extract X_VECTOR for sre20_enroll_no_sil"
  # SRE20 test data no_sil
  echo "STARTING extract X_VECTOR for sre20_test_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/sre20_eval_test_no_sil \
    exp/xvectors_sre20_eval_test_no_sil_EF_skip_8k
  echo "FINISHED extract X_VECTOR for sre20_test_no_sil"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi
exit 1
if [ $stage -eq 39 ]; then
  # SRE20 test_val data no_sil
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre20_test_val_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 \
    $nnet_dir data/sre20_test_val_no_sil \
    exp/xvectors_sre20_test_val_no_sil_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre20_test_val_no_sil"
  # The SRE20 enrollment_val data no_sil
  echo "STARTING extract X_VECTOR for sre20_enrollment_val_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 \
    $nnet_dir data/sre20_enrollment_val_no_sil \
    exp/xvectors_sre20_enrollment_val_no_sil_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre20_enrollment_val_no_sil"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 39 ]; then
  # SRE19 test and enroll data
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre19_test"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 6G" --nj 40 \
    $nnet_dir data/sre19_eval_test \
    exp/xvectors_sre19_eval_test_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre19_test"
  # The SRE19 enroll data
  echo "STARTING extract X_VECTOR for sre19_enroll"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 6G" --nj 40 \
    $nnet_dir data/sre19_eval_enroll \
    exp/xvectors_sre19_eval_enroll_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre19_enroll"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 40 ]; then
  # SRE19 test data no_sil
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre19_test_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 \
    $nnet_dir data/sre19_eval_test_no_sil \
    exp/xvectors_sre19_eval_test_no_sil_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre19_test_no_sil"
  # The SRE19 enroll data no_sil
  echo "STARTING extract X_VECTOR for sre19_enroll_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 \
    $nnet_dir data/sre19_eval_enroll_no_sil \
    exp/xvectors_sre19_eval_enroll_no_sil_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre19_enroll_no_sil"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 41 ]; then
  # SRE18_unlabeled data no_sil
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre18_unlabeled_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/sre18_unlabeled_no_sil \
    exp/xvectors_sre18_unlabeled_no_sil_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre18_unlabeled_no_sil"
fi

if [ $stage -eq 42 ]; then
  # LRE2011_no_sil
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for lre2011_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/lre2011_no_sil \
    exp/xvectors_lre2011_no_sil_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for lre2011_no_sil"
fi

if [ $stage -eq 42 ]; then
  # swbd_sre_combined to train the PLDA data
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for swbd_sre_combined"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 6G" --nj 40 --use-gpu false \
    $nnet_dir data/swbd_sre_combined \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for swbd_sre_combined"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 43 ]; then
  # swbd_sre_combined_no_sil to train the PLDA data
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for swbd_sre_combined_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/swbd_sre_combined_no_sil \
    exp/xvectors_swbd_sre_combined_no_sil_E1_8k
  echo "FINISHED extract X_VECTOR for swbd_sre_combined_no_sil"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 44 ]; then
  # swbd_sre_lre_combined_no_sil to train the PLDA data
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for swbd_sre_lre_combined_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/swbd_sre_lre_combined_no_sil \
    exp/xvectors_swbd_sre_lre_combined_no_sil_E10_8k
  echo "FINISHED extract X_VECTOR for swbd_sre_lre_combined_no_sil"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 45 ]; then
  # vox_swbd_sre_combined_1M_no_sil to train the PLDA data
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for vox_swbd_sre_combined_1M_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 24G" --nj 40 --use-gpu false \
    $nnet_dir data/vox_swbd_sre_combined_1M_no_sil \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k
  echo "FINISHED extract X_VECTOR for vox_swbd_sre_combined_1M_no_sil"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 45 ]; then
  # SRE18_full_combined to adapt the PLDA
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre18_full_combined"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 6G" --nj 40 \
    $nnet_dir data/sre18_full_combined \
    exp/xvectors_sre18_full_combined_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre18_full_combined"
  echo "$(date +"Starting on %m-%d-%y at %T")"
fi

if [ $stage -eq 46 ]; then
  # SRE18_19_full_combined to adapt the PLDA
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre18_19_full_combined"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 6G" --nj 40 --use-gpu false \
    $nnet_dir data/sre18_19_full_combined \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for sre18_19_full_combined"
  echo "$(date +"Starting on %m-%d-%y at %T")"
fi

if [ $stage -eq 47 ]; then
  # SRE18_19_full_combined_no_sil to adapt the PLDA
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for sre18_19_full_combined_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 6G" --nj 40 --use-gpu false \
    $nnet_dir data/sre18_19_full_combined_no_sil \
    exp/xvectors_sre18_19_full_combined_no_sil_E1_8k
  echo "FINISHED extract X_VECTOR for sre18_19_full_combined_no_sil"
  echo "$(date +"Starting on %m-%d-%y at %T")"
fi


if [ $stage -eq 48 ]; then
  # SWBD_SRE_18_19_combined to train and adapt the PLDA
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for SWBD_SRE_18_19_combined"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 6G" --nj 40 --use-gpu false \
    $nnet_dir data/swbd_sre_18_19_combined \
    exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for SWBD_SRE_18_19_combined"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 49 ]; then
  # SWBD_SRE_18_19_combined to train and adapt the PLDA
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING extract X_VECTOR for SWBD_SRE_18_19_combined_no_sil"
  sid/nnet3/xvector/extract_xvectors_no_sil.sh --cmd "$train_cmd --mem 6G" --nj 40 --use-gpu false \
    $nnet_dir data/swbd_sre_18_19_combined_no_sil \
    exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for SWBD_SRE_18_19_combined_no_sil"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

#Stages 50-51 are for x-vector extraction from a portion (random subset) of an existing data
if [ $stage -eq 50 ]; then
  echo "STARTING create a random subset of the voxceleb_combined (1M) - for PLDA training"
  utils/subset_data_dir.sh data/voxceleb_8k_combined 1000000 data/voxceleb_8k_combined_PLDA_1M
  utils/fix_data_dir.sh data/voxceleb_8k_combined_PLDA_1M
  echo "FINISHED create a random subset of the voxceleb_combined (1M)"
fi

if [ $stage -eq 51 ]; then
# Extract xvectors for voxceleb combined to train the PLDA. We'll use this for
# things like LDA or PLDA.
  echo "STARTING extract X_VECTOR for voxceleb_combined for training the PLDA"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 12G" --nj 40 \
    $nnet_dir data/voxceleb_8k_combined_PLDA_1M \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for voxceleb_8k_combined - raw data with augmentation for training the PLDA"
fi

#################Compute mean vector (for centering purpose)#####################
if [ $stage -eq 52 ]; then
  # Compute the mean vector of the x-vectors in-domain (SRE18_19_full_combined) data for centering the evaluation xvectors.
  echo "Compute the mean vector for sre18_19_full_combined_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_sre18_19_full_combined_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_sre18_19_full_combined_Fv_skip_8k/xvector.scp \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for sre18_19_full_combined_Fv_skip_8k"
fi

if [ $stage -eq 53 ]; then
  # Compute the mean vector of the x-vectors in-domain (SRE18_19_full_combined_no_sil) data for centering the evaluation xvectors.
  echo "Compute the mean vector for sre18_19_full_combined_no_sil_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for sre18_19_full_combined_no_sil_Fv_skip_8k"
fi

if [ $stage -eq 54 ]; then
  # Compute the mean vector of the x-vectors in-domain (SRE18_19_full_combined_no_sil) data for centering the evaluation xvectors.
  echo "Compute the mean vector for sre18_19_full_combined_no_sil_E1_8k xvectors"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/xvector.scp \
    exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for sre18_19_full_combined_no_sil_E1_8k"
fi

if [ $stage -eq 54 ]; then
  # Compute the mean vector of the x-vectors in-domain (swbd_sre_combined) data for centering the evaluation xvectors.
  echo "Compute the mean vector for swbd_sre_combined_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_swbd_sre_combined_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_swbd_sre_combined_Fv_skip_8k/xvector.scp \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for swbd_sre_combined_Fv_skip_8k"
fi

if [ $stage -eq 55 ]; then
  # Compute the mean vector of the x-vectors in-domain (swbd_sre_combined_no_sil) data for centering the evaluation xvectors.
  echo "Compute the mean vector for swbd_sre_combined_no_sil_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/xvector.scp \
    exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for swbd_sre_combined_no_sil_Fv_skip_8k"
fi

if [ $stage -eq 56 ]; then
  # Compute the mean vector of the x-vectors in-domain (swbd_sre_lre_combined_no_sil) data for centering the evaluation xvectors.
  echo "Compute the mean vector for swbd_sre_lre_combined_no_sil_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/xvector.scp \
    exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for swbd_sre_lre_combined_no_sil_Fv_skip_8k"
fi

if [ $stage -eq 56 ]; then
  # Compute the mean vector of the x-vectors in-domain (vox_swbd_sre_combined_1M_no_sil) data for centering the evaluation xvectors.
  echo "Compute the mean vector for vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k"
fi

if [ $stage -eq 57 ]; then
  # Compute the mean vector of the x-vectors in-domain (swbd_sre_18_19_combined) data for centering the evaluation xvectors.
  echo "Compute the mean vector for swbd_sre_18_19_combined_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/xvector.scp \
    exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for swbd_sre_18_19_combined_Fv_skip_8k"
fi

if [ $stage -eq 58 ]; then
  # Compute the mean vector of the x-vectors in-domain (swbd_sre_18_19_combined_no_sil) data for centering the evaluation xvectors.
  echo "Compute the mean vector for swbd_sre_18_19_combined_no_sil_Fv_skip_8k xvectors"
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/xvector.scp \
    exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/mean.vec || exit 1;
  echo "FINISHED compute mean vector for swbd_sre_18_19_combined_no_sil_Fv_skip_8k"
fi

#############################################################################
############################# Backend Proccessing ###########################
#############################################################################

###################CORAL adaptation####################

#mean normalization for the In-domain and Out-of-domain
if [ $stage -eq 59 ]; then
  echo "STARTING mean normalization for the ID and OOD data before the CORAL adaptation"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark,scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector_normalized.ark,exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector_normalized.scp
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark,scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector_normalized.ark,exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector_normalized.scp
  echo "FINISHED mean normalization for the ID and OOD data before the CORAL adaptation"
fi

if [ $stage -eq 60 ]; then
  echo "STARTING mean normalization for the SRE20 enrollment & test data before the CORAL adaptation"
  $train_cmd exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-subtract-global-mean scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark,scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector_normalized.ark,exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector_normalized.scp
  $train_cmd exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/log/compute_mean.log \
    ivector-subtract-global-mean scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark,scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector_normalized.ark,exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector_normalized.scp
  echo "FINISHED mean normalization for the SRE20 enrollment & test data before the CORAL adaptation"
fi

#Perform CORAL adaptation
if [ $stage -eq 61 ]; then
  echo "STARTING CORAL adaptation"
  python3 backend_utils/coral.py exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector_normalized.scp exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector_normalized.scp exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed
  echo "FINISHED CORAL adaptation"
  echo "STRATING arrange xvectors_coraltransform scp and ark files"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/copy_vector.log \
    copy-vector ark:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/xvector_transformed.ark ark,scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/xvector.ark,exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/xvector.scp
  rm exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/xvector_transformed.ark
  echo "FINISHED arrange xvectors_coraltransform scp and ark files"
fi

###################LDA training##################

if [ $stage -eq 62 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the swbd_sre_18_19_combined_Fv_skip_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/xvector.scp ark:- |" \
    ark:data/swbd_sre_18_19_combined/utt2spk exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the swbd_sre_18_19_combined_Fv_skip_8k data"
fi

if [ $stage -eq 63 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the swbd_sre_18_19_combined_no_sil_Fv_skip_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/xvector.scp ark:- |" \
    ark:data/swbd_sre_18_19_combined/utt2spk exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the swbd_sre_18_19_combined_no_sil_Fv_skip_8k data"
fi

if [ $stage -eq 64 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the swbd_sre_combined_no_sil_Fv_skip_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/xvector.scp ark:- |" \
    ark:data/swbd_sre_combined_no_sil/utt2spk exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the swbd_sre_combined_no_sil_Fv_skip_8k data"
fi

if [ $stage -eq 65 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the swbd_sre_lre_combined_no_sil_Fv_skip_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/xvector.scp ark:- |" \
    ark:data/swbd_sre_lre_combined_no_sil/utt2spk exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the swbd_sre_lre_combined_no_sil_Fv_skip_8k data"
fi

if [ $stage -eq 65 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the swbd_sre_combined_Fv_skip_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_swbd_sre_combined_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_Fv_skip_8k/xvector.scp ark:- |" \
    ark:data/swbd_sre_combined/utt2spk exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the swbd_sre_combined_Fv3_8k data"
fi

if [ $stage -eq 66 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- |" \
    ark:data/vox_swbd_sre_combined_1M_no_sil/utt2spk exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k data"
fi

if [ $stage -eq 67 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the vox_swbd_sre_combined_1M_no_sil_E1_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/xvector.scp ark:- |" \
    ark:data/vox_swbd_sre_combined_1M_no_sil/utt2spk exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the vox_swbd_sre_combined_1M_no_sil_E1_8k data"
fi

if [ $stage -eq 67 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed data"
  lda_dim=250
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/xvector.scp ark:- |" \
    ark:data/vox_swbd_sre_combined_1M_no_sil/utt2spk exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/transform.mat || exit 1;
  echo "FINISHED LDA for the vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed data"
fi

if [ $stage -eq 68 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the sre18_19_full_combined_no_sil_Fv_skip_8k data"
  lda_dim=250
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- |" \
    ark:data/sre18_19_full_combined_no_sil/utt2spk exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/transform.mat || exit 1;
  echo "FINISHED LDA for the sre18_19_full_combined_no_sil_Fv_skip_8k data"
fi


###################Whitening training##################
if [ $stage -eq 69 ]; then
  # This script compute in-domain Whitening matrix(PCA without dimension reduction) to normalize the (centered) covariance of the features.
  # the whitening transformation is applying after the LDA
  echo "STARTING compute Whitening matrix to sre18_19_full_combined_no_sil (LDA-vox_swbd_sre_combined_1M_no_sil) "
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/whiten.log \
    est-pca --read-vectors=true --normalize-mean=false --normalize-variance=true \
      "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- |" \
      exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat
  echo "FINISHED compute Whitening matrix to sre18_19_full_combined_no_sil (LDA-vox_swbd_sre_combined_1M_no_sil)  "
fi

if [ $stage -eq 70 ]; then
  # This script compute in-domain Whitening matrix(PCA without dimension reduction) to normalize the (centered) covariance of the features.
  # the whitening transformation is applying after the LDA
  echo "STARTING compute Whitening matrix to sre18_19_full_combined_no_sil (LDA-sre18_19_full_combined_no_sil)"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/whiten.log \
    est-pca --read-vectors=true --normalize-mean=false --normalize-variance=true \
      "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- |" \
      exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAsre1819combined_whiten.mat
  echo "FINISHED compute Whitening matrix to sre18_19_full_combined_no_sil (LDA-sre18_19_full_combined_no_sil) "
fi

if [ $stage -eq 71 ]; then
  # This script compute in-domain Whitening matrix(PCA without dimension reduction) to normalize the (centered) covariance of the features.
  # the whitening transformation is applying after the LDA
  echo "STARTING compute Whitening matrix to swbd_sre_combined_1M_no_sil (LDA-swbd_sre_combined_no_sil) "
  $train_cmd exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/log/whiten.log \
    est-pca --read-vectors=true --normalize-mean=false --normalize-variance=true \
      "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- |" \
      exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/LDAswbdsre_whiten.mat
  echo "FINISHED compute Whitening matrix to swbd_sre_combined_no_sil (LDA-swbd_sre_combined_no_sil)  "
fi

if [ $stage -eq 72 ]; then
  # This script compute in-domain Whitening matrix(PCA without dimension reduction) to normalize the (centered) covariance of the features.
  # the whitening transformation is applying after the LDA
  echo "STARTING compute Whitening matrix to vox_swbd_sre_combined_1M_no_sil (LDA-vox_swbd_sre_combined_1M_no_sil) "
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/whiten.log \
    est-pca --read-vectors=true --normalize-mean=false --normalize-variance=true \
      "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- |" \
      exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat
  echo "FINISHED compute Whitening matrix to vox_swbd_sre_combined_1M_no_sil (LDA-vox_swbd_sre_combined_1M_no_sil)  "
fi

if [ $stage -eq 73 ]; then
  # This script compute in-domain Whitening matrix(PCA without dimension reduction) to normalize the (centered) covariance of the features.
  # the whitening transformation is applying after the LDA
  echo "STARTING compute Whitening matrix to vox_swbd_sre_combined_1M_no_sil (LDA-vox_swbd_sre_combined_1M_no_sil) "
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/log/whiten.log \
    est-pca --read-vectors=true --normalize-mean=false --normalize-variance=true \
      "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/transform.mat ark:- ark:- |" \
      exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/LDAvoxswbdsre_whiten.mat
  echo "FINISHED compute Whitening matrix to vox_swbd_sre_combined_1M_no_sil (LDA-vox_swbd_sre_combined_1M_no_sil)  "
fi

if [ $stage -eq 73 ]; then
  # This script compute in-domain Whitening matrix(PCA without dimension reduction) to normalize the (centered) covariance of the features.
  # the whitening transformation is applying after the LDA
  echo "STARTING compute Whitening matrix to vox_swbd_sre_combined_1M_no_sil_coraltransformed (LDA-vox_swbd_sre_combined_1M_no_sil_coraltransformed) "
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/log/whiten.log \
    est-pca --read-vectors=true --normalize-mean=false --normalize-variance=true \
      "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/transform.mat ark:- ark:- |" \
      exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/LDAvoxswbdsre_whiten.mat
  echo "FINISHED compute Whitening matrix to vox_swbd_sre_combined_1M_no_sil_coraltransformed (LDA-vox_swbd_sre_combined_1M_no_sil_coraltransformed)  "
fi


###################OOD PLDA training###################
if [ $stage -eq 74 ]; then
  # Train an out-of-domain PLDA model(voxceleb combined data)
  # Using LDA of in-domain data (SRE18_19).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/voxceleb_8k_combined_PLDA_1M/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_lda1819 || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 75 ]; then
  # Train an out-of-domain PLDA model(voxceleb combined data)
  # Using LDA of in-domain data (SWBD_SRE_COMBINED).
  echo "STARTING to train an out-of-domain PLDA model (voxceleb combined data) Using LDA of in-domain data (SWBD_SRE_COMBINED)"
  $train_cmd exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/voxceleb_8k_combined_PLDA_1M/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_ldaswbdsre || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model (voxceleb combined data) Using LDA of in-domain data (SWBD_SRE_COMBINED)"
fi

if [ $stage -eq 76 ]; then
  # Train an out-of-domain PLDA model(voxceleb combined data)
  # Using LDA of in-domain data (SWBD_SRE_18_19_COMBINED).
  echo "STARTING to train an out-of-domain PLDA model (voxceleb combined data) Using LDA of in-domain data (SWBD_SRE_18_19_COMBINED)"
  $train_cmd exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/voxceleb_8k_combined_PLDA_1M/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_ldaswbdsre1819 || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model (voxceleb combined data) Using LDA of in-domain data (SWBD_SRE_18_19_COMBINED)"
fi

if [ $stage -eq 77 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_combined)
  # Using LDA of in-domain data (SRE18_19).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_combined_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_combined/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_lda1819 || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 78 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_combined)
  # Using LDA of in-domain data (swbd_sre_combined).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_combined_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_combined/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_ldaswbdsre || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 79 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_combined_no_sil)
  # Using LDA of in-domain data (swbd_sre_combined_no_sil).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_combined_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/plda_ldaswbdsre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 80 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_lre_combined_no_sil)
  # Using LDA of in-domain data (swbd_sre_lre_combined_no_sil).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_lre_combined_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/plda_ldaswbdsrelre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 80 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (vox_swbd_sre_combined_1M_no_sil).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldavoxswbdsre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 81 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (swbd_sre_combined_no_sil).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldaswbdsre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 81 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (swbd_sre_18_19_combined_no_sil).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldaswbdsre1819_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 82 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (vox_swbd_sre_combined_1M_no_sil).
  # Appplying whitening matrix (sre_18_19_combined_no_sil)
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldavoxswbdsre_whitsre189combined_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 83 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (vox_swbd_sre_combined_1M_no_sil).
  # Appplying whitening matrix (vox_swbd_sre_combined_1M_no_sil)
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldawhitevoxswbdsre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 84 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (vox_swbd_sre_combined_1M_no_sil).
  # Appplying whitening matrix (vox_swbd_sre_combined_1M_no_sil)
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/plda_ldawhitevoxswbdsre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 84 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (swbd_sre_combined_no_sil).
  # Appplying whitening matrix (swbd_sre_combined_no_sil)
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/LDAswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldawhiteswbdsre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 85 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil_coraltransformed)
  # Using LDA of in-domain data (vox_swbd_sre_combined_1M_no_sil_coraltransformed).
  # Appplying whitening matrix (vox_swbd_sre_combined_1M_no_sil_coraltransformed)
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/plda_ldawhitevoxswbdsre_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 86 ]; then
  # Train an out-of-domain PLDA model(vox_swbd_sre_combined_1M_no_sil)
  # Using LDA of in-domain data (sre_18_19_combined_no_sil).
  # Appplying whitening matrix (sre_18_19_combined_no_sil)
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/vox_swbd_sre_combined_1M_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAsre1819combined_whiten.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_lda_whitsre189combined_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 87 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_combined)
  # Using LDA of in-domain data (swbd_sre_18_19_combined).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_combined_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_combined/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_ldaswbdsre1819 || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 88 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_combined_no_sil)
  # Using LDA of in-domain data (swbd_sre_18_19_combined_no_sil).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_combined_no_sil/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/plda_ldaswbdsre1819_nosil || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 89 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_18_19_combined)
  # Using LDA of in-domain data (swbd_sre_combined).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_18_19_combined/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/plda_ldaswbdsre || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 90 ]; then
  # Train an out-of-domain PLDA model(swbd_sre_18_19_combined)
  # Using LDA of in-domain data (swbd_sre_18_19_combined).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/log/plda.log \
    ivector-compute-plda ark:data/swbd_sre_18_19_combined/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/plda_ldaswbdsre1819 || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

###################PLDA adaptation##################

if [ $stage -eq 91 ]; then
  # Here we adapt the out-of-domain voxceleb_8k_combined_PLDA_1M PLDA (Using the SRE18_19 LDA) model to SRE18_19_full_combined
  echo "STARTING adapt the out of domain PLDA model with xvectors_sre18_full_combined_Fv_skip_8k"
  $train_cmd exp/xvectors_sre18_19_full_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_lda1819 \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_adapt_8k_voxceleb_combined_1M || exit 1;
  echo "FINISHED adapted the out of domain PLDA model with xvectors_sre18_19_full_combined_Fv_skip_8k"
fi

if [ $stage -eq 92 ]; then
  # Here we adapt the out-of-domain voxceleb_8k_combined_PLDA_1M PLDA (Using the SWBD_SRE_COMBINED LDA) model to SWBD_SRE_combined
  echo "STARTING adapt the out-of-domain voxceleb_8k_combined_PLDA_1M PLDA (Using the SWBD_SRE_COMBINED LDA) model to SWBD_SRE_combined"
  $train_cmd exp/xvectors_swbd_sre_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_ldaswbdsre \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_adapt_8k_voxceleb_combined_1M || exit 1;
  echo "FINISHED adapted the out-of-domain voxceleb_8k_combined_PLDA_1M PLDA (Using the SWBD_SRE_COMBINED LDA) model to SWBD_SRE_combined"
fi

if [ $stage -eq 93 ]; then
  # Here we adapt the out-of-domain voxceleb_8k_combined_PLDA_1M PLDA (Using the SWBD_SRE_18_19_COMBINED LDA) model to SWBD_SRE_18_19_combined
  echo "STARTING adapt the out-of-domain voxceleb_8k_combined_PLDA_1M PLDA (Using the SWBD_SRE_18_19_COMBINED LDA) model to SWBD_SRE_18_19_combined"
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_ldaswbdsre1819 \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/plda_adapt_8k_voxceleb_combined_1M || exit 1;
  echo "FINISHED adapted the out-of-domain voxceleb_8k_combined_PLDA_1M PLDA (Using the SWBD_SRE_18_19_COMBINED LDA) model to SWBD_SRE_18_19_combined"
fi

if [ $stage -eq 94 ]; then
  # Here we adapt the out-of-domain swbd_sre_combined PLDA (Using the SRE18_19 LDA) model to SRE18_19_full_combined
  echo "STARTING adapt the out of domain PLDA model with xvectors_sre18_full_combined_Fv_skip_8k"
  $train_cmd exp/xvectors_sre18_19_full_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_lda1819 \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_adapt_8k_swbd_sre_combined || exit 1;
  echo "FINISHED adapted the out of domain PLDA model with xvectors_sre18_19_full_combined_Fv_skip_8k"
fi

if [ $stage -eq 95 ]; then
  # Here we adapt the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined
  echo "STARTING adapt the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined"
  $train_cmd exp/xvectors_sre18_19_full_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_ldaswbdsre \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined || exit 1;
  echo "FINISHED adapted the the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined"
fi

if [ $stage -eq 96 ]; then
  # Here we adapt the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined_no_sil
  echo "STARTING adapt the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_ldaswbdsre \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined || exit 1;
  echo "FINISHED adapted the the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 97 ]; then
  # Here we adapt the out-of-domain swbd_sre_combined_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil
  echo "STARTING adapt the out-of-domain swbd_sre_combined_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/plda_ldaswbdsre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain swbd_sre_combined_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 98 ]; then
  # Here we adapt the out-of-domain swbd_sre_lre_combined_no_sil PLDA (Using the swbd_sre_lre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil
  echo "STARTING adapt the out-of-domain swbd_sre_lre_combined_no_sil PLDA (Using the swbd_sre_lre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/plda_ldaswbdsrelre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_lre_combined_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain swbd_sre_lre_combined_no_sil PLDA (Using the swbd_sre_lre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 98 ]; then
  # Here we adapt the out-of-domain swbd_sre_combined_no_sil PLDA (Using the swbd_sre_18_19_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil
  echo "STARTING adapt the out-of-domain swbd_sre_combined_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/plda_ldaswbdsre1819_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_swbdsre1819_adapt_8k_swbd_sre_combined_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain swbd_sre_combined_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 99 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldavoxswbdsre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 100 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldaswbdsre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_lda_swbd_sre_combined_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 101 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_18_19_combined_no_sil LDA) model to swbd_sre_18_19_combined_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_18_19_combined_no_sil LDA) model to swbd_sre_18_19_combined_no_sil"
  $train_cmd exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldaswbdsre1819_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_lda_swbd_sre_18_19_combined_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_18_19_combined_no_sil LDA) model to swbd_sre_18_19_combined_no_sil"
fi

if [ $stage -eq 102 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil
  # whitening - sre18_19_combined_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldavoxswbdsre_whitsre1819combined_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_whitsre1819combined_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 103 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil
  # whitening - vox_swbd_sre_combined_1M_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldawhitevoxswbdsre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_whitevoxswbdsre_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 104 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil
  # whitening - vox_swbd_sre_combined_1M_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/plda_ldawhitevoxswbdsre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_whitevoxswbdsre_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the vox_swbd_sre_combined_1M_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 104 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil
  # whitening - swbd_sre_combined_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_ldawhiteswbdsre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/LDAswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_ldawhite_swbdsre_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the swbd_sre_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 105 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil_coraltransformed PLDA (Using the vox_swbd_sre_combined_1M_no_sil_coraltransformed LDA) model to SRE18_19_full_combined_no_sil
  # whitening - vox_swbd_sre_combined_1M_no_sil_coraltransformed
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil_coraltransformed PLDA (Using the vox_swbd_sre_combined_1M_no_sil_coraltransformed LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/plda_ldawhitevoxswbdsre_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M__coraltransformed_whitevoxswbdsre_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil_coraltransformed PLDA (Using the vox_swbd_sre_combined_1M_no_sil_coraltransformed LDA) model to SRE18_19_full_combined_no_sil"
fi

if [ $stage -eq 106 ]; then
  # Here we adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the sre18_19_full_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil
  # whitening - sre18_19_combined_no_sil
  echo "STARTING adapt the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the sre18_19_full_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
  $train_cmd exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/plda_lda_whitsre1819combined_nosil \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAsre1819combined_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_8k_vox_swbd_sre_combined_1M_ldawhitsre1819combined_nosil || exit 1;
  echo "FINISHED adapted the the out-of-domain vox_swbd_sre_combined_1M_no_sil PLDA (Using the sre18_19_full_combined_no_sil LDA) model to SRE18_19_full_combined_no_sil"
fi


if [ $stage -eq 107 ]; then
  # Here we adapt the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_18_19_combined LDA) model to SRE18_19_full_combined
  echo "STARTING adapt the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_18_19_combined LDA) model to SRE18_19_full_combined"
  $train_cmd exp/xvectors_sre18_19_full_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_ldaswbdsre1819 \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_swbdsre1819_adapt_8k_swbd_sre_combined || exit 1;
  echo "FINISHED adapted the the out-of-domain swbd_sre_combined PLDA (Using the swbd_sre_18_19_combined LDA) model to SRE18_19_full_combined"
fi

if [ $stage -eq 108 ]; then
  # Here we adapt the out-of-domain swbd_sre_18_19_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined
  echo "STARTING adapt the out-of-domain swbd_sre_18_19_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined"
  $train_cmd exp/xvectors_sre18_19_full_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/plda_ldaswbdsre \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_swbdsre_adapt_8k_swbd_sre_18_19_combined || exit 1;
  echo "FINISHED adapted the out-of-domain swbd_sre_18_19_combined PLDA (Using the swbd_sre_combined LDA) model to SRE18_19_full_combined"
fi

if [ $stage -eq 109 ]; then
  # Here we adapt the out-of-domain swbd_sre_18_19_combined PLDA (Using the swbd_sre_18_19_combined LDA) model to SRE18_19_full_combined
  echo "STARTING adapt the out-of-domain swbd_sre_18_19_combined PLDA (Using the swbd_sre_18_19_combined LDA) model to SRE18_19_full_combined"
  $train_cmd exp/xvectors_sre18_19_full_combined_Fv_skip_8k/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/plda_ldaswbdsre1819 \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_19_full_combined_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_18_19_combined || exit 1;
  echo "FINISHED adapted the the out-of-domain swbd_sre_18_19_combined PLDA (Using the swbd_sre_18_19_combined LDA) model to SRE18_19_full_combined"
fi

######################### Scoring #############################

# V1 : PLDA - voxceleb_combined_1M | mean+LDA - SRE18_full_combined | adaptation - SRE18_full_combined
if [ $stage -eq 110 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - adapted model - SRE18 full_combined_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scoring_Fv_skip_8k.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_full_combined_Fv_skip_8k/plda_adapt_8k_combined_1M - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_sre18_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/sre20_eval_scores_adapt_Fv_skip_8k || exit 1;
  echo "FINISHED scoring sre20 eval - Fv3_skip - adapted model - sre18_full_combined_Fv_skip_8k"
fi

# V2 : PLDA - voxceleb_combined_1M | mean+LDA - SRE18_19_full_combined | adaptation - SRE18_19_full_combined
if [ $stage -eq 111 ]; then
  # Get results.
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA voxceleb_combined_1M adapted model - SRE18_19_full_combined_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V2.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_adapt_8k_voxceleb_combined_1M - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/SRE19_fusion/sre20_eval_scores_V2 || exit 1;
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA voxceleb_combined_1M adapted model - SRE18_19_full_combined_Fv_skip_8k"
fi

# V3 : PLDA - SWBD_SRE_combined | mean+LDA - SRE18_19_full_combined | adaptation - SRE18_19_full_combined
if [ $stage -eq 112 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined , adapted model - SRE18_19_full_combined_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V3.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_adapt_8k_swbd_sre_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V3 || exit 1;
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined , adapted model - SRE18_19_full_combined_Fv_skip_8k"
fi

# V4 : PLDA - SWBD_SRE_combined | mean+LDA - SWBD_SRE_combined | adaptation - without
if [ $stage -eq 113 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined without adaptation"
  $train_cmd exp/scores/log/sre20_eval_scores_V4.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_ldaswbdsre - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V4 || exit 1;
  echo "FINISHED scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined without adaptation"
fi

# V5 : PLDA - SWBD_SRE_combined | mean+LDA - SWBD_SRE_combined | adaptation - SRE18_19_full_combined
if [ $stage -eq 114 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model - SRE18_19_full_combined_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V5.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V5 || exit 1;
  echo "FINISHED scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model - SRE18_19_full_combined_Fv_skip_8k"
fi

# V5_2 : PLDA - SWBD_SRE_combined | mean+LDA - SWBD_SRE_combined | adaptation - SRE18_19_full_combined_no_sil
if [ $stage -eq 115 ]; then
  # Get results using the PLDA model - SRE18 full_combined_Fv_skip_8k.
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V5_2.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V5_2 || exit 1;
  echo "FINISHED scoring eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V5_3 : PLDA - SWBD_SRE_combined_no_sil | mean+LDA - SWBD_SRE_combined_no_sil | adaptation - SRE18_19_full_combined_no_sil
if [ $stage -eq 116 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined_no_sil LDA SRE_SWBD_combined_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V5_3.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V5_3 || exit 1;
  echo "FINISHED scoring eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined_no_sil LDA SRE_SWBD_combined_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V6 : PLDA - voxceleb_combined_1M | mean+LDA - SWBD_SRE_combined | adaptation - SWBD_SRE_combined
if [ $stage -eq 117 ]; then
  # Get results.
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA voxceleb_combined_1M adapted model - SWBD_SRE_combined_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V6.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_swbd_sre_combined_Fv_skip_8k/plda_adapt_8k_voxceleb_combined_1M - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V6 || exit 1;
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA voxceleb_combined_1M adapted model - SWBD_SRE_combined_combined_Fv_skip_8k"
fi

# V7 : PLDA - SWBD_SRE_combined | mean+LDA - SWBD_SRE_combined | adaptation - SRE18_19_full_combined | centering - SRE18_19_full_combined
if [ $stage -eq 118 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model & centering - SRE18_19_full_combined_Fv_skip_8k "
  $train_cmd exp/scores/log/sre20_eval_scores_V7.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V7 || exit 1;
  echo "FINISHED scoring sre20 eval - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model & centering - SRE18_19_full_combined_Fv_skip_8k"
fi

# V7_2 : PLDA - SWBD_SRE_combined | mean+LDA - SWBD_SRE_combined | adaptation - SRE18_19_full_combined_no_sil | centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 119 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k "
  $train_cmd exp/scores/log/sre20_eval_scores_V7_2.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V7_2 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined  adapted model & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V7_3 : PLDA - SWBD_SRE_combined_no_sil | mean+LDA - SWBD_SRE_combined_no_sil | adaptation - SRE18_19_full_combined_no_sil | centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 120 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined_no_sil LDA SRE_SWBD_combined_no_sil  adapted model & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k "
  $train_cmd exp/scores/log/sre20_eval_scores_V7_3.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V7_3 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined LDA SRE_SWBD_combined_no_sil  adapted model & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V8 : PLDA - voxceleb_combined_1M | mean+LDA - SWBD_SRE_18_19_combined | adaptation - SWBD_SRE_18_19_combined | centering - SWBD_SRE_18_19_combined
if [ $stage -eq 121 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA voxceleb_combined_1M LDA SWBD_SRE_18_19_combined  adapted model & centering - SWBD_SRE_18_19_combined "
  $train_cmd exp/scores/log/sre20_eval_scores_V8.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/plda_adapt_8k_voxceleb_combined_1M - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V8 || exit 1;
  echo "FINISHED scoring sre20 eval - Fv_skip - PLDA voxceleb_combined_1M LDA SWBD_SRE_18_19_combined  adapted model & centering - SWBD_SRE_18_19_combined "
fi

# V9 : PLDA - SWBD_SRE_18_19_combined | LDA - SWBD_SRE_18_19_combined | adaptation - SRE_18_19_combined | centering - SRE_18_19_combined
if [ $stage -eq 122 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SWBD_SRE_18_19_combined LDA SWBD_SRE_18_19_combined  adapted model & centering - SRE_18_19_combined "
  $train_cmd exp/scores/log/sre20_eval_scores_V9.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_18_19_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V9 || exit 1;
  echo "FINISHED scoring sre20 eval - Fv_skip - PLDA SWBD_SRE_18_19_combined LDA SWBD_SRE_18_19_combined  adapted model & centering - SRE_18_19_combined "
fi

# V10 : PLDA - SWBD_SRE_18_19_combined | LDA - SWBD_SRE_combined | adaptation - SRE_18_19_combined | centering - SRE_18_19_combined
if [ $stage -eq 123 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SWBD_SRE_18_19_combined LDA SWBD_SRE_combined  adapted model & centering - SRE_18_19_combined "
  $train_cmd exp/scores/log/sre20_eval_scores_V9.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_swbdsre_adapt_8k_swbd_sre_18_19_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V10 || exit 1;
  echo "FINISHED scoring sre20 eval - Fv_skip - PLDA SWBD_SRE_18_19_combined LDA SWBD_SRE_combined  adapted model & centering - SRE_18_19_combined "
fi

# V11 : PLDA - SWBD_SRE_combined | LDA - SWBD_SRE_18_19_combined | adaptation - SRE_18_19_combined | centering - SRE_18_19_combined
if [ $stage -eq 124 ]; then
  # Get results
  echo "STARTING scoring sre20 eval - Fv_skip - PLDA SWBD_SRE_combined LDA SWBD_SRE_18_19_combined  adapted model & centering - SRE_18_19_combined "
  $train_cmd exp/scores/log/sre20_eval_scores_V9.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_lda_swbdsre1819_adapt_8k_swbd_sre_combined - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V11 || exit 1;
  echo "FINISHED scoring sre20 eval - Fv_skip - PLDA SWBD_SRE_combined LDA SWBD_SRE_18_19_combined  adapted model & centering - SRE_18_19_combined "
fi

# V11_2 : PLDA - SWBD_SRE_combined_no_sil | LDA - SWBD_SRE_18_19_combined_no_sil | adaptation - SRE_18_19_combined_no_sil | centering - SRE_18_19_combined_no_sil
if [ $stage -eq 125 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA SWBD_SRE_combined LDA SWBD_SRE_18_19_combined_no_sil  adapted model & centering - SRE_18_19_combined_no_sil "
  $train_cmd exp/scores/log/sre20_eval_scores_V11.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_swbdsre1819_adapt_8k_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V11_2 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA SWBD_SRE_combined LDA SWBD_SRE_18_19_combined_no_sil  adapted model & centering - SRE_18_19_combined_no_sil "
fi

# V12 : PLDA - SWBD_SRE_combined_no_sil | mean+LDA - SWBD_SRE_combined_no_sil | adaptation - SRE18_19_full_combined_SP09_no_sil
if [ $stage -eq 126 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined_no_sil LDA SRE_SWBD_combined_no_sil  adapted model - SRE18_19_full_combined_SP09_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V12_2.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_SP09_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V12_2 || exit 1;
  echo "FINISHED scoring eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined_no_sil LDA SRE_SWBD_combined_no_sil  adapted model - SRE18_19_full_combined_SP09_no_sil_Fv_skip_8k"
fi

# V13 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | mean+LDA - VOX_SWBD_SRE_combined_1M_no_sil | adaptation - SRE18_19_full_combined_no_sil
if [ $stage -eq 127 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA VOX_SWBD_SRE_combined_1M_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V13.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V13 || exit 1;
  echo "FINISHED scoring eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA VOX_SWBD_SRE_combined_1M_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V14 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - VOX_SWBD_SRE_combined_1M_no_sil | adaptation & centering- SRE18_19_full_combined_no_sil
if [ $stage -eq 128 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V14.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V14 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V15 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - VOX_SWBD_SRE_combined_1M_no_sil | adaptation & centering & whitening- SRE18_19_full_combined_no_sil
if [ $stage -eq 129 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering & whitening - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V15.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_whitsre1819combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V15 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering & whitening - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V16 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - SRE18_19_full_combined_no_sil | adaptation & centering & whitening- SRE18_19_full_combined_no_sil
if [ $stage -eq 130 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA SRE18_19_full_combined_no_sil  adaptation & centering & whitening - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V16.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_8k_vox_swbd_sre_combined_1M_ldawhitsre1819combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAsre1819combined_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/LDAsre1819combined_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V16 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA SRE18_19_full_combined_no_sil  adaptation & centering & whitening - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V17 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - VOX_SWBD_SRE_combined_1M_no_sil | whitening - VOX_SWBD_SRE_combined_1M_no_sil | adaptation & centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 131 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V17.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_whitevoxswbdsre_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V17 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V17_cal_validation : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - VOX_SWBD_SRE_combined_1M_no_sil | whitening - VOX_SWBD_SRE_combined_1M_no_sil | adaptation & centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 132 ]; then
  # Get results
  echo "STARTING scoring sre20 val_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V17.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_enrollment_val_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_whitevoxswbdsre_nosil - |" \
    "ark:ivector-mean ark:data/sre20_enrollment_val_no_sil/spk2utt scp:exp/xvectors_sre20_enrollment_val_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_test_val_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials_cal' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_dev_cal_scores_V17 || exit 1;
  echo "FINISHED scoring sre20 val_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V_E_17 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - VOX_SWBD_SRE_combined_1M_no_sil | whitening - VOX_SWBD_SRE_combined_1M_no_sil | adaptation & centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 132 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - E1 - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_E1_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V17.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_E1_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_whitevoxswbdsre_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_E1_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_E1_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_E1_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_E1_8k/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/ETDNN_voxswbdsre/sre20_eval_scores_V_E_17 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - E1 - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_E1_8k"
fi

# V18 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil_coraltransformed | LDA - VOX_SWBD_SRE_combined_1M_no_sil_coraltransformed | whitening - VOX_SWBD_SRE_combined_1M_no_sil_coraltransformed |CORAL - SRE18_19_full_combined_no_sil | adaptation & centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 132 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil_coraltransformed LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil_coraltransformed  CORAL & adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V18.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_vox_swbd_sre_combined_1M_coraltransformed_whitevoxswbdsre_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/transform.mat ark:- ark:- | transform-vec exp/xvectors_vox_swbd_sre_combined_1M_no_sil_Fv_skip_8k_coraltransformed/LDAvoxswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V18 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening VOX_SWBD_SRE_combined_1M_no_sil_coraltransformed  CORAL & adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V19 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - swbd_sre_combined_no_sil | adaptation & centering- swbd_sre_combined_no_sil
if [ $stage -eq 133 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V19.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_lda_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V19 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V19_sre20_test : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - swbd_sre_combined_no_sil | adaptation & centering- swbd_sre_combined_no_sil
if [ $stage -eq 134 ]; then
  # Get results
  echo "STARTING scoring sre20 test_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V19_test.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre18_unlabeled_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_lda_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre18_unlabeled_no_sil/spk2utt scp:exp/xvectors_sre18_unlabeled_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_test_sre18unlabeled_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V19_test || exit 1;
  echo "FINISHED scoring sre20 test_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V19_sre20_enroll : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - swbd_sre_combined_no_sil | adaptation & centering- swbd_sre_combined_no_sil
if [ $stage -eq 135 ]; then
  # Get results
  echo "STARTING scoring sre20 enroll_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V19_enroll.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_lda_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre18_unlabeled_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_enroll_sre18unlabeled_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V19_enroll || exit 1;
  echo "FINISHED scoring sre20 enroll_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi


# V20 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - swbd_sre_18_19_combined_no_sil | adaptation & centering- swbd_sre_18_19_combined_no_sil
if [ $stage -eq 136 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_18_19_combined_no_sil  adaptation & centering - swbd_sre_18_19_combined_no_sil"
  $train_cmd exp/scores/log/sre20_eval_scores_V20.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_lda_swbd_sre_18_19_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_18_19_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V20 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA swbd_sre_18_19_combined_no_sil  adaptation & centering - swbd_sre_18_19_combined_no_sil"
fi

# V21 : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - SWBD_SRE_combined_no_sil | whitening - SWBD_SRE_combined_no_sil | adaptation & centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 137 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening SWBD_SRE_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V21.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_ldawhite_swbdsre_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/LDAswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/LDAswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V21 || exit 1;
  echo "FINISHED scoring sre20 eval_no_sil - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening SWBD_SRE_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V21_cal_valaidation : PLDA - VOX_SWBD_SRE_combined_1M_no_sil | LDA - SWBD_SRE_combined_no_sil | whitening - SWBD_SRE_combined_no_sil | adaptation & centering - SRE18_19_full_combined_no_sil
if [ $stage -eq 138 ]; then
  # Get results
  echo "STARTING scoring sre20 val_no_sil for calibration - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening SWBD_SRE_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_val_V21.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_enrollment_val_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_adapt_vox_swbd_sre_combined_1M_ldawhite_swbdsre_nosil - |" \
    "ark:ivector-mean ark:data/sre20_enrollment_val_no_sil/spk2utt scp:exp/xvectors_sre20_enrollment_val_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/LDAswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_test_val_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/LDAswbdsre_whiten.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials_cal' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_dev_cal_scores_V21 || exit 1;
  echo "FINISHED scoring sre20 enrollment_val_no_sil for calibration - Fv_skip - PLDA VOX_SWBD_SRE_combined_1M_no_sil LDA & whitening SWBD_SRE_combined_no_sil  adaptation & centering - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi

# V22 : PLDA - SWBD_SRE_LRE_combined_no_sil | mean+LDA - SWBD_SRE_LRE_combined_no_sil | adaptation - SRE18_19_full_combined_no_sil
if [ $stage -eq 139 ]; then
  # Get results
  echo "STARTING scoring sre20 eval_no_sil - Fv_skip - PLDA swbd_sre_lre_combined_no_sil LDA swbd_sre_lre_combined_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V22.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_lre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt scp:exp/xvectors_sre20_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre20_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_lre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre20_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/sre20_eval_scores_V22 || exit 1;
  echo "FINISHED scoring eval_no_sil - Fv_skip - PLDA swbd_sre_lre_combined_no_sil LDA swbd_sre_lre_combined_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi
########################### Convert scoring + Normalization SRE20 #############################################
#if [ $stage -eq 140 ]; then
#  # Convert the score file to ".tsv" scoring software format and copy it to the scoring software output folder
#  echo "STARTING convert the score file"
#  convert_scores.sh exp/scores/ETDNN_voxswbdsre/sre20_eval_scores_V_E_17 ${scoring_software_output_path}/SRE20 sre20_eval_scores_V_E_17
#  echo "FINISHED convert the score file"
#fi

if [ $stage -eq 140 ]; then
  # Convert the score file to ".tsv" scoring software format and copy it to the scoring software output folder
  echo "STARTING convert the score file"
  convert_scores.sh exp/scores/FTDNN_skip_voxceleb/sre20_dev_cal_scores_V17 ${scoring_software_output_path}/SRE20 sre20_dev_cal_scores_V17
  echo "FINISHED convert the score file"
fi

if [ $stage -eq 140 ]; then
  # Apply AS-NORM on the scores
  #scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software/system_output
  echo "Starting AS-NORM on scores file"
  python3 ${scoring_software_output_path}/as_norm.py ${scoring_software_output_path}/SRE20/sre20_dev_cal_scores_V17.tsv
  echo "Finished AS-NORM on scores file"
fi
exit 1
if [ $stage -eq 141 ]; then
  # Scoring the dev calibration set using the scoring software
  echo "Starting scoring using SRE scoring_software"
  run_scoring_sre20_dev.sh SRE20/sre20_dev_cal_scores_V21_ASnorm_nosph.tsv
fi
exit 1
############################ Scoring of SRE19 data sets for fusion uses #################################
# V2 : PLDA - voxceleb_combined_1M | mean+LDA - SRE18_19_full_combined | adaptation - SRE18_19_full_combined
if [ $stage -eq 200 ]; then
  # Get results.
  echo "STARTING scoring sre19 eval - Fv_skip - PLDA voxceleb_combined_1M adapted model - SRE18_19_full_combined_Fv_skip_8k"
  $train_cmd exp/scores/log/sre20_eval_scores_V2.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre19_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_Fv_skip_8k/plda_adapt_8k_voxceleb_combined_1M - |" \
    "ark:ivector-mean ark:data/sre19_eval_enroll/spk2utt scp:exp/xvectors_sre19_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_19_full_combined_Fv_skip_8k/mean.vec scp:exp/xvectors_sre19_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_19_full_combined_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre19_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/SRE19_fusion/sre19_eval_scores_V2 || exit 1;
  echo "FINISHED scoring sre19 eval - Fv_skip - PLDA voxceleb_combined_1M adapted model - SRE18_19_full_combined_Fv_skip_8k"
fi

# V5_3 : PLDA - SWBD_SRE_combined_no_sil | mean+LDA - SWBD_SRE_combined_no_sil | adaptation - SRE18_19_full_combined_no_sil
if [ $stage -eq 201 ]; then
  # Get results
  echo "STARTING scoring sre19 eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined_no_sil LDA SRE_SWBD_combined_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
  $train_cmd exp/scores/log/sre19_eval_scores_V5_3.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre19_eval_enroll_no_sil_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_19_full_combined_no_sil_Fv_skip_8k/plda_lda_adapt_8k_swbd_sre_combined_nosil - |" \
    "ark:ivector-mean ark:data/sre19_eval_enroll/spk2utt scp:exp/xvectors_sre19_eval_enroll_no_sil_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/mean.vec ark:- ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/mean.vec scp:exp/xvectors_sre19_eval_test_no_sil_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_swbd_sre_combined_no_sil_Fv_skip_8k/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre19_trials' | cut -d\  --fields=1,2 |" exp/scores/FTDNN_skip_voxceleb/SRE19_fusion/sre19_eval_scores_V5_3 || exit 1;
  echo "FINISHED scoring eval_no_sil - Fv_skip - PLDA SRE_SWBD_combined_no_sil LDA SRE_SWBD_combined_no_sil  adapted model - SRE18_19_full_combined_no_sil_Fv_skip_8k"
fi



