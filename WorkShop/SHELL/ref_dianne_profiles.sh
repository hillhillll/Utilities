IMG_profile
# define path variables that can be called by my scripts

export REF=/usr/local/ref
export ROIS=${REF}/rois_useful
export FSLDIR=/usr/local/fsl
export STANDARD=${FSLDIR}/data/standard
export DTIERP=/Exps/Data/dti_erp
export SZR=/Exps/Data/szr
export PLANTE=/Exps/Data/plante
export IJN=/Exps/Data/IJN
export DATADIR=/Exps/Data
export stand_brain=${STANDARD}/MNI152_T1_2mm_brain

# define lists
export LISTS=${REF}/lst*

# define aliases
alias fv='fslview'
alias fvs='fslview ${STANDARD}/MNI152_T1_2mm_brain.nii.gz'
alias math='fslmaths'
alias stats='fslstats'
alias itksnap='/Applications/ITK-SNAP.app/Contents/MacOS/InsightSNAP'


SUBJECT_profile
#!/bin/sh
# define path variables that can be called by my scripts
source /usr/local/ref/img_profile

# This is the subject directory
SUBJECTDIR=`pwd`
SUBJECT=`basename $SUBJECTDIR`
# remove the initial e from the name
LOGPREFIX=`echo $SUBJECT| sed -e 's/e//'`

export DTI=${SUBJECTDIR}/DTI
export BEDPOST=${DTI}/Bed.bedpostX
export XFMS=${BEDPOST}/xfms
export REG=${BEDPOST}/xfms

export MORPH=${SUBJECTDIR}/Morph
export CC=${MORPH}/CC
export WMH=${MORPH}/WMH
export HIPPO=${MORPH}/HIPPO

export ORIG=${SUBJECTDIR}/Orig
export REGTEST=${SUBJECTDIR}/Reg_Test
export SUBROIS=${SUBJECTDIR}/SubjectROIs
export PICS=${SUBJECTDIR}/Pictures
export STATS=${SUBJECTDIR}/Access
export FUNC=${SUBJECTDIR}/Func
export EPRIME=${FUNC}/Eprime


PLANTE_profile
#!/bin/sh
# define path variables that can be called by my scripts
source /usr/local/ref/subject_profile

# Redundant, but should eventually go only here (not in subject_profile).
export EPRIME=${FUNC}/Eprime
export MR_NUM=`cat MRNUM.txt`
export IJN=${FUNC}/IJN

# Run directories
export RUN1=${FUNC}/Run1
export RUN2=${FUNC}/Run2
export RUN3=${FUNC}/Run3

# whole brains w skulls
export nodif=${DTI}/${SUBJECT}_nodif
export flair=${MORPH}/${SUBJECT}_flair
export spgr=${MORPH}/${SUBJECT}_spgr
export T1=${MORPH}/${SUBJECT}_T1

# skull stripped brains
export nodif_brain=${DTI}/${SUBJECT}_nodif_brain
export flair_brain=${MORPH}/${SUBJECT}_flair_brain
export struct=${MORPH}/${SUBJECT}_struct
export T1_brain=${MORPH}/${SUBJECT}_T1_brain
#export stand_brain=${STANDARD}/MNI152_T1_2mm_brain

# single volumes
export run1_vol=${FUNC}/run1_${SUBJECT}_vol83
export run2_vol=${FUNC}/run2_${SUBJECT}_vol83
export run3_vol=${FUNC}/run3_${SUBJECT}_vol83

# brain masks
export nodif_mask=${DTI}/${SUBJECT}_nodif_mask
export flair_mask=${MORPH}/${SUBJECT}_flair_mask
export struct_mask=${MORPH}/${SUBJECT}_struct_mask
export struct_csf=${MORPH}/${SUBJECT}_struct_seg_0
export struct_gm=${MORPH}/${SUBJECT}_struct_seg_1
export struct_wm=${MORPH}/${SUBJECT}_struct_seg_2
export T1_mask=${MORPH}/${SUBJECT}_T1_mask
export T1_mask_csf=${MORPH}/${SUBJECT}_T1_brain_seg_0
export T1_mask_gm=${MORPH}/${SUBJECT}_T1_brain_seg_1
export T1_mask_wm=${MORPH}/${SUBJECT}_T1_brain_seg_2

# DTI images
export FA=${DTI}/ecc_${SUBJECT}_FA
export L1=${DTI}/ecc_${SUBJECT}_L1
export L2=${DTI}/ecc_${SUBJECT}_L2
export L3=${DTI}/ecc_${SUBJECT}_L3
export MD=${DTI}/ecc_${SUBJECT}_MD
export RD=${DTI}/ecc_${SUBJECT}_RD
export V1=${DTI}/ecc_${SUBJECT}_V1
export V2=${DTI}/ecc_${SUBJECT}_V2
export V3=${DTI}/ecc_${SUBJECT}_V3

#4D volumes
export dti_4d=${DTI}/${SUBJECT}_data
export run1_4d=${RUN1}/run1_${SUBJECT}
export run2_4d=${RUN2}/run2_${SUBJECT}
export run3_4d=${RUN3}/run3_${SUBJECT}
