default:
	opam install . --deps-only
	dune build

build:
	dune build

install:
	eval $(opam config env)
	opam install --yes . --deps-only
	eval $(opam env)
	opam update

lint:
	make clean
	dune build @lint
	dune build @fmt
	
test:
	make clean
	dune runtest 
	scripts/run_integration_E2E_tests.sh --all

clean:
	dune clean
	git clean -dfX
	rm -rf docs/

doc:
	make clean
	find src/ -name "dune" -type f -delete
	cp src/docs_dune src/dune
	dune build @doc
	mkdir docs/
	cp	-r ./_build/default/_doc/_html/* docs/

format:
	(dune build @fmt || dune promote)

hook:
	cp ./hooks/* .git/hooks

coverage:
	make clean
	BISECT_ENABLE=yes dune build
	scripts/run_test_coverage.sh	
	bisect-ppx-report html
	bisect-ppx-report summary