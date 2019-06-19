#!/bin/bash

facts=($@)

name=$(hostname -f)
name=($(echo ${name//./ }))

facts+=(
    ${name[0]}
)

for fact in "${facts[@]}"; do
    case ${fact:?} in
        tao)
            echo "hd"
            ;;
        apollo)
            echo "4k"
            ;;
    esac
done
