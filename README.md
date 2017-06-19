Things to try:

* DebugDemo.FrontEnd.do_thing(:rand.uniform() * 100)
* Remote observer
  - Linking Docker erl nodes on MacOS to run observer:
    - Run: socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
    - Run xquartz
    - docker run -e DISPLAY=192.168.52.72:0 --rm -it --link debug-demo elixir:1.4.4 erl -hidden -sname foo -setcookie debugthis123
* Erlang shell alongside Elixir shell
* Look at process state in observer
* Kill processes, and verify supervisor restart
* Change DebugDemo.ThingProcessor code towards named cases instead of "if"; Code.load_file
* Trace calls to various functions, like handle_cast
  ttb:tracer().
  ttb:p(all, [call, send]).  % send is experimental right now
  ttb:tp('Elixir.DebugDemo.ThingProcessor', handle_cast, x).
  ttb:tpe(send, {'$gen_cast', '_', {process, '_'}}).   % wrong syntax
  ttb:tpl('Elixir.DebugDemo.ThingProcessor', process_number, x).
  ttb:stop([x, {fetch_dir, "trace"}]).
  ttb:format("trace").
  ttb:format("trace", [{handler, ttb:get_et_handler()}]).

