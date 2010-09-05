#!/usr/bin/env ruby -wW0
#
# 
#
# examples.rb
# Caleb Crane <spinner.rb@simulacre.org> on 2010-09-05
require "spinner"

Thread.abort_on_exception = true

Spinner::Roller.instance.start()
sleep 10
Spinner::Roller.instance.stop

Spinner::Roller.instance.start(:format => "loading... %s   ")
sleep 10
Spinner::Roller.instance.stop

Spinner::Sweep.instance.start
sleep 10
Spinner::Sweep.instance.stop

Spinner::Sweep.instance.start(:sweeper => "=", :border => ".")
sleep 10
Spinner::Sweep.instance.stop

Spinner::Sweep.instance.start(:sweeper => "=", :border => ".", :len => 60)
sleep 10
Spinner::Sweep.instance.stop

Spinner::Sweep.instance.reset
Spinner::Sweep.instance.start(:sweeper_size => 2, :sweeper => ".", :border => " ", :len => 60, :format => "%s%i   ", :speed => 0.0125)
sleep 10
Spinner::Sweep.instance.stop

Spinner::Sweep.instance.start(:sweeper_size => 2, :sweeper => "..", :border => " ", :len => 60, :format => "%s%i   ", :speed => 0.0125)
sleep 10
Spinner::Sweep.instance.stop

Spinner::Sweep.instance.start(:sweeper_size => 2, :sweeper => "...", :border => " ", :len => 60, :format => "%s%i     ", :speed => 0.0125)
sleep 10
Spinner::Sweep.instance.stop

Spinner::Sweep.instance.start(:sweeper_size => 4, :sweeper => ".", :border => " ", :format => "working%s")
sleep 10
Spinner::Sweep.instance.stop

