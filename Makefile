.PHONY: jup
jup:
	uv run jupyter lab

.PHONY: clean-media
clean-media:
	rm -rf media/*

.PHONY: size-media
size-media:
	du -sh media/* | sort -hr