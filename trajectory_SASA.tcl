 # VMD script for calculating the Solvent Accessible Surface Area (expressed in Angstrom^2)
 # of a molecule (or part of it you select). 
 # Script by Davide Pirolli.

 # If you use it in your paper, please cite this repository. Thank you
 
 # Starting input. Type your selection
 puts -nonewline "\n \t This script will calculate SASA for the"
 puts -nonewline "\n \t atoms you choose to select."
 puts -nonewline "\n \t Please select your subset of atoms:"
 gets stdin selection
 # Generating some selections and modifying names
 set sasasel [atomselect top "$selection"]
 set molecules [atomselect top "protein and not waters and not ions"]
 set n [molinfo top get numframes]
 set selout1 [regsub -all " and not " $selection "-no"]
 set selout2 [regsub -all " and " $selout1 "-"]
 set selout [regsub -all " " $selout2 "-"]
 set output [open "SAS_$selout.csv" w]
 # Calculating the SASA for each frame
 for {set i 0} {$i < $n} {incr i} {
 molinfo top set frame $i
 set sasa [measure sasa 1.4 $molecules -restrict $sasasel]
 puts "\t \t frame $i of $n"
 puts $output "$sasa"
 }
 puts "\t frame $n of $n"
 puts "Done."
 puts "output file: SAS_$selout.csv"
 close $output
