#!/bin/bash

input_xml=$1
if [ ! -f "$input_xml" ] ; then
        echo "USAGE: $0 <xml-file>"
        exit 1
fi

output_dir="/tmp"
output_html="$output_dir"/$(basename "$input_xml")

dir=$(realpath "$(dirname "$0")")
kosit_jar=$(ls "$dir/"validator-*-standalone.jar)
config="$dir/config"
scenarios="$config/"scenarios.xml

echo "JAR: $kosit_jar"
if [ ! -f "$kosit_jar" ] ; then
        echo "ERROR: Validator not found: $kosit_jar"
        echo "  Please visit https://github.com/itplr-kosit/validator/releases/ and download validator-x.x.x-standalone.jar"
        echo "  Place the downloaded jar-file in '$dir'"
        exit 1
fi

echo "CONFIG: $config"
if [ ! -d "$config" ] ; then
        echo "ERROR: Validator config not found"
        echo "  Please visit https://github.com/itplr-kosit/validator-configuration-xrechnung/releases/ and download xrechnung-x.x.x-validator-configuration-x.zip"
        echo "  Unzip the downloaded zip-file into '$config'"
        exit 1
fi

echo "SCENARIOS: $scenarios"
if [ ! -f "$scenarios" ] ; then
        echo "ERROR: Scenarios XML not found"
        echo "  The Scenarios XML be at '$scenarios' and is part of xrechnung-x.x.x-validator-configuration-x.zip"
        exit 1
fi

java \
        -jar "$kosit_jar" \
        -r "$config" \
        -s "$scenarios" \
        -o "/tmp" \
        -h \
        "$input_xml"

echo "Validation finished. Report can be found at $output_html"
