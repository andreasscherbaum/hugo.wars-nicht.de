all:
	@echo ""
	@echo "available targets:"
	@echo ""
	@echo "server               run the local test server"
	@echo "                     http://localhost:1313/"
	@echo "deploy               generate static content"
	@echo "commit               add all content in docs/, static/, content/, and run 'git commit'"
	@echo "cleanlogs            delete old server logs in /tmp"


server:	cleanlogs
	hugo server --debug --gc --log --verboseLog --buildDrafts --buildExpired --buildFuture

deploy:	cleanlogs
	hugo --debug --log --buildDrafts --buildExpired --buildFuture
	git status

commit:
	git add docs/ static/ content/ layouts/
	git commit

cleanlogs:
	find /tmp/ -mindepth 1 -maxdepth 1 -type f -mmin +60 -name "hugo*" -print0 | xargs -0 -r rm

nextpost:
	find content/post/ -type f -name "*.md" -print0 | xargs -0 grep "draft: true" | cut -f1 -d':' | xargs grep "^date: " | sort -k 2

.PHONY:	all server deploy cleanlogs nextpost
