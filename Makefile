.PHONY: test install build deploy

deploy:
	$(eval VERSION := $(shell cat lib/shields_badge.rb | grep 'VERSION = ' | cut -d\" -f2))
	git tag v$(VERSION) -m ""
	git push origin v$(VERSION)
	gem build shields_badge.gemspec
	gem push shields_badge-$(VERSION).gem

install:
	rm -rf vendor .bundle
	bundle install

test:
	rake

compare:
	hub compare $(shell git tag --sort=refname | tail -1)...master
