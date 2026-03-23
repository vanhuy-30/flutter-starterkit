SHELL := /bin/bash

.PHONY: help gen-code gen-code-watch build-apk build-ipa

help:
	@echo "Available commands:"
	@echo "  make gen-code              # Generate code once"
	@echo "  make gen-code-watch        # Watch and regenerate code"
	@echo "  make build-apk FLAVOR=dev  # Build Android APK (dev|stg|prod)"
	@echo "  make build-ipa FLAVOR=dev  # Build iOS IPA (dev|stg|prod)"

gen-code:
	@./scripts/generate_code.sh build

gen-code-watch:
	@./scripts/generate_code.sh watch

build-apk:
	@./scripts/build_app.sh apk $(or $(FLAVOR),dev)

build-ipa:
	@./scripts/build_app.sh ipa $(or $(FLAVOR),dev)
