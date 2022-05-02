DOCKER ?= $(shell which docker)
MIX ?= $(shell which mix)

.PHONY: dcp-up
dcp-up:
	@$(DOCKER) compose up -d

.PHONY: release
release:
	@$(MIX) deps.get --only prod
	@MIX_ENV=prod $(MIX) compile
	@MIX_ENV=prod $(MIX) assets.deploy
	@$(MIX) phx.gen.release
	@MIX_ENV=prod $(MIX) release
