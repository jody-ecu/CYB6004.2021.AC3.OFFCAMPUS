#!/bin/bash

fruit=("Apple" "Mango" "Strawberry" "Orange" "Banana")

for f in "${fruit[@]}"; do
  echo "FRUIT: $f"
done
