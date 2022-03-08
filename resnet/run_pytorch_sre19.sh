#!/bin/bash

# Author: Nanxin Chen, Cheng-I Lai
# Pipeline for preprocessing + training + postprocessing neural speaker embeddings. This includes:
# step 0:  create VoxCeleb1+2 data directories
# step 1:  make FBanks + VADs (based on MFCCs) for clean data
# step 2:  data augmentation
# step 3:  make FBanks for noisy data
# step 4:  applies CM and removes silence (for training data)
# step 5:  filter by length, split to train/cv, and (optional) save as pytorch tensors
# step 6:  nn training
# step 7:  applies CM and removes silence (for decoding data)
# step 8:  decode with the trained nn
# step 9:  get train and test embeddings
# step 10: compute mean, LDA and PLDA on decode embeddings
# step 11: scoring
# step 12: EER & minDCF results
# (This script is modified from Kaldi egs/)


# VR_1 -SRE20 xvectors extracted from "resnet34_m3_1024_mean+std_lde_sqr"
#     LDA - swbd_sre_combined_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.40  0.153   0.336

# VR_2 -SRE20 xvectors extracted from "resnet34_m4_512_mean+std_lde_sqr"
#     LDA - swbd_sre_combined_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
#     3.47  0.168   0.367


. ./cmd.sh
. ./path.sh
set -e

mfccdir=`pwd`/mfcc
vaddir=`pwd`/mfcc
fbankdir=`pwd`/fbank

# Change this to your Kaldi voxceleb egs directory
kaldi_voxceleb=/opt/kaldi/egs/voxceleb
data_root=/common_space_docker/storage_2
scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software20/system_output
scoring_software_path=/common_space_docker/storage_4TSSD/scoring_software20
musan_root=/common_space_docker/storage_2/TDNN_train/musan
sre19_trials=data/sre19_eval_test/trials
sre20_trials=data/sre20_eval_test/trials
sre20_trials_val=data/sre20_test_val/trials
#num_utts_sre19_eval_enroll=/common_space_docker/storage_4TSSD/kaldi/egs/sre16/v2_SRE19_full_train/exp/xvectors_sre19_eval_enroll_Fv_skip_8k/num_utts.ark
NOW=$(date +"Starting on %m-%d-%y at %T")

#experiment path
expname=sre19_resnet34_m4_512_mean+std_lde_sqr
#expname=sre19_resnet34_m3_1024_mean+std_lde_sqr
#expname=sre19_resnet34_m4_2048_mean+std_lde_sqr


export CUDA_VISIBLE_DEVICES=0,1
stage=200

if [ $stage -eq -1 ]; then
    # link necessary Kaldi directories
    rm -fr utils steps sid
    ln -s $kaldi_voxceleb/v2/utils ./
    ln -s $kaldi_voxceleb/v2/steps ./
    ln -s $kaldi_voxceleb/v2/sid ./
    echo "FINISH STAGE -1"
fi


if [ $stage -eq 0 ]; then
# prepare voxceleb data
  echo "STARTING prepare voxceleb 1+2 data"
  log=exp/make_voxceleb
  voxceleb1_root=$data_root/voxceleb1_8k
  voxceleb2_root=$data_root/voxceleb2_8k
  $train_cmd $log/log/make_voxceleb2_dev.log local/make_voxceleb2.pl $voxceleb2_root dev data/voxceleb2_train
  echo "FINISH make_voxceleb2.pl dev"
  $train_cmd $log/log/make_voxceleb2_test.log local/make_voxceleb2.pl $voxceleb2_root test data/voxceleb2_test
  echo "FINISH make_voxceleb2.pl test"
  $train_cmd $log/log/make_voxceleb1.log local/make_voxceleb1_v2.pl $voxceleb1_root dev data/voxceleb1_train
  echo "FINISH make_voxceleb1.pl - train"
  $train_cmd $log/log/make_voxceleb1.log local/make_voxceleb1_v2.pl $voxceleb1_root test data/voxceleb1_test
  echo "FINISH make_voxceleb1.pl - test"
  $train_cmd $log/log/combine_voxceleb1+2.log local/combine_data.sh data/voxceleb data/voxceleb2_train data/voxceleb2_test data/voxceleb1_train data/voxceleb1_test
  echo "FINISH combined voxceleb 1+2"
fi

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

if [ $stage -eq 3 ]; then
  # Prepare telephone and microphone speech from Mixer6.
  echo "STARTING prepare mx6 - LDC2013S03"
  #local/make_mx6.sh $data_root/TDNN_train/LDC2013S03 data/
  echo "FINISHED prepare mx6 - LDC2013S03"

  # Prepare SRE10 test and enroll. Includes microphone interview speech.
  echo "STARTING prepare SRE10 eval - LDC2017S06"
  #local/make_sre10.pl $data_root/TDNN_train/LDC2017S06/eval/ data/
  echo "FINISHED prepare SRE10 eval - LDC2017S06"

  # Prepare SRE08 test and enroll. Includes some microphone speech. -> we missed some trial files to proccess this data
  echo "STARTING prepare SRE08 test and train - LDC2011S08 & LDC2011S05"
  #local/make_sre08.pl $data_root/TDNN_train/SRE08/LDC2011S08_test $data_root/TDNN_train/SRE08/LDC2011S05_train data/
  echo "FINISHED prepare SRE08 test and enroll - LDC2011S08 & LDC2011S05"

  # This prepares the older NIST SREs from 2004-2006/ (except SRE06 test_2 that we missed)
  echo "STARTING prepare SRE04,SRE05,SRE06"
  #local/make_sre.sh $data_root/TDNN_train data/
  echo "FINISHED prepare SRE04,SRE05,SRE06"

  # Combine all SREs (04,05,06,08,10) and Mixer6 into one dataset for TDNN training
  echo "STARTING combine SRE (04,05,06,08,10) and MIXER06 for TDNN training"
  utils/combine_data.sh data/sre \
    data/sre2004 data/sre2005_train \
    data/sre2005_test data/sre2006_train \
    data/sre2006_test_1 data/sre2006_test_1 data/sre08 \
    data/mx6 data/sre10
  utils/validate_data_dir.sh --no-text --no-feats data/sre
  utils/fix_data_dir.sh data/sre
  echo "FINISHED combine SRE (04,05,06,08,10) and MIXER06 for TDNN training"
fi

if [ $stage -eq 2 ]; then
  # Prepare SWBD corpora.
  echo "STARTING prepare SWBD"
  local/make_swbd_cellular1.pl $data_root/TDNN_train/LDC2001S13 \
    data/swbd_cellular1_train
	echo "Finished prepare LDC2001S13"
  local/make_swbd_cellular2.pl $data_root/TDNN_train/LDC2004S07 \
    data/swbd_cellular2_train
	echo "FINISHED prepare LDC2004S07"
  local/make_swbd2_phase1.pl $data_root/TDNN_train/LDC98S75 \
    data/swbd2_phase1_train
	echo "FINISHED prepare LDC98S75"
  local/make_swbd2_phase2.pl $data_root/TDNN_train/LDC99S79 \
    data/swbd2_phase2_train
	echo "FINISHED prepare LDC99S79"
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

if [ $stage -eq 3 ]; then
  echo "Starting combined swbd and sre to swbd_sre"
  utils/combine_data.sh data/swbd_sre data/swbd data/sre
  utils/fix_data_dir.sh data/swbd_sre
  echo "FINISHED combined swbd and sre to swbd_sre"    #91263 utterances in total
fi

if [ $stage -eq 3 ]; then
  echo "Starting combined swbd and sre and voxceleb to vox_swbd_sre"
  utils/combine_data.sh data/vox_swbd_sre data/swbd data/sre data/voxceleb
  utils/fix_data_dir.sh data/vox_swbd_sre
  echo "FINISHED combined swbd and sre to vox_swbd_sre"    #1363385 utterances in total
fi

if [ $stage -eq 4 ]; then
  # Prepare NIST SRE 2018 data(enrollment  test and unlabeled to adapt the PLDA) - in domain data.
  echo "STARTING prepare SRE18 eval data"
  local/make_sre18_eval_SPH.pl $data_root/corpora5/SRE18/SRE18_eval_SPH data
  echo "FINISHED prepare SRE18 eval data"
  echo "STARTING preparing SRE18 unlabeled data"
  local/make_sre18_unlabeled.pl $data_root/corpora5/SRE18/LDC2018E46_2018_NIST_Speaker_Recognition_Evaluation_Development_Set data
  echo "FINISHED preparing SRE18 unlabeled data"
  echo "Starting combined SRE18 eval test and unlabeled to SRE18_full"
  utils/combine_data.sh data/sre18_full data/sre18_eval_enroll data/sre18_eval_test data/sre18_unlabeled
  utils/fix_data_dir.sh data/sre18_full
  echo "FINISHED combined SRE18 eval test and unlabeled to sre18_full"
fi

if [ $stage -eq 5 ]; then
  # Prepare NIST SRE 2019 data.
  echo "STARTING prepare SRE19 eval data (enrollment and test)"
  local/make_sre19_eval.pl $data_root/corpora5/SRE19/LDC2019E58 data
  echo "FINISHED prepare SRE19 eval data (enrollment and test)"
fi

if [ $stage -eq 6 ]; then
  echo "Starting combined sre19_enroll and sre19_test to sre19_full"
  utils/combine_data.sh data/sre19_full data/sre19_eval_enroll data/sre19_eval_test
  utils/fix_data_dir.sh data/sre19_full
  echo "FINISHED combined sre19_enroll and sre19_test to sre19_full"    #14951 utterances in total
fi

if [ $stage -eq 7 ]; then
  # Make Fbanks and compute the energy-based VAD for each dataset
  echo "${NOW}"
  for name in sre20_test_val sre20_enrollment_val; do
    echo "Starting compute FBANK to ${name} data!"
    local/make_fbank.sh --write-utt2num-frames true --fbank-config conf/fbank.conf \
      --nj 40 --cmd "$train_cmd" data/${name} exp/make_fbank $fbankdir
    local/fix_data_dir.sh data/${name}
    echo "FINISHED compute FBANK to ${name} data!"
    echo "Starting compute VAD-FBANK to ${name} data!"
    #local/compute_vad_decision.sh --nj 40 --cmd "$train_cmd" \
    #  data/${name} exp/make_vad $fbankdir
    #local/fix_data_dir.sh data/${name}
    echo "FINISHED compute VAD-FBANK to ${name} data!"
  done
  echo "FINISHED compute F-BANK + VAD for all train and test sets"
fi

if [ $stage -eq 7 ]; then
  echo "${NOW}"
  # Make MFCCs and compute the energy-based VAD for each dataset
  # NOTE: Kaldi VAD is based on MFCCs, so we need to additionally extract MFCCs
  for name in sre20_test_val sre20_enrollment_val; do
    echo "Starting compute MFCC to ${name} data!"
    local/copy_data_dir.sh data/${name} data/${name}_mfcc
    local/make_mfcc.sh --write-utt2num-frames true --mfcc-config conf/mfcc.conf \
      --nj 40 --cmd "$train_cmd" data/${name}_mfcc exp/make_mfcc $mfccdir
    local/fix_data_dir.sh data/${name}_mfcc
    echo "FINISHED compute MFCC to ${name} data!"
    echo "Starting compute VAD-MFCC to ${name} data!"
    local/compute_vad_decision.sh --nj 40 --cmd "$train_cmd" \
      data/${name}_mfcc exp/make_vad $mfccdir
    local/fix_data_dir.sh data/${name}_mfcc
    echo "FINISHED compute VAD-MFCC to ${name} data!"
  done
fi

if [ $stage -eq 7 ]; then
  echo "${NOW}"
  # correct the right vad.scp -> change the fbank vad with the mfcc vad
  # We filter the silence frames with the MFCC VAD, but fetures will be the FBANK
  echo "Starting moving the MFCC's VAD to the FBANK's VAD"
  for name in sre20_test_val sre20_enrollment_val; do
    cp data/${name}_mfcc/vad.scp data/${name}/vad.scp
    local/fix_data_dir.sh data/$name
    echo "FINISHED moving the MFCC's VAD of the ${name} data!"
  done
  echo "Finished moving the MFCC's VAD to the FBANK's VAD"
fi

# In this section, we augment the VoxCeleb and SRE data with reverberation,
# noise, music, and babble, and combine it with the clean data.
if [ $stage -eq 8 ]; then
  echo "$(date +"Starting on %m-%d-%y at %T")"
  #RIR augmentation
  if [ ! -d "RIRS_NOISES" ]; then
    echo "Download package include RIRs"
    # Download the package that includes the real RIRs, simulated RIRs, isotropic noises and point-source noises
    wget --no-check-certificate http://www.openslr.org/resources/28/rirs_noises.zip
    unzip rirs_noises.zip
  fi
  rvb_opts=()
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/smallroom/rir_list")
  rvb_opts+=(--rir-set-parameters "0.5, RIRS_NOISES/simulated_rirs/mediumroom/rir_list")

  for name in sre19_full; do
    echo "STARTING reverberate ${name} data"
    log=exp/augmentation
    frame_shift=0.01
    awk -v frame_shift=$frame_shift '{print $1, $2*frame_shift;}' data/${name}/utt2num_frames > data/${name}/reco2dur

    $train_cmd $log/log/reverberate_data_dir_${name}.log python3 steps/data/reverberate_data_dir.py \
      "${rvb_opts[@]}" \
      --speech-rvb-probability 1 \
      --pointsource-noise-addition-probability 0 \
      --isotropic-noise-addition-probability 0 \
      --num-replications 1 \
      --source-sampling-rate 8000 \
      data/${name} data/${name}_reverb
    cp data/${name}/vad.scp data/${name}_reverb/
    local/copy_data_dir.sh --utt-suffix "-reverb" data/${name}_reverb data/${name}_reverb.new
    rm -rf data/${name}_reverb
    mv data/${name}_reverb.new data/${name}_reverb
    echo "FINISHED reverberate ${name} data"
  done
fi

if [ $stage -eq 7 ]; then
  echo "${NOW}"
  # Prepare the MUSAN corpus, which consists of music, speech, and noise
  # suitable for augmentation.
  log=exp/augmentation
  if [ ! -d "/data/musan" ]; then   #if the MUSAN data has already prepared, skip this script to avoid duplication
    echo "STARTING prepare MUSAN data - 8Khz"
    $train_cmd $log/log/make_musan.log steps/data/make_musan.sh --sampling-rate 8000 $musan_root data
    # Get the duration of the MUSAN recordings.  This will be used by the
    # script augment_data_dir.py.
    for name in speech noise music; do
      utils/data/get_utt2dur.sh data/musan_${name}
      mv data/musan_${name}/utt2dur data/musan_${name}/reco2dur
    done
    echo "FINISHED prepare MUSAN data - 8Khz"
  fi

  for name in sre19_full; do
    echo "STARTING augmentation with MUSAN - ${name} data"
    # Augment with musan_noise
    $train_cmd $log/log/augment_musan_noise.log python3 steps/data/augment_data_dir.py --utt-suffix "noise" --fg-interval 1 --fg-snrs "15:10:5:0" --fg-noise-dir "data/musan_noise" data/${name} data/${name}_noise
    # Augment with musan_music
    $train_cmd $log/log/augment_musan_music.log python3 steps/data/augment_data_dir.py --utt-suffix "music" --bg-snrs "15:10:8:5" --num-bg-noises "1" --bg-noise-dir "data/musan_music" data/${name} data/${name}_music
    # Augment with musan_speech
    $train_cmd $log/log/augment_musan_speech.log python3 steps/data/augment_data_dir.py --utt-suffix "babble" --bg-snrs "20:17:15:13" --num-bg-noises "3:4:5:6:7" --bg-noise-dir "data/musan_speech" data/${name} data/${name}_babble

    # Combine reverb, noise, music, and babble into one directory.
    #local/combine_data.sh data/${name}_aug data/${name}_reverb data/${name}_noise data/${name}_music data/${name}_babble      # Total - X utterances
    echo "FINISHED augmentation with MUSAN -  ${name} data"
  done
fi

if [ $stage -eq 9 ]; then
  # Combine the clean and augmented and the raw data
  for name in sre19_full; do
      echo "STARTING combined ${name} augmented "
      local/combine_data.sh data/${name}_aug data/${name}_reverb data/${name}_noise data/${name}_music data/${name}_babble
      local/fix_data_dir.sh data/${name}_aug
      echo "FINISHED combined ${name} augmented"
  done
fi

if [ $stage -eq 10 ]; then
  # Now we will compute FBANks to to the augmented data
  echo "$(date +"Starting on %m-%d-%y at %T")"
  for name in sre19_full_aug; do
    echo "Starting compute FBANK to ${name} data!"
    local/make_fbank.sh --fbank-config conf/fbank.conf --write-utt2num-frames true --nj 40 --cmd "$train_cmd" \
      data/${name} exp/make_fbank fbank
    echo "FINISHED compute FBANK to ${name} data!"
  done
fi

#vox_swbd_sre_combined - total 6816790 utterances
#swbd_sre_combined - total 456180 utterances
#sre19_full_combined - total 74755 utterances
if [ $stage -eq 11 ]; then
  # Combine the clean and augmented and the raw data
  for name in sre19_full; do
      echo "STARTING combined ${name} augmented and clean"
      local/combine_data.sh data/${name}_combined data/${name}_aug data/${name}
      local/fix_data_dir.sh data/${name}_combined
      echo "FINISHED combined ${name} augmented and clean"
  done
fi

# Now we prepare the features to generate examples for embedding extractor training.
if [ $stage -eq 12 ]; then
  # This script applies CMVN and removes nonspeech frames.  Note that this is somewhat
  # wasteful, as it roughly doubles the amount of training data on disk.  After
  # creating training examples, this can be removed.
  #num utterances before silence - X , after - Y
  echo "$(date +"STARTING on %m-%d-%y at %T")"
  for name in sre20_test_val sre20_enrollment_val; do
    echo "STARTING prepare the feats for egs - ${name}"
    local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
      data/${name} data/${name}_no_sil exp/${name}_no_sil
    local/fix_data_dir.sh data/${name}_no_sil
    echo "FINISHED prepare the feats for egs - ${name}"
    echo "$(date +"FINISHED on %m-%d-%y at %T")"
  done
fi

# Now we split all data into two parts: training and cv
if [ $stage -eq 13 ]; then
  log=exp/processed_sre19_800f
  mkdir -p $log

  # filter out utterances w/ < 800 frames
  echo "STARTING filter out utterances w/ < 800 frames"
  awk 'NR==FNR{a[$1]=$2;next}{if(a[$1]>=800)print}' data/vox_swbd_sre_combined_no_sil/utt2num_frames data/vox_swbd_sre_combined_no_sil/utt2spk > $log/utt2spk
  echo "FINISHED filter out utterances w/ < 800 frames"

  echo "STARTING create spk2num_frames"
  # create spk2num_frames, this will be useful for balancing training
  awk '{if(!($2 in a))a[$2]=0;a[$2]+=1;}END{for(i in a)print i,a[i]}' $log/utt2spk > $log/spk2num
  echo "FINISHED create spk2num_frames"

  echo "STARTING create train (95%) and cv (5%) utterance list"
  # create train (95%) and cv (5%) utterance list
  awk -v seed=$RANDOM 'BEGIN{srand(seed);}NR==FNR{a[$1]=$2;next}{if(a[$2]<10)print $1>>"exp/processed_sre19_800f/train.list";else{if(rand()<=0.05)print $1>>"exp/processed_sre19_800f/cv.list";else print $1>>"exp/processed_sre19_800f/train.list"}}' $log/spk2num $log/utt2spk
  echo "FINISHED create train (95%) and cv (5%) utterance list"

  echo "STARTING get the feats.scp for train and cv based on train.list and cv.list"
  # get the feats.scp for train and cv based on train.list and cv.list
  awk 'NR==FNR{a[$1]=1;next}{if($1 in a)print}' $log/train.list data/vox_swbd_sre_combined_no_sil/feats.scp | shuf > $log/vox_swbd_sre_combined_no_sil_train_orig.scp
  awk 'NR==FNR{a[$1]=1;next}{if($1 in a)print}' $log/cv.list data/vox_swbd_sre_combined_no_sil/feats.scp | shuf > $log/vox_swbd_sre_combined_no_sil_cv_orig.scp
  echo "FINISHED get the feats.scp for train and cv based on train.list and cv.list"

  # maps speakers to labels (spkid)
  echo "STARTING maps speakers to labels (spkid)"
  awk 'BEGIN{s=0;}{if(!($2 in a)){a[$2]=s;s+=1;}print $1,a[$2]}' $log/utt2spk > $log/utt2spkid
  echo "FINISHED maps speakers to labels (spkid)"
fi

if [ $stage -eq 14 ]; then
  log=exp/processed_sre19_800f
  # save the uncompressed, preprocessed pytorch tensors
  # Note: this is optional!
  echo "STARTING save the uncompressed, preprocessed pytorch tensors (train & cv)"
  mkdir -p $log/py_tensors
  python3 scripts/prepare_data.py --feat_scp $log/voxceleb_combined_no_sil_train_orig.scp --save_dir $log/py_tensors
  python3 scripts/prepare_data.py --feat_scp $log/voxceleb_combined_no_sil_cv_orig.scp --save_dir $log/py_tensors
  echo "FINISHED save the uncompressed, preprocessed pytorch tensors (train & cv)"
fi

# Network Training
#To parallelize for multiple GPU's, change the "self.res = torch.nn.DataParallel(self.res, device_ids=[0, 1])" on model class
log=exp/processed_sre19_800f
expdir=$log/$expname/
num_spk=`awk 'BEGIN{s=0;}{if($2>s)s=$2;}END{print s+1}' $log/utt2spkid`
if [ $stage -eq 15 ]; then
  mkdir -p $expdir
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "There are "$num_spk" number of speakers."
  echo "STARTING the training process -" $expname
  #$train_cmd $expdir/train.log python3 scripts/main.py \
  python3 scripts/main.py \
                       --train $log/vox_swbd_sre_combined_no_sil_train_orig.scp --cv $log/vox_swbd_sre_combined_no_sil_cv_orig.scp \
                       --utt2spkid $log/utt2spkid --spk_num $num_spk \
                       --min-chunk-size 300 --max-chunk-size 800 \
                       --model 'resnet34' \
                       --input-dim 30 --hidden-dim 2048 --D 32 \
                       --pooling 'mean+std' --network-type 'lde' \
                       --distance-type 'sqr' --asoftmax True --m 4 \
                       --epochs 15 \
                       --batch-size 512 \
                       --log-dir $expdir \
                       --pretrain-model-pth $expdir/model_best.pth.tar
  exit 0
  echo "FINISHED the training process"
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

if [ $stage -eq 16 ]; then
  echo "STARTING create a random subset of the vox_swbd_sre_combined (1M) - for PLDA training"
  utils/subset_data_dir.sh data/vox_swbd_sre_combined 1000000 data/vox_swbd_sre_combined_PLDA_1M
  utils/fix_data_dir.sh data/vox_swbd_sre_combined_PLDA_1M
  echo "FINISHED create a random subset of the vox_swbd_sre_combined (1M)"
fi

# !!!note that we also need to apply the same pre-processing to decode data!!!
if [ $stage -eq 17 ]; then
  log=exp/processed_sre19_800f
  # This script applies CMVN and removes nonspeech frames.  Note that this is somewhat
  # wasteful, as it roughly doubles the amount of training data on disk.  After
  # creating training examples, this can be removed.
  echo "STARTING prepare the vox_swbd_sre_combined_PLDA_1M - train the PLDA"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/vox_swbd_sre_combined_PLDA_1M data/vox_swbd_sre_combined_PLDA_1M_no_sil exp/vox_swbd_sre_combined_PLDA_1M_no_sil
  local/fix_data_dir.sh data/vox_swbd_sre_combined_PLDA_1M_no_sil
  echo "FINISHED prepare the vox_swbd_sre_combined_PLDA_1M - train the PLDA"
fi

if [ $stage -eq 18 ]; then
  log=exp/processed_sre19_800f
  # This script applies CMVN and removes nonspeech frames.  Note that this is somewhat
  # wasteful, as it roughly doubles the amount of training data on disk.  After
  # creating training examples, this can be removed.
  echo "STARTING prepare the sre19_eval_enroll"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre19_eval_enroll data/sre19_eval_enroll_no_sil exp/sre19_eval_enroll_no_sil
  local/fix_data_dir.sh data/sre19_eval_enroll_no_sil
  echo "FINISHED prepare the sre19_eval_enroll"
  echo "STARTING prepare the sre19_eval_test"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre19_eval_test data/sre19_eval_test_no_sil exp/sre19_eval_test_no_sil
  local/fix_data_dir.sh data/sre19_eval_test_no_sil
  echo "FINISHED prepare the sre19_eval_test"
fi

if [ $stage -eq 19 ]; then
  log=exp/processed_sre19_800f
  # This script applies CMVN and removes nonspeech frames.  Note that this is somewhat
  # wasteful, as it roughly doubles the amount of training data on disk.  After
  # creating training examples, this can be removed.
  echo "STARTING prepare the sre20_eval_enroll"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre20_eval_enroll data/sre20_eval_enroll_no_sil exp/sre20_eval_enroll_no_sil
  local/fix_data_dir.sh data/sre20_eval_enroll_no_sil
  echo "FINISHED prepare the sre20_eval_enroll"
  echo "STARTING prepare the sre20_eval_test"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre20_eval_test data/sre20_eval_test_no_sil exp/sre20_eval_test_no_sil
  local/fix_data_dir.sh data/sre20_eval_test_no_sil
  echo "FINISHED prepare the sre20_eval_test"
fi

if [ $stage -eq 20 ]; then
  log=exp/processed_sre19_800f
  # This script applies CMVN and removes nonspeech frames.  Note that this is somewhat
  # wasteful, as it roughly doubles the amount of training data on disk.  After
  # creating training examples, this can be removed.
  echo "STARTING prepare the sre18_combined"
  local/nnet3/xvector/prepare_feats_for_egs.sh --nj 40 --cmd "$train_cmd" --compress true \
    data/sre18_combined data/sre18_combined_no_sil exp/sre18_combined_no_sil
  local/fix_data_dir.sh data/sre18_combined_no_sil
  echo "FINISHED prepare the sre18_combined"
fi

#Here we decoding the data before extracting the embeddings
if [ $stage -eq 21 ]; then
  log=exp/processed_sre19_800f
  echo "STARTING convert the vox_swbd_sre_combined_PLDA_1M_no_sil for decoding"
  #cat data/vox_swbd_sre_combined_PLDA_1M_no_sil/feats.scp > $log/decode_vox_swbd_sre_combined_PLDA_1M_no_sil.scp
  echo "FINISHED convert the vox_swbd_sre_combined_PLDA_1M_no_sil for decoding"
  echo "STARTING convert the sre19_test/enroll for decoding"
  #cat data/sre19_eval_enroll_no_sil/feats.scp > $log/decode_sre19_eval_enroll_no_sil.scp
  #cat data/sre19_eval_test_no_sil/feats.scp > $log/decode_sre19_eval_test_no_sil.scp
  echo "FINISHED convert the sre19_test/enroll to decode_fixed data"
  echo "STARTING convert the sre20_test/enroll for decoding"
  #cat data/sre20_eval_enroll_no_sil/feats.scp > $log/decode_sre20_eval_enroll_no_sil.scp
  #cat data/sre20_eval_test_no_sil/feats.scp > $log/decode_sre20_eval_test_no_sil.scp
  echo "FINISHED convert the sre20_test/enroll to decode_fixed data"
  echo "STARTING convert the sre18_combined for decoding"
  #cat data/sre18_combined_no_sil/feats.scp > $log/decode_sre18_combined_no_sil.scp
  echo "FINISHED convert the sre18_combined for decoding"
  echo "STARTING convert the sre18_19_combined for decoding"
  #cat data/swbd_sre_combined_no_sil/feats.scp > $log/decode_swbd_sre_combined_no_sil.scp
  echo "FINISHED convert the sre18_19_combined for decoding"
  echo "STARTING convert the sre20_test/enrollment val for decoding"
  cat data/sre20_enrollment_val_no_sil/feats.scp > $log/decode_sre20_enrollment_val_no_sil.scp
  cat data/sre20_test_val_no_sil/feats.scp > $log/decode_sre20_test_val_no_sil.scp
  echo "FINISHED convert the sre20_test/enrollment val to decode_fixed data"
fi

log=exp/processed_sre19_800f
mkdir -p $log/ivs/
ivs=$log/ivs/$expname/
mkdir -p $ivs
chmod 777 $expdir/*
#num_spk_tmp=7274
# Network Decoding; do this for all your data
if [ $stage -eq 22 ]; then
  echo "$(date +"Starting on %m-%d-%y at %T")"
  echo "STARTING the decoding (embedding extractor) process  -  $expname "
  model=$expdir/model_best.pth.tar # get best model
#  $cuda_cmd $expdir/decode.log python scripts/decode.py \
#  python3 scripts/decode.py \
  $train_cmd $expdir/decode.log python3 scripts/decode.py \
                       --spk_num $num_spk --model 'resnet34' \
                       --input-dim 30 --hidden-dim 512 --D 32 \
                       --pooling 'mean+std' --network-type 'lde' \
                       --distance-type 'sqr' --asoftmax True --m 4 \
                       --model-path $model --decode-scp $log/decode_sre20_enrollment_val_no_sil.scp \
                       --out-path $ivs/embedding_sre20_enrollment_val_no_sil.ark
  echo "FINISHED the decoding (embedding extractor) process  -  $expname "
  echo "$(date +"Finished on %m-%d-%y at %T")"
fi

train_plda_no_sil_utt2spk=data/vox_swbd_sre_combined_PLDA_1M_no_sil/utt2spk
train_plda_no_sil_spk2utt=data/vox_swbd_sre_combined_PLDA_1M_no_sil/spk2utt
test_no_sil_utt2spk=data/sre19_eval_test_no_sil/utt2spk
enroll_no_sil_utt2spk=data/sre19_eval_enroll_no_sil/utt2spk
test20_no_sil_utt2spk=data/sre20_eval_test_no_sil/utt2spk
enroll20_no_sil_utt2spk=data/sre20_eval_enroll_no_sil/utt2spk
adapt_no_sil_utt2spk=data/sre18_combined_no_sil/utt2spk
backend_log=exp/backend_sre19_800f/$expname/

# NO need this stage, we work just with the embedding.ark without .iv files
if [ $stage -eq 23 ]; then
#Divide the embeddings of the data sets from the embedding.ark file to the specific data sets
echo "STARTING define the lists of the  data sets"
mkdir -p exp/backend_sre19_800f/
mkdir -p $backend_log
echo "FINISHED define the lists of the  data sets"
# get train, enrollment and test embeddings
decode_enroll_no_sil=$ivs/embedding_sre19_eval_enroll_no_sil.ark
decode_test_no_sil=$ivs/embedding_sre19_eval_test_no_sil.ark
decode_adapt_no_sil=$ivs/embedding_sre18_combined_no_sil.ark
decode_train_plda_no_sil=$ivs/embedding_vox_swbd_sre_combined_PLDA_1M_no_sil.ark

echo "STARTING divide the main embedding.ark file into data sets (train.iv, test.iv, enroll.iv, adapt.iv) "
    awk 'NR==FNR{a[$1]=1;next}{if($1 in a)print}' $enroll_no_sil_utt2spk $decode_enroll_no_sil > $backend_log/sre19_eval_enroll_no_sil.iv
    awk 'NR==FNR{a[$1]=1;next}{if($1 in a)print}' $test_no_sil_utt2spk $decode_test_no_sil > $backend_log/sre19_eval_test_no_sil.iv
    awk 'NR==FNR{a[$1]=1;next}{if($1 in a)print}' $adapt_no_sil_utt2spk $decode_adapt_no_sil > $backend_log/sre18_combined_no_sil.iv
    awk 'NR==FNR{a[$1]=1;next}{if($1 in a)print}' $train_plda_no_sil_utt2spk $decode_train_plda_no_sil > $backend_log/embedding_vox_swbd_sre_combined_PLDA_1M_no_sil.iv
echo "FINISHED divide the main embedding.ark file into data sets (train.iv, test.iv, enroll.iv, adapt.iv) "
fi
backend_log=exp/backend_sre19_800f/$expname/
ivs=$log/ivs/$expname/
if [ $stage -eq 24 ]; then
  # Average the utterance-level xvectors to get speaker-level xvectors.
  echo "computing mean of xvectors for each speaker to extract the num_utts_sre19_eval_enrol_no_sill"
  $train_cmd $backend_log/sre19_eval_enroll_no_sil_mean.log \
    ivector-mean ark:data/sre19_eval_enroll_no_sil/spk2utt ark:$ivs/embedding_sre19_eval_enroll_no_sil.ark \
    ark,scp:$backend_log/spk_xvector_no_sil.ark,$backend_log/spk_xvector_no_sil.scp ark,t:$backend_log/num_utts_no_sil.ark || exit 1;
  echo "FINISHEDDDDD computing mean of xvectors for each speaker of the enrollmenmt data set"
fi

if [ $stage -eq 25 ]; then
  # Average the utterance-level xvectors to get speaker-level xvectors.
  echo "computing mean of xvectors for each speaker to extract the num_utts_sre20_eval_enrol_no_sill"
  $train_cmd $backend_log/sre20_eval_enroll_no_sil_mean.log \
    ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt ark:$ivs/embedding_sre20_eval_enroll_no_sil.ark \
    ark,scp:$backend_log/spk_xvector_no_sil.ark,$backend_log/spk_xvector_no_sil.scp ark,t:$backend_log/sre20_num_utts_no_sil.ark || exit 1;
  echo "FINISHED computing mean of xvectors for each speaker of the enrollmenmt data set"
fi

if [ $stage -eq 26 ]; then
  # Average the utterance-level xvectors to get speaker-level xvectors.
  echo "computing mean of xvectors for each speaker to extract the num_utts_sre20_eval_enrol_no_sill"
  $train_cmd $backend_log/sre20_enrollment_val_no_sil_mean.log \
    ivector-mean ark:data/sre20_enrollment_val_no_sil/spk2utt ark:$ivs/embedding_sre20_enrollment_val_no_sil.ark \
    ark,scp:$backend_log/sre20_val_spk_xvector_no_sil.ark,$backend_log/sre20_val_spk_xvector_no_sil.scp ark,t:$backend_log/sre20_val_num_utts_no_sil.ark || exit 1;
  echo "FINISHED computing mean of xvectors for each speaker of the enrollmenmt data set"
fi

if [ $stage -eq 27 ]; then
    # Compute the mean vector for centering the evaluation xvectors.
    echo "Compute the mean vector for centering the evaluation xvectors"
	$train_cmd $backend_log/compute_mean.log \
		ivector-mean ark:$ivs/embedding_sre18_19_combined_no_sil.ark\
		$backend_log/sre18_19_combined_no_sil_mean.vec || exit 1;
    echo "FINISHED compute mean vector for sre18_19_full_combined"
fi

if [ $stage -eq 28 ]; then
    # This script uses LDA to decrease the dimensionality prior to PLDA.
    echo "STARTING train LDA"
    lda_dim=250
    $train_cmd $backend_log/lda.log \
        ivector-compute-lda --total-covariance-factor=0.0 --dim=$lda_dim \
        "ark:ivector-subtract-global-mean ark:$ivs/embedding_swbd_sre_combined_no_sil.ark ark:- |" \
        ark:data/swbd_sre_combined_no_sil/utt2spk $backend_log/swbd_sre_combined_no_sil_transform.mat || exit 1;
    echo "FINISHED train LDA"
fi

if [ $stage -eq 29 ]; then
    # Train the PLDA model.
    echo "STARTING train PLDA"
    $train_cmd $backend_log/plda.log \
        ivector-compute-plda ark:data/vox_swbd_sre_combined_PLDA_1M_no_sil/spk2utt \
        "ark:ivector-subtract-global-mean ark:$ivs/embedding_vox_swbd_sre_combined_PLDA_1M_no_sil.ark ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:-  ark:- |" \
        $backend_log/plda_vox_swbd_sre_combined_PLDA_1M_no_sil_lda_swbdsre || exit 1;
    echo "FINISHED train PLDA"
fi

if [ $stage -eq 30 ]; then
  # Here we adapt the out-of-domain PLDA (Using the SWBD_SRE LDA) model to SRE18_19_full_combined
  echo "STARTING adapt the out of domain PLDA model with xvectors_sre18_19_full_combined_no_sil"
  $train_cmd $backend_log/plda_adapt.log \
    ivector-adapt-plda --within-covar-scale=0.75 --between-covar-scale=0.25 \
    $backend_log/plda_vox_swbd_sre_combined_PLDA_1M_no_sil_lda_swbdsre \
    "ark:ivector-subtract-global-mean ark:$ivs/embedding_sre18_19_combined_no_sil.ark ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
    $backend_log/sre18_19_combined_no_sil_plda_voxswbdsre1M_lda_swbdsre_adapt || exit 1;
  echo "FINISHED adapted the out of domain PLDA model with xvectors_sre18_19_full_combined_no_sil"
fi

if [ $stage -eq 31 ]; then
  # Get results
  # VR1 + VR2
  # LDA - swbd_sre_combined_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
  #"ark:ivector-subtract-global-mean $backend_log/sre18_full_aug_mean.vec ark:$backend_log/sre19_eval_enroll.iv ark:- | transform-vec $backend_log/sre18_full_aug_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
  echo "STARTING scoring sre20_test_no_sil"
  $train_cmd $backend_log/sre20_test_scoring.log \
      ivector-plda-scoring --normalize-length=true \
      --num-utts=ark:$backend_log/sre20_num_utts_no_sil.ark \
      "ivector-copy-plda --smoothing=0.0 $backend_log/sre18_19_combined_no_sil_plda_voxswbdsre1M_lda_swbdsre_adapt - |" \
      "ark:ivector-mean ark:data/sre20_eval_enroll_no_sil/spk2utt ark:$ivs/embedding_sre20_eval_enroll_no_sil.ark ark:- | ivector-subtract-global-mean $backend_log/sre18_19_combined_no_sil_mean.vec ark:- ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
      "ark:ivector-subtract-global-mean $backend_log/sre18_19_combined_no_sil_mean.vec ark:$ivs/embedding_sre20_eval_test_no_sil.ark ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
      "cat '$sre20_trials' | cut -d\  --fields=1,2 |" $backend_log/sre20_eval_scores_VR1 || exit 1;
  echo "FINISHED scoring sre20_test_no_sil"
fi

if [ $stage -eq 26 ]; then
  # Convert the score file to ".tsv" scoring software format and copy it to the scoring software output folder
  echo "STARTING convert the score file"
  convert_scores.sh $backend_log/sre20_eval_scores_VR2 ${scoring_software_output_path}/resnet/SRE20 sre20_eval_scores_VR2
  echo "FINISHED convert the score file"
fi

if [ $stage -eq 26 ]; then
  # Apply AS-NORM on the scores
  #scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software/system_output
  echo "STARTING AS-NORM on scores file"
  python3 ${scoring_software_output_path}/as_norm.py ${scoring_software_output_path}/resnet/SRE20/sre20_eval_scores_VR2.tsv
  echo "FINISHED AS-NORM on scores file"
fi

if [ $stage -eq 26 ]; then
  # Scoring using the scoring software
  echo "STARTING scoring using SRE scoring_software"
  run_scoring.sh resnet/scores_sre19_test_no_sil_v4_ASnorm.tsv
  echo "FINISHED scoring using SRE scoring_software - GOOD LUCK!"
fi


############################ Scoring of SRE19 data sets for fusion uses #################################
### VR1 + VR2
### LDA - swbd_sre_combined_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
if [ $stage -eq 100 ]; then
  # Get results using the  PLDA model - voxceleb_combined_train.
  #"ark:ivector-subtract-global-mean $backend_log/sre18_full_aug_mean.vec ark:$backend_log/sre19_eval_enroll.iv ark:- | transform-vec $backend_log/sre18_full_aug_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
  echo "STARTING scoring sre19_test_no_sil"
  $train_cmd $backend_log/sre19_test_scoring.log \
      ivector-plda-scoring --normalize-length=true \
      --num-utts=ark:$backend_log/sre19_num_utts_no_sil.ark \
      "ivector-copy-plda --smoothing=0.0 $backend_log/sre18_19_combined_no_sil_plda_voxswbdsre1M_lda_swbdsre_adapt - |" \
      "ark:ivector-mean ark:data/sre19_eval_enroll_no_sil/spk2utt ark:$ivs/embedding_sre19_eval_enroll_no_sil.ark ark:- | ivector-subtract-global-mean $backend_log/sre18_19_combined_no_sil_mean.vec ark:- ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
      "ark:ivector-subtract-global-mean $backend_log/sre18_19_combined_no_sil_mean.vec ark:$ivs/embedding_sre19_eval_test_no_sil.ark ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
      "cat '$sre19_trials' | cut -d\  --fields=1,2 |" $backend_log/sre19_eval_scores_VR2 || exit 1;
  echo "FINISHED scoring sre19_test_no_sil"
fi

if [ $stage -eq 100 ]; then
  # Convert the score file to ".tsv" scoring software format and copy it to the scoring software output folder
  echo "STARTING convert the score file"
  convert_scores.sh $backend_log/sre19_eval_scores_VR2 ${scoring_software_output_path}/resnet/SRE19_fusion sre19_eval_scores_VR2
  echo "FINISHED convert the score file"
fi

if [ $stage -eq 100 ]; then
  # Apply AS-NORM on the scores
  #scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software/system_output
  echo "STARTING AS-NORM on scores file"
  python3 ${scoring_software_output_path}/as_norm.py ${scoring_software_output_path}/resnet/SRE19_fusion/sre19_eval_scores_VR2.tsv
  echo "FINISHED AS-NORM on scores file"
fi


############################ Scoring of SRE20 Validation data sets for calibration #################################
### VR1 + VR2
### LDA - swbd_sre_combined_no_sil , PLDA - vox_swbd_sre_combined_1M_no_sil,  adaptation - SRE18_19_full_combined_no_sil, centering(mean) - SRE18_19_full_combined_no_sil, Test - no_sil
if [ $stage -eq 200 ]; then
  # Get results using the  PLDA model - voxceleb_combined_train.
  #"ark:ivector-subtract-global-mean $backend_log/sre18_full_aug_mean.vec ark:$backend_log/sre19_eval_enroll.iv ark:- | transform-vec $backend_log/sre18_full_aug_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
  echo "STARTING scoring sre20_test_val_no_sil"
  $train_cmd $backend_log/sre20_test_val_scoring.log \
      ivector-plda-scoring --normalize-length=true \
      --num-utts=ark:$backend_log/sre20_val_num_utts_no_sil.ark \
      "ivector-copy-plda --smoothing=0.0 $backend_log/sre18_19_combined_no_sil_plda_voxswbdsre1M_lda_swbdsre_adapt - |" \
      "ark:ivector-mean ark:data/sre20_enrollment_val_no_sil/spk2utt ark:$ivs/embedding_sre20_enrollment_val_no_sil.ark ark:- | ivector-subtract-global-mean $backend_log/sre18_19_combined_no_sil_mean.vec ark:- ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
      "ark:ivector-subtract-global-mean $backend_log/sre18_19_combined_no_sil_mean.vec ark:$ivs/embedding_sre20_test_val_no_sil.ark ark:- | transform-vec $backend_log/swbd_sre_combined_no_sil_transform.mat ark:- ark:- | ivector-normalize-length ark:- ark:- |" \
      "cat '$sre20_trials_val' | cut -d\  --fields=1,2 |" $backend_log/sre20_validation_scores_VR2 || exit 1;
  echo "FINISHED scoring sre20_test_val_no_sil"
fi

if [ $stage -eq 200 ]; then
  # Convert the score file to ".tsv" scoring software format and copy it to the scoring software output folder
  echo "STARTING convert the score file"
  convert_scores.sh $backend_log/sre20_validation_scores_VR2 ${scoring_software_output_path}/resnet/SRE20 sre20_validation_scores_VR2
  echo "FINISHED convert the score file"
fi

if [ $stage -eq 200 ]; then
  # Apply AS-NORM on the scores
  #scoring_software_output_path=/common_space_docker/storage_4TSSD/scoring_software/system_output
  echo "STARTING AS-NORM on scores file"
  python3 ${scoring_software_output_path}/as_norm.py ${scoring_software_output_path}/resnet/SRE20/sre20_validation_scores_VR2.tsv
  echo "FINISHED AS-NORM on scores file"
fi
exit 1














