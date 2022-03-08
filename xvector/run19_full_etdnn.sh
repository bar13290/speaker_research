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
# storage_2 - data , storage_4TSSD - kaldi

. cmd.sh
. path.sh
set -e
mfccdir=`pwd`/mfcc
vaddir=`pwd`/mfcc

#trials
sre19_trials=data/sre19_eval_test/trials
#net
nnet_dir=exp/xvector_nnet_FTDNN_skip_voxceleb_8k
#data
data_root=/common_space_docker/storage_2
scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software20/system_output
scoring_software_path=/common_space_docker/storage_4TSSD/scoring_software20
stage=444
export CUDA_VISIBLE_DEVICES=0,1
if [ $stage -eq 100000 ]; then
 echo "TRYYYYYYYY"
 exit 1
fi


if [ $stage -eq 1 ]; then
  # Path to some, but not all of the training corpora

  # Prepare telephone and microphone speech from Mixer6.
  echo "STARTING prepare mx6 - LDC2013S03"
  local/make_mx6.sh $data_root/TDNN_train/LDC2013S03 data/
  echo "FINISHED prepare mx6 - LDC2013S03"

  # Prepare SRE10 test and enroll. Includes microphone interview speech.
  # NOTE: This corpus is now available through the LDC as LDC2017S06.
  echo "STARTING prepare SRE10 eval - LDC2017S06"
  local/make_sre10.pl $data_root/TDNN_train/LDC2017S06/eval/ data/
  echo "FINISHED prepare SRE10 eval - LDC2017S06"

  # Prepare SRE08 test and enroll. Includes some microphone speech. -> we missed some trial files to proccess this data
  echo "STARTING prepare SRE08 test and enroll - LDC2011S08 & LDC2011S05"
  local/make_sre08.pl $data_root/TDNN_train/SRE08/LDC2011S08 $data_root/SRE08/LDC2011S05 data/
  echo "FINISHED prepare SRE08 test and enroll - LDC2011S08 & LDC2011S05"

  # This prepares the older NIST SREs from 2004-2006,2008.
  echo "STARTING prepare SRE04,SRE05,SRE06,SRE08"
  local/make_sre.sh $data_root/TDNN_train data/
  echo "FINISHED prepare SRE04,SRE05,SRE06,SRE08"
fi

if [ $stage -eq 2 ]; then
  # Prepare NIST SRE 2018 data(enrollment  test and unlabeled to adapt the PLDA) - in domain data.
  echo "STARTING prepare SRE18 eval data"
  #local/make_sre18_eval_SPH.pl $data_root/corpora5/SRE18/SRE18_eval_SPH data
  echo "FINISHED prepare SRE18 eval data"
  echo "STARTING prepare SRE18 dev data"
  local/make_sre18_dev_SPH.pl $data_root/corpora5/SRE18/LDC2018E46_SRE18_dev_SPH data
  echo "FINISHED prepare SRE18 dev data"
  echo "STARTING preparing SRE18 unlabeled data"
  #local/make_sre18_unlabeled.pl $data_root/corpora5/SRE18/LDC2018E46_2018_NIST_Speaker_Recognition_Evaluation_Development_Set data
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
fi

  # Combine all SREs (04,05,06,08,10) and Mixer6 into one dataset for TDNN training
if [ $stage -eq 4 ]; then
  echo "STARTING combine SRE (04,05,06,08,10) and MIXER06 for TDNN training"
  utils/combine_data.sh data/sre \
    data/sre2004 data/sre2005_train \
    data/sre2005_test data/sre2006_train \
    data/sre2006_test_1 data/mx6 data/sre10
  utils/validate_data_dir.sh --no-text --no-feats data/sre
  utils/fix_data_dir.sh data/sre
  echo "FINISHED combine SRE (04,05,06,08,10) and MIXER06 for TDNN training"
fi

if [ $stage -eq 5 ]; then
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

#first, we need extract mfcc and calculate VAD to the raw data
#This stage extract MFCC to the raw data - without augmentation
#after the augmentation we will extract the mfcc again but we will use the same vad calculated on the raw data
if [ $stage -eq 8 ]; then
  # Make filterbanks and compute the energy-based VAD for each dataset
  echo "STARTING making MFCC and VAD to SRE, VoxCeleb, SWBD, SRE18 data set"
#  for name in sre voxceleb swbd sre18_full sre19_eval_enroll sre19_eval_test sre ; do #apply just while building the whole data (include the train data)
  for name in sre18_full ; do
   echo "!!!!!!!!STARTING MFCC for ${name} data set!!!!!!!!!!"
    steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --nj 40 --cmd "$train_cmd" \
      data/${name} exp/make_mfcc $mfccdir
    utils/fix_data_dir.sh data/${name}
    echo "!!!!!!!!FINISHED MFCC for ${name} data set!!!!!!!!!!"
    echo "!!!!!!!!STARTING VAD for ${name} data set!!!!!!!!!"
    sid/compute_vad_decision.sh --nj 40 --cmd "$train_cmd" \
      data/${name} exp/make_vad $vaddir
    utils/fix_data_dir.sh data/${name}
	echo "!!!!!!!!FINISHED VAD for ${name} data set!!!!!!!!!"
  done
  echo "FINISHED making MFCC and VAD for SRE18_full and data set"
fi

# In this section, we augment the SWBD and SRE and VoxCeleb data with reverberation,
# noise, music, and babble, and combined it with the clean data.
# The combined list will be used to train the xvector DNN.  The SRE
# subset will be used to train the PLDA model.
# For pretrained XVECTOR and PLDA models we will skip this step.


if [ $stage -eq 9 ]; then
  # Make a reverberated version of the SWBD+SRE list.
  if [ ! -d "RIRS_NOISES" ]; then
    # Download the package that includes the real RIRs, simulated RIRs, isotropic noises and point-source noises
    wget --no-check-certificate http://www.openslr.org/resources/28/rirs_noises.zip
    unzip rirs_noises.zip
  fi
  rvb_opts=()
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/smallroom/rir_list")
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/mediumroom/rir_list")
  echo "STARTING reverberate SWBD+SRE data"
  python3 steps/data/reverberate_data_dir.py \
    "${rvb_opts[@]}" \
    --speech-rvb-probability 1 \
    --pointsource-noise-addition-probability 0 \
    --isotropic-noise-addition-probability 0 \
    --num-replications 1 \
    --source-sampling-rate 8000 \
    data/swbd_sre data/swbd_sre_reverb
  cp data/swbd_sre/vad.scp data/swbd_sre_reverb/
  utils/copy_data_dir.sh --utt-suffix "-reverb" data/swbd_sre_reverb data/swbd_sre_reverb.new
  rm -rf data/swbd_sre_reverb
  mv data/swbd_sre_reverb.new data/swbd_sre_reverb
  echo "FINISHED reverberate SWBD+SRE data"
fi

if [ $stage -eq 10 ]; then
  # Make a reverberated version of the VoxCeleb list.
  # be aware to the diffrent between voxceleb and voxceleb_8k
  if [ ! -d "RIRS_NOISES" ]; then
    # Download the package that includes the real RIRs, simulated RIRs, isotropic noises and point-source noises
    wget --no-check-certificate http://www.openslr.org/resources/28/rirs_noises.zip
    unzip rirs_noises.zip
  fi
  rvb_opts=()
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/smallroom/rir_list")
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/mediumroom/rir_list")
  echo "STARTING reverberate voxCeleb_8k data"
  python3 steps/data/reverberate_data_dir.py \
    "${rvb_opts[@]}" \
    --speech-rvb-probability 1 \
    --pointsource-noise-addition-probability 0 \
    --isotropic-noise-addition-probability 0 \
    --num-replications 1 \
    --source-sampling-rate 8000 \
    data/voxceleb_8k data/voxceleb_8k_reverb
  cp data/voxceleb_8k/vad.scp data/voxceleb_8k_reverb/
  utils/copy_data_dir.sh --utt-suffix "-reverb" data/voxceleb_8k_reverb data/voxceleb_8k_reverb.new
  rm -rf data/voxceleb_8k_reverb
  mv data/voxceleb_8k_reverb.new data/voxceleb_8k_reverb
  echo "FINISHED reverberate voxCeleb data"
fi

if [ $stage -eq 11 ]; then
  # Make a reverberated version of the SRE18_full data.
  if [ ! -d "RIRS_NOISES" ]; then
    # Download the package that includes the real RIRs, simulated RIRs, isotropic noises and point-source noises
    wget --no-check-certificate http://www.openslr.org/resources/28/rirs_noises.zip
    unzip rirs_noises.zip
  fi
  rvb_opts=()
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/smallroom/rir_list")
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/mediumroom/rir_list")
  echo "STARTING reverberate sre18_full data"
  python3 steps/data/reverberate_data_dir.py \
    "${rvb_opts[@]}" \
    --speech-rvb-probability 1 \
    --pointsource-noise-addition-probability 0 \
    --isotropic-noise-addition-probability 0 \
    --num-replications 1 \
    --source-sampling-rate 8000 \
    data/sre18_full data/sre18_full_reverb
  cp data/sre18_full/vad.scp data/sre18_full_reverb/
  utils/copy_data_dir.sh --utt-suffix "-reverb" data/sre18_full_reverb data/sre18_full_reverb.new
  rm -rf data/sre18_full_reverb
  mv data/sre18_full_reverb.new data/sre18_full_reverb
  echo "FINISHED reverberate sre18_full data"
fi

if [ $stage -eq 12 ]; then
  # Prepare the MUSAN corpus, which consists of music, speech, and noise for additive augmentation
  echo "STARTING prepare MUSAN data - 8Khz"
  steps/data/make_musan.sh --sampling-rate 8000 $data_root/TDNN_train/musan data
  echo "FINISHED prepare MUSAN data - 8Khz"
  #echo "STARTING prepare MUSAN data - 16Khz"
  #steps/data/make_musan_16k.sh --sampling-rate 16000 $data_root/musan data
  #echo "FINISHED prepare MUSAN data - 16Khz"
fi

if [ $stage -eq 13 ]; then
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

if [ $stage -eq 11 ]; then
  echo "STARTING Augmented with MUSAN data"
  # Augment with musan_noise
  echo "STARTING Augment with musan_noise"
  python3 steps/data/augment_data_dir.py --utt-suffix "noise" --fg-interval 1 --fg-snrs "15:10:5:0" --fg-noise-dir "data/musan_noise" data/sre18_full data/sre18_full_noise
  #python3 steps/data/augment_data_dir.py --utt-suffix "noise" --fg-interval 1 --fg-snrs "15:10:5:0" --fg-noise-dir "data/musan_noise" data/voxceleb_8k data/voxceleb_8k_noise
  #python3 steps/data/augment_data_dir.py --utt-suffix "noise" --fg-interval 1 --fg-snrs "15:10:5:0" --fg-noise-dir "data/musan_noise" data/swbd_sre data/swbd_sre_noise
  echo "FINISHED Augment with musan_noise"
  # Augment with musan_music
  echo "STARTING Augment with musan_music"
  python3 steps/data/augment_data_dir.py --utt-suffix "music" --bg-snrs "15:10:8:5" --num-bg-noises "1" --bg-noise-dir "data/musan_music" data/sre18_full data/sre18_full_music
  #python3 steps/data/augment_data_dir.py --utt-suffix "music" --bg-snrs "15:10:8:5" --num-bg-noises "1" --bg-noise-dir "data/musan_music" data/voxceleb_8k data/voxceleb_8k_music
  #python3 steps/data/augment_data_dir.py --utt-suffix "music" --bg-snrs "15:10:8:5" --num-bg-noises "1" --bg-noise-dir "data/musan_music" data/swbd_sre data/swbd_sre_music
  echo "FINISHED Augment with musan_music"
  # Augment with musan_speech
  echo "STARTING Augment with musan_speech"
  python3 steps/data/augment_data_dir.py --utt-suffix "babble" --bg-snrs "20:17:15:13" --num-bg-noises "3:4:5:6:7" --bg-noise-dir "data/musan_speech" data/sre18_full data/sre18_full_babble
  #python3 steps/data/augment_data_dir.py --utt-suffix "babble" --bg-snrs "20:17:15:13" --num-bg-noises "3:4:5:6:7" --bg-noise-dir "data/musan_speech" data/voxceleb_8k data/voxceleb_8k_babble
  #python3 steps/data/augment_data_dir.py --utt-suffix "babble" --bg-snrs "20:17:15:13" --num-bg-noises "3:4:5:6:7" --bg-noise-dir "data/musan_speech" data/swbd_sre data/swbd_sre_babble
  echo "FINISHED Augment with musan_speech"
  echo "FINISHED Augmented with MUSAN data"
fi

if [ $stage -eq 11 ]; then
  #in total 63132 utterances
  echo "STARTING combine all the SRE18 reverb, noise,music and babble on the same directory(for the PLDA adaptation"
   # Combine reverb, noise, music, and babble into one directory.
  utils/combine_data.sh data/sre18_full_aug data/sre18_full_reverb data/sre18_full_noise data/sre18_full_music data/sre18_full_babble
  utils/fix_data_dir.sh data/sre18_full_aug
  echo "FINISHED combine all the Voxceleb reverb, noise,music and babble on the same directory - sre18_full_aug"
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
  #in total X utterances
  echo "STARTING combine all the swbd_sre reverb, noise,music and babble on the same directory"
   # Combine reverb, noise, music, and babble into one directory.
  utils/combine_data.sh data/swbd_sre_aug data/swbd_sre_reverb data/swbd_sre_noise data/swbd_sre_music data/swbd_sre_babble
  utils/fix_data_dir.sh data/swbd_sre_aug
  echo "FINISHED combine all the swbd_sre reverb, noise,music and babble on the same directory - swbd_sre_aug"
fi

if [ $stage -eq 19 ]; then
  # Make filterbanks MFCC for the voxceleb augmented data.  Note that we do not compute a new
  # vad.scp file here.  Instead, we use the vad.scp from the clean version of the list.
  echo "STARTING extract MFCC to the voxceleb_8k augmented data "
  steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --nj 40 --cmd "$train_cmd" \
    data/voxceleb_8k_aug exp/make_mfcc $mfccdir
  echo "FINISHED extract MFCC to the voxceleb augmented data "
fi

if [ $stage -eq 11 ]; then
  # Make filterbanks MFCC for the SRE18_full augmented data.  Note that we do not compute a new
  # vad.scp file here.  Instead, we use the vad.scp from the clean version of
  # the list.
  echo "STARTING extract MFCC to the augmented data (random subset of ~1300k)"
  steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --nj 40 --cmd "$train_cmd" \
    data/sre18_full_aug exp/make_mfcc $mfccdir
  echo "FINISHED extract MFCC to the augmented data (random subset of ~1300k)"
fi

if [ $stage -eq 11 ]; then
  # Combine the clean and augmented voxceleb and SRE_full list.
  # This is now multiply by 5 the size of the original clean list.
  echo "STARTING combined the voxceleb_8k clean and augmented data"
  #utils/combine_data.sh data/voxceleb_8k_combined data/voxceleb_8k_aug data/voxceleb_8k
  echo "FINISHED combined the voxceleb_8k clean and augmented data"
  echo "STARTING combined the sre18_full clean and augmented data"
  utils/combine_data.sh data/sre18_full_combined data/sre18_full_aug data/sre18_full
  utils/fix_data_dir.sh data/sre18_full_combined
  echo "FINISHED combined the sre18_full clean and augmented data"
  #echo "STARTING create a random subset of the voxceleb_combined unlabeled(500k) - for PLDA training"
  #utils/subset_data_dir.sh data/voxceleb_combined 500000 data/voxceleb_combined_500k
  #utils/fix_data_dir.sh data/voxceleb_combined_500k
  #echo "FINISHED create a random subset of the augmentations (500k)"
fi

if [ $stage -eq 22 ]; then
  # Make filterbanks MFCC for the voxceleb augmented data.  Note that we do not compute a new
  # vad.scp file here.  Instead, we use the vad.scp from the clean version of
  # the list.
  echo "STARTING extract MFCC to the voxceleb_8k combined data "
  steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --nj 40 --cmd "$train_cmd" \
    data/voxceleb_8k_combined exp/make_mfcc $mfccdir
  echo "FINISHED extract MFCC to the voxceleb_8k combined data "
fi

if [ $stage -eq 23 ]; then
  # Make filterbanks MFCC for the sre18 full combined data.  Note that we do not compute a new
  # vad.scp file here.  Instead, we use the vad.scp from the clean version of
  # the list.
  echo "STARTING extract MFCC to the sre18_full combined data "
  steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --nj 40 --cmd "$train_cmd" \
    data/sre18_full_combined exp/make_mfcc $mfccdir
  echo "FINISHED extract MFCC to the sre18_full combined data "
fi

if [ $stage -eq 24 ]; then
  # This script applies CMVN and removes nonspeech frames.  Note that this is somewhat
  # wasteful, as it roughly doubles the amount of training data on disk.  After
  # creating training examples, this can be removed.
  echo "STARTING applies sliding window and cmvn and remove silent frames - for the TDNN train"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" \
    data/voxceleb_8k_combined data/voxceleb_8k_combined_no_sil exp/voxceleb_8k_combined_no_sil
  utils/fix_data_dir.sh data/voxceleb_8k_combined_no_sil
  echo "FINISHED applies sliding window and cmvn and remove silent frames"
  echo "STARTING calculate number of frames of each utterance"
  utils/data/get_utt2num_frames.sh --nj 40 --cmd "$train_cmd" data/voxceleb_8k_combined_no_sil
  utils/fix_data_dir.sh data/voxceleb_8k_combined_no_sil
  echo "FINISHED calculate number of frames of each utterance"
fi

if [ $stage -eq 25 ]; then
  # Now, we need to remove features that are too short after removing silence
  # frames.  We want at least 4s (400 frames) per utterance.
  echo "STARTING remove features that are to short"
  min_len=400
  mv data/voxceleb_8k_combined_no_sil/utt2num_frames data/voxceleb_8k_combined_no_sil/utt2num_frames.bak
  awk -v min_len=${min_len} '$2 > min_len {print $1, $2}' data/voxceleb_8k_combined_no_sil/utt2num_frames.bak > data/voxceleb_8k_combined_no_sil/utt2num_frames
  utils/filter_scp.pl data/voxceleb_8k_combined_no_sil/utt2num_frames data/voxceleb_8k_combined_no_sil/utt2spk > data/voxceleb_8k_combined_no_sil/utt2spk.new
  mv data/voxceleb_8k_combined_no_sil/utt2spk.new data/voxceleb_8k_combined_no_sil/utt2spk
  utils/fix_data_dir.sh data/voxceleb_8k_combined_no_sil
  echo "FINISHED remove features that are to short"
fi

if [ $stage -eq 26 ]; then
  # We also want several utterances per speaker. Now we'll throw out speakers
  # with fewer than 8 utterances.
  echo "STARTING remove speakers with fewer than 8 utterance"
  min_num_utts=8
  awk '{print $1, NF-1}' data/voxceleb_8k_combined_no_sil/spk2utt > data/voxceleb_8k_combined_no_sil/spk2num
  awk -v min_num_utts=${min_num_utts} '$2 >= min_num_utts {print $1, $2}' data/voxceleb_8k_combined_no_sil/spk2num | utils/filter_scp.pl - data/voxceleb_8k_combined_no_sil/spk2utt > data/voxceleb_8k_combined_no_sil/spk2utt.new
  mv data/voxceleb_8k_combined_no_sil/spk2utt.new data/voxceleb_8k_combined_no_sil/spk2utt
  utils/spk2utt_to_utt2spk.pl data/voxceleb_8k_combined_no_sil/spk2utt > data/voxceleb_8k_combined_no_sil/utt2spk

  utils/filter_scp.pl data/voxceleb_8k_combined_no_sil/utt2spk data/voxceleb_8k_combined_no_sil/utt2num_frames > data/voxceleb_8k_combined_no_sil/utt2num_frames.new
  mv data/voxceleb_8k_combined_no_sil/utt2num_frames.new data/voxceleb_8k_combined_no_sil/utt2num_frames

  # Now we're ready to create training examples.
  utils/fix_data_dir.sh data/voxceleb_8k_combined_no_sil
  echo "FINISHED remove speakers with fewer than 8 utterance"
fi

#stages 27,28 is needed just if we augmented all the voxceleb and sre and swbd together and than filter the voxcelep portion
if [ $stage -eq 27 ]; then
  # Filter out the clean + augmented portion of the SRE+MX6 list.  This will be used to
  # train the PLDA model later in the script.
  echo "STARTING to filter the clean and augmented sre data and create sre_combined directory - for PLDA training"
  cp -r data/swbd_voxceleb_sre_combined data/sre_combined
  utils/filter_scp.pl data/sre/spk2utt data/swbd_voxceleb_sre_combined/spk2utt | utils/spk2utt_to_utt2spk.pl > data/sre_combined/utt2spk
  utils/fix_data_dir.sh data/sre_combined
  echo "FINISHED to filter the clean and augmented sre data and create sre_combined directory"
fi

if [ $stage -eq 28 ]; then
  echo "STARTING to filter the clean and augmented voxceleb data and create voxceleb_combined directory"
  cp -r data/swbd_voxceleb_sre_combined data/voxceleb_combined
  utils/filter_scp.pl data/voxceleb/spk2utt data/swbd_voxceleb_sre_combined/spk2utt | utils/spk2utt_to_utt2spk.pl > data/voxceleb_combined/utt2spk
  utils/fix_data_dir.sh data/voxceleb_combined
  echo "FINISHED to filter the clean and augmented sre data and create voxceleb_combined directory"
fi

if [ $stage -eq 29 ]; then
# Now we are training the net with all the combined data using the run_xvector.sh script with the extended architecture
#4226180 utterances
  echo "STARTING train the F-Extended network for the X-VECTOR with voxceleb_8k_combined_no_sil"
  local/nnet3/xvector/run_xvector_FTDNN_skip.sh --stage 6 --train-stage -1 \
  --data data/voxceleb_8k_combined_no_sil --nnet-dir $nnet_dir \
  --egs-dir $nnet_dir/egs
  echo "FINISHED train the F-Extended network for the X-VECTOR with voxceleb_8k_combined_no_sil"
fi

if [ $stage -eq 30 ]; then
  # The SRE19 test data
  echo "STARTING extract X_VECTOR for sre19_test"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 16G" --nj 40 \
    $nnet_dir data/sre18_eval_test \
    exp/xvectors_sre18_eval_test_E_8k
  echo "FINISHED extract X_VECTOR for sre19_test"
  # The SRE19 enroll data
  echo "STARTING extract X_VECTOR for sre19_enroll"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 16G" --nj 40 \
    $nnet_dir data/sre18_eval_enroll \
    exp/xvectors_sre18_eval_enroll_E_8k
  echo "FINISHED extract X_VECTOR for sre19_enroll"
fi

if [ $stage -eq 31 ]; then
  # The SRE18_full_combined is a combination  of clean+augmented sre18 - tunisian and
  # arabic, as the eval data.This is useful for things like centering, whitening and
  # score normalization. we will use it to adapt the PLDA
  echo "STARTING extract X_VECTOR for sre18_full_combined"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 6G" --nj 40 --use-gpu false \
    $nnet_dir data/sre18_full_combined \
    exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev
  echo "FINISHED extract X_VECTOR for sre18_full_combined"
fi

if [ $stage -eq 31 ]; then
  # Compute the mean vector of the x-vectors in-domain data for centering the evaluation xvectors.
  echo "Compute the mean vector for centering the evaluation xvectors"
  $train_cmd exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/log/compute_mean.log \
    ivector-mean scp:exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/xvector.scp \
    exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/mean.vec || exit 1;
  echo "FINISHED compute mean vector for sre18_full_combined_Fv3_8k"
fi

#choose stage 33,34 for train the PLDA with portion of the voxceleb_combined set

#skip this stage if we train the plda with the raw voxceleb data
if [ $stage -eq 3333 ]; then
  echo "STARTING create a random subset of the voxceleb_combined (1M) - for PLDA training"
  utils/subset_data_dir.sh data/voxceleb_8k_combined 1000000 data/voxceleb_8k_combined_PLDA_1M
  utils/fix_data_dir.sh data/voxceleb_8k_combined_PLDA_1M
  echo "FINISHED create a random subset of the voxceleb_combined (1M)"
fi

if [ $stage -eq 34 ]; then
# Extract xvectors for voxceleb combined to train the PLDA. We'll use this for
# things like LDA or PLDA.
  echo "STARTING extract X_VECTOR for voxceleb_combined for training the PLDA"
  sid/nnet3/xvector/extract_xvectors.sh --cmd "$train_cmd --mem 12G" --nj 40 \
    $nnet_dir data/voxceleb_8k_combined_PLDA_1M \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k
  echo "FINISHED extract X_VECTOR for voxceleb_8k_combined - raw data with augmentation for training the PLDA"
fi

# here is good
#### Here we calculate the LDA of the in-domain data and use it to train the PLDA
if [ $stage -eq 31 ]; then
  # This script uses LDA to decrease the dimensionality prior to the data that train the PLDA.
  echo "STARTING LDA for the sre18_full_combined_Fv_skip_8k_includedev data"
  lda_dim=250
  $train_cmd exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/log/lda.log \
    ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/xvector.scp ark:- |" \
    ark:data/sre18_full_combined/utt2spk exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/transform.mat || exit 1;
  echo "FINISHED LDA for the sre18_full_combined_Fv3_8k_includedev data"
fi

if [ $stage -eq 31 ]; then
  # Train an out-of-domain PLDA model(voxceleb combined data)
  # Using LDA of in-domain data (SRE18).
  echo "STARTING to train an out-of-domain PLDA model"
  $train_cmd exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/log/plda_includedev.log \
    ivector-compute-plda ark:data/voxceleb_8k_combined_PLDA_1M/spk2utt \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_includedev || exit 1;
  echo "FINISHED to train an out-of-domain PLDA model"
fi

if [ $stage -eq 31 ]; then
  # Here we adapt the out-of-domain PLDA (Using the SRE18 LDA) model to SRE18_full_combined
  echo "STARTING adapt the out of domain PLDA model with xvectors_sre18_full_combined_Fv_skip_8k_includedev"
  $train_cmd exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    exp/xvectors_voxceleb_8k_combined_PLDA_1M_Fv_skip_8k/plda_includedev \
    "ark:ivector-subtract-global-mean scp:exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/xvector.scp ark:- | transform-vec exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/plda_adapt_8k_combined_1M || exit 1;
  echo "FINISHED adapted the out of domain PLDA model with xvectors_sre18_full_combined_Fv_skip_8k"
fi

#important to understand
if [ $stage -eq 31 ]; then
  # Get results using the adapted PLDA model - SRE18 full_combined_Fv_skip_8k.
  echo "STARTING scoring sre19 eval - Fv_skip - adapted model - SRE18 full_combined_Fv_skip_8k_includedev"
  $train_cmd exp/scores/log/sre19_eval_scoring_adapt_Fv_skip_8k_includedev.log \
    ivector-plda-scoring --normalize-length=true \
    --num-utts=ark:exp/xvectors_sre19_eval_enroll_Fv_skip_8k/num_utts.ark \
    "ivector-copy-plda --smoothing=0.0 exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/plda_adapt_8k_combined_1M - |" \
    "ark:ivector-mean ark:data/sre19_eval_enroll/spk2utt scp:exp/xvectors_sre19_eval_enroll_Fv_skip_8k/xvector.scp ark:- | ivector-subtract-global-mean exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/mean.vec ark:- ark:- | transform-vec exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "ark:ivector-subtract-global-mean exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/mean.vec scp:exp/xvectors_sre19_eval_test_Fv_skip_8k/xvector.scp ark:- | transform-vec exp/xvectors_sre18_full_combined_Fv_skip_8k_includedev/transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    "cat '$sre19_trials' | cut -d\  --fields=1,2 |" exp/scores/sre19_eval_scores_adapt_Fv_skip_8k_includedev || exit 1;
  echo "FINISHED scoring sre19 eval - Fv3 - adapted model - sre18_full_combined_Fv_skip_8k"
fi

if [ $stage -eq 31 ]; then
  # Convert the score file to ".tsv" scoring software format and copy it to the scoring software output folder
  echo "STARTING convert the score file"
  convert_scores.sh exp/scores/sre19_eval_scores_adapt_Fv_skip_8k_includedev ${scoring_software_output_path} sre19_eval_scores_adapt_Fv_skip_8k_includedev
  echo "FINISHED convert the score file"
fi

if [ $stage -eq 333 ]; then
  # Apply AS-NORM on the scores
  #scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software/system_output
  echo "Starting AS-NORM on scores file"
  python3 ${scoring_software_output_path}/as_norm.py ${scoring_software_output_path}/sre19_eval_scores_adapt_Fv_skip_8k.tsv
  echo "Finished AS-NORM on scores file"
fi

if [ $stage -eq 444 ]; then
  # Scoring using the scoring software
  echo "Starting scoring using SRE scoring_software"
  run_scoring.sh sre19_eval_scores_adapt_center_E_8k_norm.tsv
fi
exit 1
if [ $stage -eq 1000 ]; then
  # Plotting using the scoring software
  echo "Starting Plotting using SRE scoring_software"
  python3 ${scoring_software_path}/plot_det_curve.py \
   -o ${scoring_software_output_path}/sre19_eval_scores_adapt_Fv_skip_8k.tsv \
   -o ${scoring_software_output_path}/sre19_eval_scores_adapt_Fv_skip_8k_norm.tsv \
   -o ${scoring_software_output_path}/sre19_eval_scores_adapt_Fv_skip_8k_ASnorm.tsv \
   -l ${scoring_software_output_path}/sre19_cts_challenge_trials.tsv \
   -r ${scoring_software_output_path}/sre19_cts_challenge_trial_key.tsv
   #-o ${scoring_software_output_path}/sre19_eval_scores_adapt_Fv3_8k_ASnorm.tsv \
   #-o ${scoring_software_output_path}/sre19_eval_scores_adapt_Fv_skip_8k_ASnorm.tsv \
   #-o ${scoring_software_output_path}/sre19_fuse_5.tsv \
fi
exit 1

  #  exp/scores/sre19_eval_scores_adapt_center_E_8k_2 - LDA-SRE18_full_combined, ETDNN_voxceleb_8k
  #  EER:          6.32
  #  min_Cprimary: 0.487
  #  act_Cprimary:

  #  exp/scores/sre19_eval_scores_adapt_Fv3_8k - LDA-SRE18_full_combined, FTDNN_voxceleb_8k - 3 epoch
  #  EER:          6.11
  #  min_Cprimary: 0.463
  #  act_Cprimary:


  #  exp/scores/sre19_eval_scores_adapt_Fv_skip_8k - LDA-SRE18_full_combined, FTDNN_skip_voxceleb_8k - 3 epoch
  #  EER:           5.81
  #  min_Cprimary:  0.460
  #  act_Cprimary: