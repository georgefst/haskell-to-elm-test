.PHONY: run-backend
run-backend: cabal-setup
	cd backend \
	  && cabal run backend-exe

.PHONY: run-frontend
run-frontend: generate-client-library frontend/node_modules
	cd frontend \
	  && yarn run --silent elm-app start


.PHONY: generate-client-library
generate-client-library: cabal-setup
	cd backend \
	  && cabal run elm-generator -- ../frontend/generated_src/

frontend/node_modules: frontend/package.json frontend/yarn.lock
	cd frontend \
	  && yarn install


.PHONY: cabal-setup
cabal-setup: backend/cabal.project backend/backend.cabal

backend/cabal.project:
	echo 'packages: . ../../elm-syntax ../../haskell-to-elm ../../servant-to-elm' > backend/cabal.project \
	  && curl https://www.stackage.org/lts-14.3/cabal.config >> backend/cabal.project

backend/backend.cabal:
	cd backend && hpack
