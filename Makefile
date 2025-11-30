.PHONY: test clean

export BUILD_DIR ?= build

test:
	@echo "Running nvim smoke test..."
	@./scripts/nvim-smoke-test.sh

clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)
	@echo "Deleted build directory '$(BUILD_DIR)'"
