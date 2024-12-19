lint:
	ansible-lint 

lint-fix:
	ansible-lint --fix

test:
	molecule test
