#!/bin/bash
# This is a script that dictates employee minimum and maximum base salary based on position.
# Team = 4 Analysts/Associates and a Manager
# Division = 4 Teams and a Director

#Constants
min_wage=7.25
year_hours=2080

# Next to sections to be moved to a .conf
# Minimum Wage Max Salary Multipliers
assoc_max=2.5
analyst_max=3.5
manager_max=4.7
director_max=6.5
clevel_max=20

# Minimum Wage Minimum Salary Multipliers
assoc_min=2.1
analyst_min=2.6
manager_min=3.6
director_min=4.8
clevel_min=7

# Formulae
assoc_min_pay=$(echo "$min_wage * $year_hours * $assoc_min" | bc -l);
assoc_max_pay=$(echo "$min_wage * $year_hours * $assoc_max" | bc -l);
analyst_min_pay=$(echo "$min_wage * $year_hours * $analyst_min" | bc -l);
analyst_max_pay=$(echo "$min_wage * $year_hours * $analyst_max" | bc -l);
manager_min_pay=$(echo "$min_wage * $year_hours * $manager_min" | bc -l);
manager_max_pay=$(echo "$min_wage * $year_hours * $manager_max" | bc -l);
director_min_pay=$(echo "$min_wage * $year_hours * $director_min" | bc -l);
director_max_pay=$(echo "$min_wage * $year_hours * $director_max" | bc -l);
clevel_min_pay=$(echo "$min_wage * $year_hours * $clevel_min" | bc -l);
clevel_max_pay=$(echo "$min_wage * $year_hours * $clevel_max" | bc -l);
team_min=$(echo "$assoc_min_pay * 4 + $manager_min_pay" | bc -l);
team_max=$(echo "$assoc_max_pay * 4 + $manager_max_pay" | bc -l);
first_hire=$(echo "$clevel_min_pay / 6  + $analyst_min_pay / 12" | bc -l);
first_team=$(echo "$first_hire * 4 + $manager_min_pay / 12" | bc -l);
first_director=$(echo "$first_team * 4 + $director_min_pay /12" | bc -l);

echo "Associate pay range is \$"${assoc_min_pay%.*}" to \$"${assoc_max_pay%.*}""
echo "Analyst pay range is \$"${analyst_min_pay%.*}" to \$"${analyst_max_pay%.*}""
echo "Manager pay range is \$"${manager_min_pay%.*}" to \$"${manager_max_pay%.*}""
echo "Director pay range is \$"${director_min_pay%.*}" to \$"${director_max_pay%.*}""
echo "C Suite pay range is \$"${clevel_min_pay%.*}" to \$"${clevel_max_pay%.*}""
echo "A Team consists of four associates/analysts and a manager. The team pay range is  \$"${team_min%.*}" to \$"${team_max%.*}""
echo "When monthly net income reaches \$"${first_hire%.*}", we can hire our first employee."
echo "We can hire our first manager when monthly net income reaches \$"${first_team%.*}"."
echo "Directors manage four teams. Our first director is hired when monthly net income reaches \$"${first_director%.*}"."

#echo "Which position would you like to know about?"
#select list in "Associate" "Analyst" "Manager" "Director" "C_Suite" "All" "Exit"; do
#	case $list in
#		Associate ) 
#			echo "Associate level minimum pay is: $assoc_min_pay"
#			echo "Associate level maximum pay is: $assoc_max_pay"
#		break;;
#		Analyst ) 
#                        echo "Analyst level minimum pay is: $analyst_min_pay"
#                        echo "Analyst level maximum pay is: $analyst_max_pay"
#		break;;
#		Manager ) 
#                        echo "Manager level minimum pay is: $manager_min_pay"
#                        echo "Manager level maximum pay is: $manager_max_pay"
#		break;;
#		Director ) 
#                        echo "Director level minimum pay is: $director_min_pay"
#                        echo "Director level maximum pay is: $director_max_pay"
#		break;;
#		C_Suite ) 
#                        echo "C Suit level minimum pay is: $clevel_min_pay"
#                        echo "C Suite level maximum pay is: $clevel_max_pay"
#		break;;
#		All )
#			echo "Associate level minimum pay is: $assoc_min_pay"
#			echo "Associate level maximum pay is: $assoc_max_pay"
#			echo "Analyst level minimum pay is: $analyst_min_pay"
#			echo "Analyst level maximum pay is: $analyst_max_pay"
#			echo "Manager level minimum pay is: $manager_min_pay"
#			echo "Manager level maximum pay is: $manager_max_pay"
#			echo "Director level minimum pay is: $director_min_pay"
#			echo "Director level maximum pay is: $director_max_pay"
#			echo "C Suit level minimum pay is: $clevel_min_pay"
#			echo "C Suite level maximum pay is: $clevel_max_pay"
#		break;;
#		Exit )
#			exit;
#		break;;
#	esac
#done

# Also needed is a percentage of yearly net to go to profit sharing and what percentage each employee level gets minus time not at company..
