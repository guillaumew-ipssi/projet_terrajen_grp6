#!/bin/bash

# Read the filename
FILE_TO_READ='flow_matrix.csv'

# Check if the file exists
if [ -f ${FILE_TO_READ} ]; then
    echo "${FILE_TO_READ} exists."

    csvHeaders=('SECURITY_GROUP' 'PORT' 'PROTOCOL' 'TYPE' 'SOURCE')
    distinct_sg=()
    
    # Build ingress rules
    while IFS=';' read -ra MATRIX; do
        for i in "${!MATRIX[@]}"; do

            if [ ${csvHeaders[$i]} == 'SECURITY_GROUP' ]; then
                if ! test -f "${MATRIX[$i]}-ingress.tf"; then
                    # Add each distinct value to generate security groups after
                    distinct_sg+=(${MATRIX[$i]})
                    cp 03-template_ingress.tf ./"${MATRIX[$i]}-ingress.tf"
                else
                    cat 03-template_ingress.tf >> "${MATRIX[$i]}-ingress.tf"
                fi
                    sed -i "s|<##PORT##>|${MATRIX[$i + 1]}|g" "${MATRIX[$i]}-ingress.tf"
                    sed -i "s|<##PROTOCOL##>|${MATRIX[$i + 2]}|g" "${MATRIX[$i]}-ingress.tf"
                    sed -i "s|<##SOURCE##>|${MATRIX[$i + 4]}|g" "${MATRIX[$i]}-ingress.tf"
            fi
        done
    done < <(tail -n +2 ${FILE_TO_READ})

    # Build security group
    for i in "${distinct_sg[@]}"; do
        cp 02-template_sg.tf ${i}-sg.tf
        sed -i "s|<##SG##>|${i}|g" "${i}-sg.tf"
        # Remplace the variable by the file content
        sed -i "s|<##INGRESS_RULES##>|$(sed -e 's/[\&/]/\\&/g' -e 's/$/\\n/' ${i}-ingress.tf | tr -d '\n')|g" "${i}-sg.tf"
        rm ${i}-ingress.tf
    done
else
    echo "File ${FILE_TO_READ} not exists"
fi


