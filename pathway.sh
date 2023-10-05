#1#
#!/bin/bash
index=0

while IFS=',' read -r _ _ _ _ _ _ country; do
    echo "Index: $index, Country: $country"
    ((index++))
done < epd

#2#
#!/bin/bash
index=0

while IFS=',' read -r name _ city country; do
    if [ "$index" -ne 0 ] && [ -n "$name" ]; then
        echo "Index: $index, Name: $name, City: $city, Country: $country"
    fi
    ((index++))
done < epd

#3#
#!/bin/bash
index=0
current_country=""

while IFS=',' read -r _ _ _ _ _ _ country; do
    if [ -n "$country" ]; then
        if [ "$country" != "$current_country" ]; then
            current_country="$country"
            echo "Creating file for $country"
        fi
        echo "$line" >> "$country.csv"
    fi
    ((index++))
done < epd

#4#
#!/bin/bash
index=0
october_birthdays=""

while IFS=',' read -r _ _ _ _ month _ _; do
    if [ "$index" -ne 0 ] && [ "$month" -eq 10 ]; then
        october_birthdays="$october_birthdays$line\n"
    fi
    ((index++))
done < epd

echo "Number of people born in October: $(echo -e "$october_birthdays" | wc -l)"
echo -e "List of people born in October:\n$october_birthdays"

#5#
#!/bin/bash
index=0
october_birthdays=""

while IFS=',' read -r _ _ _ _ month _ country; do
    if [ "$index" -ne 0 ] && [ "$month" -eq 10 ] && [ -n "$country" ]; then
        october_birthdays="$october_birthdays$line\n"
    fi
    ((index++))
done < epd

# Create separate lists for each country
countries=$(echo -e "$october_birthdays" | cut -d ',' -f7 | sort -u)

for c in $countries; do
    echo "October Birthdays in $c:"
    echo -e "$october_birthdays" | grep "$c$" | cut -d ',' -f1,3
done

#6#
#!/bin/bash
index=0
declare -a mozambique_people=()

while IFS=',' read -r _ _ _ _ _ _ country; do
    if [ "$index" -ne 0 ]; then
        if [ "$country" = "Mozambique" ]; then
            mozambique_people+=("$index")
        fi
    fi
    ((index++))
done < epd.csv

echo "People from Mozambique (Index): ${mozambique_people[@]}"
