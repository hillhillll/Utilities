#!/usr/bin/env tcsh

echo "auto-generated by afni_proc.py, Mon Aug 11 10:42:37 2008"
echo "(version 1.28, Jan 28, 2008)"

# execute via : tcsh -x WorkInProgressScript |& tee output.WorkInProgressScript

# --------------------------------------------------
# script setup

# the user may specify a single subject to run with
if ( $#argv > 0 ) then  
    set subj = $argv[1] 
else                    
    set subj = SUBJ       
endif

# assign output directory name
set output_dir = $subj.results

# verify that the results directory does not yet exist
if ( -d $output_dir ) then 
    echo output dir "$subj.results" already exists
    exit                     
endif

# set list of runs
set runs = (`count -digits 2 1 1`)

# create results directory
mkdir $output_dir

# create stimuli directory, and copy stim files
mkdir $output_dir/stimuli
cp mf-memory.1D.txt ff-memory.1D.txt nf-memory.1D.txt na-memory.1D.txt \
    ma-memory.1D.txt fa-memory.1D.txt null-memory.1D.txt $output_dir/stimuli

# -------------------------------------------------------
# apply 3dTcat to copy input dsets to results dir, while
# removing the first 0 TRs
3dTcat -prefix $output_dir/pb00.$subj.r01.tcat s1-memboth-cat+orig'[0..$]'

# and enter the results directory
cd $output_dir

# -------------------------------------------------------
# apply 3dDespike to each run
foreach run ( $runs )
    3dDespike -prefix pb01.$subj.r$run.despike pb00.$subj.r$run.tcat+orig
end

# -------------------------------------------------------
# run 3dToutcount and 3dTshift for each run
foreach run ( $runs )
    3dToutcount -automask pb01.$subj.r$run.despike+orig > outcount_r$run.1D

    3dTshift -tzero 0 -quintic -prefix pb02.$subj.r$run.tshift      \
             pb01.$subj.r$run.despike+orig
end

# -------------------------------------------------------
# align each dset to the base volume
foreach run ( $runs )
    3dvolreg -verbose -zpad 1 -base pb02.$subj.r01.tshift+orig'[0]'  \
             -1Dfile dfile.r$run.1D -prefix pb03.$subj.r$run.volreg  \
             -cubic                                                  \
             pb02.$subj.r$run.tshift+orig
end

# make a single file of registration params
cat dfile.r??.1D > dfile.rall.1D

# -------------------------------------------------------
# blur each volume
foreach run ( $runs )
    3dmerge -1blur_fwhm 4.0 -doall -prefix pb04.$subj.r$run.blur   \
            pb03.$subj.r$run.volreg+orig
end

# -------------------------------------------------------
# create 'full_mask' dataset (union mask)
foreach run ( $runs )
    3dAutomask -dilate 1 -prefix rm.mask_r$run pb04.$subj.r$run.blur+orig
end

# only 1 run, so copy this to full_mask
3dcopy rm.mask_r01+orig full_mask.$subj

# -------------------------------------------------------
# scale each voxel time series to have a mean of 100
# (subject to maximum value of 200)
foreach run ( $runs )
    3dTstat -prefix rm.mean_r$run pb04.$subj.r$run.blur+orig
    3dcalc -a pb04.$subj.r$run.blur+orig -b rm.mean_r$run+orig  \
           -c full_mask.$subj+orig                              \
           -expr 'c * min(200, a/b*100)'                        \
           -prefix pb05.$subj.r$run.scale
end

# -------------------------------------------------------
# run the regression analysis
3dDeconvolve -input pb05.$subj.r??.scale+orig.HEAD                     \
    -polort 7                                                          \
    -mask full_mask.$subj+orig                                         \
    -num_stimts 13                                                     \
    -stim_times 1 stimuli/mf-memory.1D.txt 'GAM'                       \
    -stim_label 1 mf_memory                                            \
    -stim_times 2 stimuli/ff-memory.1D.txt 'GAM'                       \
    -stim_label 2 ff_memory                                            \
    -stim_times 3 stimuli/nf-memory.1D.txt 'GAM'                       \
    -stim_label 3 nf_memory                                            \
    -stim_times 4 stimuli/na-memory.1D.txt 'GAM'                       \
    -stim_label 4 na_memory                                            \
    -stim_times 5 stimuli/ma-memory.1D.txt 'GAM'                       \
    -stim_label 5 ma_memory                                            \
    -stim_times 6 stimuli/fa-memory.1D.txt 'GAM'                       \
    -stim_label 6 fa_memory                                            \
    -stim_times 7 stimuli/null-memory.1D.txt 'GAM'                     \
    -stim_label 7 null_memory                                          \
    -stim_file 8 dfile.rall.1D'[0]' -stim_base 8 -stim_label 8 roll    \
    -stim_file 9 dfile.rall.1D'[1]' -stim_base 9 -stim_label 9 pitch   \
    -stim_file 10 dfile.rall.1D'[2]' -stim_base 10 -stim_label 10 yaw  \
    -stim_file 11 dfile.rall.1D'[3]' -stim_base 11 -stim_label 11 dS   \
    -stim_file 12 dfile.rall.1D'[4]' -stim_base 12 -stim_label 12 dL   \
    -stim_file 13 dfile.rall.1D'[5]' -stim_base 13 -stim_label 13 dP   \
    -fout -tout -x1D X.xmat.1D -xjpeg X.jpg                            \
    -fitts fitts.$subj                                                 \
    -bucket stats.$subj


# create an all_runs dataset to match the fitts, errts, etc.
3dTcat -prefix all_runs.$subj pb05.$subj.r??.scale+orig.HEAD

# create ideal files for each stim type
1dcat X.xmat.1D'[8]' > ideal_mf_memory.1D
1dcat X.xmat.1D'[9]' > ideal_ff_memory.1D
1dcat X.xmat.1D'[10]' > ideal_nf_memory.1D
1dcat X.xmat.1D'[11]' > ideal_na_memory.1D
1dcat X.xmat.1D'[12]' > ideal_ma_memory.1D
1dcat X.xmat.1D'[13]' > ideal_fa_memory.1D
1dcat X.xmat.1D'[14]' > ideal_null_memory.1D

# -------------------------------------------------------

# remove temporary rm.* files
\rm -f rm.*

# return to parent directory
cd ..




# -------------------------------------------------------
# script generated by the command:
#
# afni_proc.py -dsets s1-memboth-cat+orig -blocks despike tshift volreg blur \
#     mask scale regress -script WorkInProgressScript -tcat_remove_first_trs \
#     0 -volreg_align_to first -regress_stim_times mf-memory.1D.txt          \
#     ff-memory.1D.txt nf-memory.1D.txt na-memory.1D.txt ma-memory.1D.txt    \
#     fa-memory.1D.txt null-memory.1D.txt -regress_stim_labels mf_memory     \
#     ff_memory nf_memory na_memory ma_memory fa_memory null_memory
