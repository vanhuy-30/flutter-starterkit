#!/bin/bash

# Chạy unit tests và widget tests
flutter test --coverage

# Chạy integration tests
flutter test integration_test

# Tạo báo cáo coverage
flutter pub run coverage:format_coverage --lcov --in=coverage/lcov.info --out=coverage/lcov.info --packages=.packages --report-on=lib

# Tạo HTML report
genhtml coverage/lcov.info -o coverage/html

# Mở báo cáo coverage trong trình duyệt
open coverage/html/index.html 