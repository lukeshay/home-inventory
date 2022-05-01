DOCKER ?= $(shell which docker)


.PHONY: dcp-up
dcp-up:
	@$(DOCKER) compose up -d
mix