import json

# Define a dictionary to hold counts for each city, day, and team
city_counts = {}
day_counts = {}
team_counts = {}

# Split the output into individual matches
with open('out.json', 'r') as fp:
    # Read the contents of the JSON file
    matches = json.load(fp)['Call'][0]['Witnesses'][0]['Value']

# Process each match
for match in matches:
    parts = match.split(',')
    squadra1 = parts[0].split('(')[1].strip()  # Extract "a" from "gioca(a,b,usfq,1)"
    squadra2 = parts[1].strip()
    citta = parts[2].strip()
    giornata = int(parts[-1].split(')')[0].strip())

    # Count matches by team
    team_counts[squadra1] = team_counts.get(squadra1, 0) + 1
    team_counts[squadra2] = team_counts.get(squadra2, 0) + 1

    # Count matches by city
    if citta in city_counts:
        city_counts[citta] += 1
    else:
        city_counts[citta] = 1

    # Count matches by day
    if giornata in day_counts:
        day_counts[giornata] += 1
    else:
        day_counts[giornata] = 1

# Calculate total matches
total_matches = len(matches)

# Print results
print("Matches by team:")
for team, count in team_counts.items():
    print(f"{team}: {count} matches")

print("\nMatches by city:")
for city, count in city_counts.items():
    print(f"{city}: {count} matches")

# Sort the day_counts dictionary by day
sorted_day_counts = dict(sorted(day_counts.items(), key=lambda x: x[0]))

print("\nMatches by day (tot):")
for day, count in sorted_day_counts.items():
    print(f"Day {day}: {count} matches")

print(f"\nTotal matches: {total_matches}")
