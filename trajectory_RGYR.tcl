# VMD script that calculates the radius of gyration of a molecule for all the frames of simulations.
# Script by Davide Pirolli
# Sript is under GPL license 3.0, but I would appreciate if you could cite the repository if u use it in a paper
#

puts -nonewline "\n \t This script will calculate radius of gyration"
puts -nonewline "\n \t for the atoms you choose to select."
puts -nonewline "\n \t Please select your subset of atoms:"
gets stdin selection
 
set rgyrsel [atomselect top "$selection"]
set molecules [atomselect top "protein and not waters and not ions"]
set n [molinfo top get numframes]
set selout1 [regsub -all " and not " $selection "-no"]
set selout2 [regsub -all " and " $selout1 "-"]
set selout [regsub -all " " $selout2 "-"]
set output [open "RGYR_$selout.csv" w]
 
for {set i 0} {$i < $n} {incr i} {
molinfo top set frame $i
set rgyr [measure rgyr $rgyrsel]
puts "\t Frame $i of $n"
puts $output "$rgyr"
}
puts "\t Frame $n of $n - RGYR $rgyr"
puts "Done."
puts "output file: RGYR_$selout.dat"
close $output
