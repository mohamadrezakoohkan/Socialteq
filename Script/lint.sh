#!/bin/bash
swiftlint --reporter csv > Report/Swiftlint/lint-report.csv \
  && swiftlint --reporter html > Report/Swiftlint/lint-report.html \
  && swiftlint --reporter json > Report/Swiftlint/lint-report.json \
  && swiftlint --reporter xcode > Report/Swiftlint/lint-report.txt \
  && swiftlint --reporter markdown > Report/Swiftlint/lint-report.md \

