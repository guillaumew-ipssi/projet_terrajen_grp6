#!/bin/bash

# Read the filename
FILE_TO_READ='flow_matrix.csv'

# Check if the file exists
if test -f ../${FILE_TO_READ}; then
    echo "${FILE_TO_READ} exists."

    csvHeaders=('SECURITY_GROUP' 'PORT' 'PROTOCOL' 'TYPE' 'SOURCE')
    #distinct_sg = ()
    
    # Build ingress rules
    while IFS=';' read -ra MATRIX; do
        for i in "${!MATRIX[@]}"; do

            if [ ${csvHeaders[$i]} == 'SECURITY_GROUP' ]; then
                if ! test -f "${MATRIX[$i]}_ingress.tf"; then
                    # Add each distinct value to generate security groups after
                    #distinct_sg+=(${MATRIX[$i]})
                    cp ../03-template_ingress.tf ./"${MATRIX[$i]}_ingress.tf"
                else
                    cat ../03-template_ingress.tf >> "${MATRIX[$i]}_ingress.tf"
                fi
                    sed -i "s|<##PORT##>|${MATRIX[$i + 1]}|g" "${MATRIX[$i]}_ingress.tf"
                    sed -i "s|<##PROTOCOL##>|${MATRIX[$i + 2]}|g" "${MATRIX[$i]}_ingress.tf"
                    sed -i "s|<##SG_TEMPLATE##>|${MATRIX[$i]}|g" "${MATRIX[$i]}_ingress.tf"
            fi
        done
    done < <(tail -n +2 ../${FILE_TO_READ})

    # Build security group
    # for i in "${!distinct_sg[@]}"; do
    #     echo ${distinct_sg[$i]}
    # fi
else
    echo "File ${FILE_TO_READ} not exists"
fi


