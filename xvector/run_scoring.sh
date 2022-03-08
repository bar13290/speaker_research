#!/bin/bash

set -e
scores_name=$1
scoring_software_path=/common_space_docker/storage_4TSSD/scoring_software20
scores_path=/common_space_docker/storage_4TSSD/kaldi/egs/sre16/v2_SRE19_full_train/exp/scores/${scores_name}
system_output_path=${scoring_software_path}/system_output
converted_scores=${system_output_path}/${scores_name}
trial_key_path=${system_output_path}/sre19_cts_challenge_trial_key.tsv
trial_path=${system_output_path}/sre19_cts_challenge_trials.tsv
#Scoring using the software
echo "STARTING Scoring"
python3 ${scoring_software_path}/sre18_submission_scorer.py -o ${converted_scores} -l ${trial_path} -r ${trial_key_path}

