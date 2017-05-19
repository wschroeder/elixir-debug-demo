ELIXIR_IMAGE=elixir:1.4.4
MAJOR_APP_NAME=debug-demo
ELIXIR_APP_NAME=debug_demo
ELIXIR_COOKIE=debugthis123
EPMD_PORT_MIN=9100
EPMD_PORT_MAX=9105

.PHONY: all repl clean

all: repl

clean:
	sudo chown -R $(shell id -u):$(shell id -u) *
	git clean -ffxd

repl: control/deps
	docker run -it --rm --hostname ${MAJOR_APP_NAME} --name ${MAJOR_APP_NAME} -v ${PWD}/control/mix:/root/.mix -v ${PWD}:/work -w /work/${ELIXIR_APP_NAME} -p ${EPMD_PORT_MIN}-${EPMD_PORT_MAX}:${EPMD_PORT_MIN}-${EPMD_PORT_MAX} -p 4369:4369 ${ELIXIR_IMAGE} iex --name app@${MAJOR_APP_NAME} --cookie ${ELIXIR_COOKIE} --erl "-kernel inet_dist_listen_min ${EPMD_PORT_MIN} inet_dist_listen_max ${EPMD_PORT_MAX}" -S mix

control/deps: control/hex control/rebar
	docker run -it --rm --hostname ${MAJOR_APP_NAME} --name ${MAJOR_APP_NAME} -v ${PWD}/control/mix:/root/.mix -v ${PWD}:/work -w /work/${ELIXIR_APP_NAME} ${ELIXIR_IMAGE} mix deps.get
	touch "$@"

control/hex: control/elixir-image
	docker run -it --rm --hostname ${MAJOR_APP_NAME} --name ${MAJOR_APP_NAME} -v ${PWD}/control/mix:/root/.mix -v ${PWD}:/work -w /work/${ELIXIR_APP_NAME} ${ELIXIR_IMAGE} mix local.hex --force
	touch "$@"

control/rebar: control/elixir-image
	docker run -it --rm --hostname ${MAJOR_APP_NAME} --name ${MAJOR_APP_NAME} -v ${PWD}/control/mix:/root/.mix -v ${PWD}:/work -w /work/${ELIXIR_APP_NAME} ${ELIXIR_IMAGE} mix local.rebar --force
	touch "$@"

control/elixir-image: control/control
	docker pull ${ELIXIR_IMAGE}
	touch "$@"

control/control:
	mkdir -p control
	touch "$@"
