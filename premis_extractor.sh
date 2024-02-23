#!/bin/bash

script=$(dirname "$0")
droid="$script/droid/droid.sh"
droidproperties="$script/droid/droid.properties"
saxon="$script/saxon/saxon-he-12.4.jar"
premis_stylesheet="$script/stylesheets/base_premis.xsl"
data="$1"
bag=$(dirname "$1")

tempdir="$(mktemp -d "${bag}"/temp-XXXXX)"
droidcsv="$(mktemp -p "${tempdir}" droid_XXXXX.csv)"
droidxml="$(mktemp -p "${tempdir}" droid_XXXXX.xml)"
premisxml="$(mktemp -p "${tempdir}" premis_XXXXX.xml)"

"$droid" "$data" -R -o "$droidcsv" -Pf "$droidproperties"

echo '<?xml version="1.0" encoding="UTF-8"?>' >> "$droidxml"
echo "<DATA>" >> "$droidxml"

IFS=',' read -r -a fields < "$droidcsv"

tail -n +2 "$droidcsv" | while IFS=',' read -r line; do
	
	type_field=$(echo "$line" | cut -d ',' -f 9)
	path_field=$(echo "$line" | cut -d ',' -f 4 | sed 's/^"\(.*\)"$/\1/')
	name_field=$(echo "$line" | cut -d ',' -f 5 | sed 's/^"\(.*\)"$/\1/')
	relative_path=$(realpath --relative-to="$bag" "$path_field")
		
	if [ "$type_field" != '"Folder"' ]; then
	
		creating_app=$(exiftool -Software -s3 "${1}/${name_field}")
		creation_date=$(exiftool -CreateDate -s3 "${1}/${name_field}")
				
		xml_content=$'\t<OBJECT>'
		xml_content+=$'\n\t\t<BASE>'
		xml_content+=$'\n\t\t\t<NAME>'"$relative_path"'</NAME>'
		xml_content+=$'\n\t\t\t<SOFTWARE>'"$creating_app"'</SOFTWARE>'
		xml_content+=$'\n\t\t\t<CREATION_DATE>'"$creation_date"'</CREATION_DATE>'
		xml_content+=$'\n\t\t</BASE>'
		
		xml_content+=$'\n\t\t<DROID>'
		for ((i=0; i<${#fields[@]}; i++)); do
			field_element=$(echo "${fields[$i]}" | sed 's/^"\(.*\)"$/\1/')
			field_value=$(echo "$line" | cut -d ',' -f $((i+1)) | sed 's/^"\(.*\)"$/\1/')
			xml_content+=$'\n\t\t\t<'"$field_element"'>'"$field_value"'</'"$field_element"'>'
		done
		xml_content+=$'\n\t\t</DROID>'
		
		xml_content+=$'\n\t</OBJECT>'

		echo "$xml_content" >> "$droidxml"
	fi
done

echo "</DATA>" >> "$droidxml"

java -jar "$saxon" -s:"$droidxml" -xsl:"$premis_stylesheet" -o:"$premisxml"

cp "$premisxml" "$bag/premis.xml"

rm -r "$tempdir"
