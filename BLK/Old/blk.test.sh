####################################################################################################
# Source the experiment profile
. $PROFILE/${1}_profile
####################################################################################################
								########### START OF MAIN ############
####################################################################################################
# It is crucial that each script is sourced and is followed by the ${1} tag
. $PROG/test_reg.sh ${1}  2>&1 | tee -a ${prep_dir}/log.${subrun}.reconstruct.txt
####################################################################################################