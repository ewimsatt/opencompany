#!/bin/bash
# OpenCompany Transparent Compensation Calculator
# Calculates salary ranges based on multiples of minimum wage
# Updated: 2026-02-14

# Change to script directory
cd "$(dirname "$0")"

# Load configuration
if [ ! -f wages.conf ]; then
    echo "Error: wages.conf not found. Please create it from wages.conf or use defaults."
    exit 1
fi

source wages.conf

# Calculate salary ranges
assoc_min_pay=$(echo "$min_wage * $year_hours * $assoc_min" | bc -l)
assoc_max_pay=$(echo "$min_wage * $year_hours * $assoc_max" | bc -l)
analyst_min_pay=$(echo "$min_wage * $year_hours * $analyst_min" | bc -l)
analyst_max_pay=$(echo "$min_wage * $year_hours * $analyst_max" | bc -l)
manager_min_pay=$(echo "$min_wage * $year_hours * $manager_min" | bc -l)
manager_max_pay=$(echo "$min_wage * $year_hours * $manager_max" | bc -l)
director_min_pay=$(echo "$min_wage * $year_hours * $director_min" | bc -l)
director_max_pay=$(echo "$min_wage * $year_hours * $director_max" | bc -l)
clevel_min_pay=$(echo "$min_wage * $year_hours * $clevel_min" | bc -l)
clevel_max_pay=$(echo "$min_wage * $year_hours * $clevel_max" | bc -l)

# Team composition costs
team_min=$(echo "$assoc_min_pay * 4 + $manager_min_pay" | bc -l)
team_max=$(echo "$assoc_max_pay * 4 + $manager_max_pay" | bc -l)

# Growth milestones (monthly net income needed)
first_hire=$(echo "$analyst_min_pay / 6" | bc -l)
first_manager=$(echo "($analyst_min_pay * 4 + $manager_min_pay) / 12" | bc -l)
first_director=$(echo "($analyst_min_pay * 16 + $manager_min_pay * 4 + $director_min_pay) / 12" | bc -l)

# Display salary ranges
echo "=== OpenCompany Compensation Framework ==="
echo "Base: \$${min_wage}/hour minimum wage"
echo ""
echo "Position Salary Ranges (Annual):"
echo "  Associate:  \$${assoc_min_pay%.*} - \$${assoc_max_pay%.*}"
echo "  Analyst:    \$${analyst_min_pay%.*} - \$${analyst_max_pay%.*}"
echo "  Manager:    \$${manager_min_pay%.*} - \$${manager_max_pay%.*}"
echo "  Director:   \$${director_min_pay%.*} - \$${director_max_pay%.*}"
echo "  C-Level:    \$${clevel_min_pay%.*} - \$${clevel_max_pay%.*}"
echo ""
echo "Team Structure:"
echo "  Team (4 analysts/associates + 1 manager): \$${team_min%.*} - \$${team_max%.*}/year"
echo ""
echo "Growth Milestones (Monthly Net Income):"
echo "  First hire (Analyst):    \$${first_hire%.*}/month"
echo "  First Manager:           \$${first_manager%.*}/month"
echo "  First Director:          \$${first_director%.*}/month"
echo ""

# Profit sharing calculator
if [ "$1" == "--profit-share" ] && [ -n "$2" ]; then
    annual_profit=$2
    
    # Calculate total profit share pool
    profit_pool=$(echo "$annual_profit * $profit_share_percentage / 100" | bc -l)
    
    echo "=== Profit Sharing Calculator ==="
    echo "Annual Net Profit: \$${annual_profit}"
    echo "Profit Share Pool (${profit_share_percentage}%): \$${profit_pool%.*}"
    echo ""
    
    # Example team: 4 analysts, 1 manager, 1 director, 1 c-level
    if [ "$3" ]; then
        # Custom team composition: assoc analyst manager director clevel
        read -r assoc_count analyst_count manager_count director_count clevel_count <<< "$3"
    else
        # Default: small company
        assoc_count=2
        analyst_count=4
        manager_count=1
        director_count=0
        clevel_count=1
    fi
    
    # Calculate total weight
    total_weight=$(echo "$assoc_count * $assoc_profit_weight + \
                         $analyst_count * $analyst_profit_weight + \
                         $manager_count * $manager_profit_weight + \
                         $director_count * $director_profit_weight + \
                         $clevel_count * $clevel_profit_weight" | bc -l)
    
    # Per-weight share
    per_weight=$(echo "$profit_pool / $total_weight" | bc -l)
    
    # Calculate per-position shares
    assoc_share=$(echo "$per_weight * $assoc_profit_weight" | bc -l)
    analyst_share=$(echo "$per_weight * $analyst_profit_weight" | bc -l)
    manager_share=$(echo "$per_weight * $manager_profit_weight" | bc -l)
    director_share=$(echo "$per_weight * $director_profit_weight" | bc -l)
    clevel_share=$(echo "$per_weight * $clevel_profit_weight" | bc -l)
    
    echo "Team Composition:"
    echo "  Associates: $assoc_count"
    echo "  Analysts: $analyst_count"
    echo "  Managers: $manager_count"
    echo "  Directors: $director_count"
    echo "  C-Level: $clevel_count"
    echo ""
    echo "Profit Share Per Person:"
    [ "$assoc_count" -gt 0 ] && echo "  Associate: \$${assoc_share%.*}"
    [ "$analyst_count" -gt 0 ] && echo "  Analyst: \$${analyst_share%.*}"
    [ "$manager_count" -gt 0 ] && echo "  Manager: \$${manager_share%.*}"
    [ "$director_count" -gt 0 ] && echo "  Director: \$${director_share%.*}"
    [ "$clevel_count" -gt 0 ] && echo "  C-Level: \$${clevel_share%.*}"
    echo ""
    echo "Total distributed: \$${profit_pool%.*}"
fi

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo ""
    echo "Usage:"
    echo "  ./wages.sh                                    Show salary ranges"
    echo "  ./wages.sh --profit-share <annual_profit>     Calculate profit sharing"
    echo "  ./wages.sh --profit-share <profit> \"2 4 1 0 1\"  Custom team (assoc analyst mgr dir c-level)"
    echo ""
fi
