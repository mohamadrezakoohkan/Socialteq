#!/bin/bash

. Script/foundation.sh

print "Starting export CSV, HTML, JSON, XCODE and MARKDOWN"

swiftlint --reporter csv > Report/Swiftlint/lint-report.csv \
  && swiftlint --reporter html > Report/Swiftlint/lint-report.html \
  && swiftlint --reporter json > Report/Swiftlint/lint-report.json \
  && swiftlint --reporter xcode > Report/Swiftlint/lint-report.txt \
  && swiftlint --reporter markdown > Report/Swiftlint/lint-report.md \

print "Export CSV, HTML, JSON, XCODE and MARKDOWN was successfull"
