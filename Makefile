.PHONY: test nvim clean

export BUILD_DIR ?= build

test:
	@echo "Running nvim smoke test..."
	@./scripts/nvim-smoke-test.sh test

nvim:
	@echo "Running nvim demo..."
	@./scripts/nvim-smoke-test.sh nvim

clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)
	@echo "Deleted build directory '$(BUILD_DIR)'"
