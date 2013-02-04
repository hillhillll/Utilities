#!/usr/bin/env tcsh
echo "This script prints the first two rows, and the following columns: Volume, Mean, Sem, Max Int, X, Y, and Z"
##Cluster report for file /Volumes/Data/MRI-AttnMem/Anova/Contrasts/FvN/roi/SMG/SMG_GAM1_FvN+tlrc[0] 
##[Connectivity radius = 1.00 mm	Volume threshold = 10.00 ]
##[Single voxel volume = 1.0 (microliters) ]
##[Voxel datum type		= short ]
##[Voxel dimensions		= 1.000 mm X 1.000 mm X 1.000 mm ]
##[Coordinates Order	 = RAI ]
##Mean and SEM based on Absolute Value of voxel intensities: 
#
##Volume	CM RL	CM AP	CM IS	minRL	maxRL	minAP	maxAP	minIS	maxIS		Mean		 SEM		Max Int	MI RL	MI AP	MI IS
##------	-----	-----	-----	-----	-----	-----	-----	-----	-----	-------	-------	-------	-----	-----	-----
# '		104	-41.1	 51.1	 42.9	-47.0	-36.0	 47.0	 56.0	 38.0	 47.0	 0.0616	7.5e-04	 0.0794	-40.0	 52.0	 42.0 
# '		 20	 50.1	 41.6	 35.9	 46.0	 52.0	 40.0	 42.0	 35.0	 38.0	 0.0676	8.8e-04	 0.0746	 50.0	 42.0	 37.0 
# '		 14	 45.3	 47.6	 38.0	 44.0	 47.0	 47.0	 48.0	 37.0	 39.0	 0.0652	 0.0013	 0.0733	 46.0	 47.0	 39.0 
# '		 13	 46.6	 44.7	 36.5	 44.0	 48.0	 43.0	 45.0	 35.0	 39.0	 0.0646	7.6e-04		0.071	 47.0	 44.0	 37.0 
# '		 10	 50.0	 43.3	 38.6	 49.0	 51.0	 43.0	 44.0	 37.0	 41.0	 0.0715	 0.0013	 0.0772	 50.0	 43.0	 39.0 
##------	-----	-----	-----	-----	-----	-----	-----	-----	-----	-------	-------	-------	-----	-----	-----
##	 161	 -7.8	 48.5	 40.7																						 0.0635	5.7e-04														 "

cat smg.txt | colrm 10 73 | sed '/^#/d' | tr -s '[:space:]' | awk -v OFS='\t' '$1=$1' | head -2

# This string prints the contents of the file (cat), removes columns 10-73 (colrm 10 73: This makes 
# it so only the Volume, Mean, Sem, Max Int, X, Y, and Z are printed) then removes any rows that begin with "#" 
# from the output (sed '/^#/d') ((Note:^ represents the start of the line, the 'd' means delete)) 
#the . Following that, it replaces any combination of spaces within the text with a single space 
#(tr -s '[:space:]'), which it is itself replaced with a tab (awk -v OFS='\t' '$1=$1') before 
#limiting only the first 2 rows of the text (head -2)
