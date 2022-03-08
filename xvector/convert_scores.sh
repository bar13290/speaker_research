#!/bin/bash

#script that apllying the SRE scoring software on a scoring outpout ".tsv" file
#The script is written and working under the v2_SRE19_full_train path.
# If you are working on diffrent path, change it accordingly

#Written by Bar Madar 6.20

set -e
echo "$0 $1 $2 $3"  # Print the command line for logging
if [ $# -ne 3 ]; then
    echo "USAGE: $0 scores_path system_output_path scores_name "
    echo "scores_name is the path where the scores file located"
    echo "system_output_path is the path of the system output folder on the NIST scoring software"
    echo "e.g: $0 exp/scores/sre19_eval_scores_adapt_E_8k /common_space_docker/storage_4TSSD/scoring_software20/system_output sre19_eval_scores_adapt_E_8k"
    exit 1;
fi

scores_path=$1
scores_full_path=/common_space_docker/storage_4TSSD/kaldi/egs/sre16/v2_SRE19_full_train/${scores_path}
#scoring_software_path=/common_space_docker/storage_4TSSD/scoring_software20
#system_output_path=${scoring_software_path}/system_output
system_output_path=$2
scores_name=$3

#copy the scoring file to the scoring_software/system_output directory
echo "STARTING copy scores file"
cp ${scores_full_path} ${system_output_path}
echo "FINISHED copy scores file"
new_scores_path=${system_output_path}/${scores_name}

#convert the scores file to a scoring software format file
echo "STARTING converted"
python3 /common_space_docker/storage_4TSSD/scoring_software20/system_output/convert_kaldi_sre.py ${new_scores_path}
#converted_scores=${system_output_path}/${scores_name}.tsv
echo "FINISHED converted"

#Scoring using the software
#echo "STARTING Scoring"
#python3 ${scoring_software_path}/sre18_submission_scorer.py -o ${converted_scores} -l ${system_output_path}/sre19_cts_challenge_trials.tsv -r ${system_output_path}/sre19_cts_challenge_trial_key.tsv




