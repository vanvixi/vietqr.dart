# Makefile for vietqr monorepo (Melos + FVM)
# Usage:
#   make bootstrap
#   make list
#   make version scope=vietqr_core
#   make check  scope=vietqr_core
#   make publish scope=vietqr_core
#   make publish-dry scope=vietqr_core

MELOS = fvm dart pub global run melos

# Ensure a scope is provided (e.g., scope=vietqr_core)
require-scope:
	@if [ -z "$(scope)" ]; then \
	  echo "ERROR: please pass scope, e.g. make <target> scope=vietqr_core"; \
	  exit 1; \
	fi

# 1) Setup / bootstrap
melos-boot:
	@echo ">> Cleaning overrides & bootstrapping workspace"
	find . -name "pubspec_overrides.yaml" -delete
	$(MELOS) clean
	$(MELOS) bootstrap

# 2) Quality gates (scoped)
format: require-scope
	@echo ">> Running dart format for $(scope)"
	$(MELOS) exec --scope="$(scope)" -- dart format --set-exit-if-changed .

analyze: require-scope
	@echo ">> Running analyzer for $(scope)"
	# Prefer flutter analyze if available; fallback to dart analyze.
	$(MELOS) exec --scope="$(scope)" -- sh -lc 'flutter analyze || dart analyze'

check: require-scope format analyze
	@echo ">> Checks passed for $(scope)"

# 3) Version bump (Conventional Commits respected via melos.yaml)
version: require-scope
	$(MELOS) version --scope="$(scope) --no-private"

# 4) Publish
publish: check
	$(MELOS) publish --scope="$(scope)" --no-private

publish-no-dry:
	$(MELOS) publish --scope="$(scope)" --no-dry-run --no-private --yes

# 5) Utilities
list:
	$(MELOS) list

push-tags:
	git push origin --tags

clean:
	$(MELOS) clean
