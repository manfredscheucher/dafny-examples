.PHONY: all clean build run help

# Set up PATH for dotnet 8
export PATH := /opt/homebrew/Cellar/dotnet@8/8.0.122/bin:$(PATH)

SCRIPT_DIR := $(shell pwd)
DAFNY_BIN := $(SCRIPT_DIR)/../Binaries/dafny

# If Binaries/dafny doesn't exist, use dotnet run
DAFNY_CMD := $(if $(shell [ -f "$(DAFNY_BIN)" ] && echo "exists"),$(DAFNY_BIN),dotnet run --project $(SCRIPT_DIR)/../Source/Dafny/Dafny.csproj --)

EXAMPLES := hello abs maximum factorial fibonacci quicksort bubblesort

help:
	@echo "Dafny Examples Makefile"
	@echo "======================"
	@echo ""
	@echo "Targets:"
	@echo "  all       - Build and run all examples"
	@echo "  clean     - Remove all generated files"
	@echo "  build     - Build all examples to Kotlin"
	@echo "  run       - Run all examples"
	@echo "  help      - Show this help message"
	@echo ""
	@echo "Example-specific targets:"
	@echo "  clean-<example>  - Clean specific example (e.g., clean-hello)"
	@echo "  build-<example>  - Build specific example (e.g., build-hello)"
	@echo "  run-<example>    - Run specific example (e.g., run-hello)"
	@echo ""
	@echo "Available examples: $(EXAMPLES)"

all: build run

clean:
	@echo "Cleaning all examples..."
	@for example in $(EXAMPLES); do \
		if [ -d "$$example" ]; then \
			echo "  Cleaning $$example..."; \
			rm -rf $$example/*-kt* $$example/*-kotlin $$example/*.dtr; \
		fi \
	done
	@echo "Done!"

build: $(addprefix build-,$(EXAMPLES))

run: $(addprefix run-,$(EXAMPLES))

build-%:
	@example=$*; \
	if [ -d "$$example" ]; then \
		dfy_file=$$(ls $$example/*.dfy 2>/dev/null | head -1); \
		if [ -z "$$dfy_file" ]; then \
			echo "ERROR: No .dfy file found in $$example"; \
			exit 1; \
		fi; \
		echo "Building $$example..."; \
		$(DAFNY_CMD) build "$$dfy_file" --target:kt --no-verify > /dev/null 2>&1; \
		if [ $$? -eq 0 ]; then \
			echo "  ✓ Build successful"; \
		else \
			echo "  ✗ Build failed"; \
			exit 1; \
		fi \
	fi

run-%:
	@example=$*; \
	if [ -d "$$example" ]; then \
		kotlin_dir=$$(find $$example -maxdepth 2 -type d \( -name "*-kt*" -o -name "*-kotlin" \) | head -1); \
		if [ -z "$$kotlin_dir" ]; then \
			echo "ERROR: Could not find generated Kotlin directory for $$example"; \
			exit 1; \
		fi; \
		echo "Running $$example:"; \
		echo "---"; \
		cd "$$kotlin_dir" && gradle run 2>/dev/null; \
		echo "---"; \
	fi

clean-%:
	@example=$*; \
	if [ -d "$$example" ]; then \
		echo "Cleaning $$example..."; \
		rm -rf $$example/*-kt* $$example/*-kotlin $$example/*.dtr; \
		echo "Done!"; \
	else \
		echo "Example $$example not found"; \
	fi
