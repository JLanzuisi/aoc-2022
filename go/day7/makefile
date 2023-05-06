PROGNAME=aocday7

.PHONY: run

run: $(PROGNAME)
	./$^

$(PROGNAME): $(PROGNAME).go format vet
	go build $<

format: $(PROGNAME).go
	go fmt $^

vet: $(PROGNAME).go
	go vet $^
