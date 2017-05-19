Things to try:

* DebugDemo.FrontEnd.do_thing(:rand.uniform() * 100)
* Remote observer
* Erlang shell alongside Elixir shell
* Look at process state in observer
* Kill processes, and verify supervisor restart
* Change DebugDemo.ThingProcessor code towards named cases instead of "if"; Code.load_file
* Trace calls to various functions, like handle_cast
  ttb:tracer().
  ttb:p(all, [call]).
  ttb:tp('Elixir.DebugDemo.ThingProcessor', handle_cast, x).
  ttb:tpl('Elixir.DebugDemo.ThingProcessor', process_number, x).
  ttb:stop([x, {fetch_dir, "trace"}]).
  ttb:format("trace").
  ttb:format("trace", [{handler, ttb:get_et_handler()}]).

