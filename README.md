# OpenCompany

A transparent compensation framework based on multiples of minimum wage. Designed for SEO agencies but adaptable to any professional services firm.

## Philosophy

Traditional compensation is opaque - employees don't know if they're paid fairly, and companies struggle with arbitrary salary decisions. This framework creates transparency through formula-driven compensation tied to a public baseline (minimum wage).

**Key Principles:**
- Salary ranges are multiples of minimum wage (2.1x - 20x)
- All positions have defined ranges (no negotiation ambiguity)
- Profit sharing is weighted by role (not equal, but transparent)
- Growth milestones are revenue-based (objective hiring triggers)

## Usage

### Basic Salary Ranges

```bash
./wages.sh
```

Shows salary ranges for all positions based on configured minimum wage ($15/hour by default).

### Profit Sharing Calculator

```bash
./wages.sh --profit-share 500000
```

Calculates profit share distribution for $500k annual profit with default team composition (2 associates, 4 analysts, 1 manager, 1 c-level).

**Custom team composition:**

```bash
./wages.sh --profit-share 500000 "2 4 1 0 1"
```

Format: "associates analysts managers directors c-level"

## Configuration

Edit `wages.conf` to customize:

- **min_wage**: Base wage ($15 by default - adjust for living wage or location)
- **Position multipliers**: Min/max salary multiples for each level
- **Profit share percentage**: % of annual profit to distribute (15% default)
- **Profit weights**: Relative weighting by position

## Role Definitions

See `Roles/*.role` for detailed requirements:

- **Associate**: Entry-level ($65k-$78k) - Support work, basic SEO
- **Analyst**: Mid-level ($81k-$109k) - Account ownership, technical expertise
- **Manager**: Team lead ($112k-$146k) - 4-5 direct reports, strategic planning
- **Director**: Division lead ($149k-$202k) - 4 teams, P&L ownership
- **C-Level**: Executive ($218k-$624k) - Company-wide leadership

All roles updated for 2026 (includes GEO, AI search, Core Web Vitals, etc.)

## Current Output (2026 Living Wage Baseline)

**Salaries:**
- Associate: $65,520 - $78,000
- Analyst: $81,120 - $109,200
- Manager: $112,320 - $146,640
- Director: $149,760 - $202,800
- C-Level: $218,400 - $624,000

**Growth Milestones (Monthly Net Income):**
- First hire: $13,520/month
- First manager: $36,400/month
- First director: $158,080/month

## Why This Works

**For Employees:**
- Know exactly where you stand in the range
- Understand path to promotion (objective milestones)
- See how company profit affects your compensation
- No "did I negotiate well enough?" anxiety

**For Companies:**
- Objective hiring/promotion decisions
- Defensible pay equity
- Clear financial planning (revenue-based hiring triggers)
- Reduced salary negotiation friction

## Limitations

- Doesn't account for cost-of-living differences (add multipliers if needed)
- Assumes standard full-time (2080 hours/year)
- Profit sharing requires profitable company
- May not work for highly specialized/scarce roles

## History

- **2019**: Original framework created
- **2026**: Updated to $15 living wage, modernized SEO roles, added profit sharing calculator

## License

MIT - Use freely, adapt as needed
