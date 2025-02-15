#!/bin/bash
set -e  # Exit immediately if any command fails

echo "Fetching schema..."
./apollo-ios-cli fetch-schema

echo "Running removeDefer..."
node removeDefer.js

echo "Generating API..."
./apollo-ios-cli generate

echo "Apollo generation complete."