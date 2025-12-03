# Set up PATH for dotnet 8
export PATH := /opt/homebrew/Cellar/dotnet@8/8.0.122/bin:$(PATH)

SCRIPT_DIR := $(shell pwd)
DAFNY_BIN := $(SCRIPT_DIR)/../Binaries/dafny

# If Binaries/dafny doesn't exist, use dotnet run
DAFNY_CMD := $(if $(shell [ -f "$(DAFNY_BIN)" ] && echo "exists"),$(DAFNY_BIN),dotnet run --project $(SCRIPT_DIR)/../Source/Dafny/Dafny.csproj --)

# Custom examples (directories)
CUSTOM_EXAMPLES := hello abs maximum factorial fibonacci bubbleSort linkedListSearch

# Official Dafny examples (top-level .dfy files)
OFFICIAL_EXAMPLES := parser_combinators parser_combinators_error

# Complex examples (directories)
COMPLEX_EXAMPLES := Simple_compiler induction-principle-code

ALL_EXAMPLES := $(CUSTOM_EXAMPLES) $(OFFICIAL_EXAMPLES) $(COMPLEX_EXAMPLES)

.PHONY: all clean $(ALL_EXAMPLES) list custom official complex

# Build and run a single example from directory
define build_and_run_dir
	@dfy_file=$$(ls $(1)/*.dfy 2>/dev/null | head -1); \
	if [ -z "$$dfy_file" ]; then \
		echo "ERROR: No .dfy file found in $(1)"; \
		exit 1; \
	fi; \
	echo "***************************************"; \
	echo "Building dir $(1)..."; \
	$(DAFNY_CMD) build "$$dfy_file" --target:kt --no-verify > /dev/null 2>&1; \
	if [ $$? -eq 0 ]; then \
		echo "  ✓ Build successful"; \
	else \
		echo "  ✗ Build failed"; \
		exit 1; \
	fi; \
	kotlin_dir=$$(find $(1) -maxdepth 1 -type d \( -name "*-kt*" -o -name "*-kotlin" \) | head -1); \
	if [ -z "$$kotlin_dir" ]; then \
		echo "ERROR: Could not find generated Kotlin directory for $(1)"; \
		exit 1; \
	fi; \
	echo "Running $(1):"; \
	echo "---"; \
	cd "$$kotlin_dir" && gradle run 2>/dev/null; \
	echo "---"
endef

# Build and run a single top-level .dfy file
define build_and_run_file
	@if [ ! -f "$(1).dfy" ]; then \
		echo "ERROR: $(1).dfy not found"; \
		exit 1; \
	fi; \
	echo "***************************************"; \
	echo "Building file $(1)..."; \
	$(DAFNY_CMD) build "$(1).dfy" --target:kt --no-verify > /dev/null 2>&1; \
	if [ $$? -eq 0 ]; then \
		echo "  ✓ Build successful"; \
	else \
		echo "  ✗ Build failed"; \
		exit 1; \
	fi; \
	kotlin_dir=$$(find . -maxdepth 1 -type d \( -name "$(1)-kt*" -o -name "$(1)-kotlin" \) | head -1); \
	if [ -z "$$kotlin_dir" ]; then \
		echo "ERROR: Could not find generated Kotlin directory for $(1)"; \
		exit 1; \
	fi; \
	echo "Running $(1):"; \
	echo "---"; \
	cd "$$kotlin_dir" && gradle run 2>/dev/null; \
	echo "---"
endef

list:
	@echo "Available examples:"
	@echo ""
	@echo "Custom examples (directory-based):"
	@for example in $(CUSTOM_EXAMPLES); do \
		echo "  make $$example"; \
	done
	@echo ""
	@echo "Official Dafny examples (from dafny repo):"
	@for example in $(OFFICIAL_EXAMPLES); do \
		echo "  make $$example"; \
	done
	@echo ""
	@echo "Complex examples (directory-based):"
	@for example in $(COMPLEX_EXAMPLES); do \
		echo "  make $$example"; \
	done
	@echo ""

custom:
	@for example in $(CUSTOM_EXAMPLES); do \
		$(MAKE) $$example; \
	done

official:
	@for example in $(OFFICIAL_EXAMPLES); do \
		$(MAKE) $$example; \
	done

complex:
	@for example in $(COMPLEX_EXAMPLES); do \
		$(MAKE) $$example; \
	done

all: custom official complex

clean:
	@echo "Cleaning all examples..."
	@for example in $(ALL_EXAMPLES); do \
		if [ -d "$$example" ]; then \
			echo "  Cleaning $$example..."; \
			rm -rf $$example/*-kt* $$example/*-kotlin $$example/*.dtr; \
		fi; \
	done
	@rm -rf *-kt* *-kotlin *.dtr
	@echo "Done!"

# Custom example targets (directories)
hello:
	$(call build_and_run_dir,hello)

abs:
	$(call build_and_run_dir,abs)

factorial:
	$(call build_and_run_dir,factorial)

fibonacci:
	$(call build_and_run_dir,fibonacci)

bubbleSort:
	$(call build_and_run_dir,bubbleSort)

linkedListSearch:
	$(call build_and_run_dir,linkedListSearch)

# Official example targets (top-level .dfy files)
parser_combinators:
	$(call build_and_run_file,parser_combinators)

parser_combinators_error:
	$(call build_and_run_file,parser_combinators_error)

# Complex example targets (directories)
Simple_compiler:
	$(call build_and_run_dir,Simple_compiler)

induction-principle-code:
	$(call build_and_run_dir,induction-principle-code)
