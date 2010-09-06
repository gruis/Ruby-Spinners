#!/usr/bin/env ruby -wW0
#
# 
#
# spinner.rb
# Caleb Crane <spinner.rb@simulacre.org> on 2010-09-04
require "singleton"

module Spinner
  class Sweep
    include Singleton

    @@params     = {:border => "=", :sweeper => " ", :sweeper_size => 3, :len => 30, :speed => 0.025, :format => "%s" }
    @@bcount     = @@fcount = 0
    @@dir        = :backward
    @@count      = 0

    #
    # TBD
    def start(args = {})
      return unless STDOUT.tty?
      @@params.merge!(args)
      spos        = pos = (@@params[:len] / 2)
      size        = @@params[:sweeper_size]
      s           = (0..@@params[:len]).to_a.inject(""){ |str| str << @@params[:border] }
      0.upto(size -1 ){ |i| s[pos - i] = @@params[:sweeper] }

      @thrd = Thread.new do
        while true
          print sprintf("\r#{@@params[:format]}", s, @@count)
          if @@dir == :forward
            0.upto(size) do |i| 
              el = pos - i
              s[el],s[el + 1] = s[el + 1],s[el]
            end # 0.upto(size) do |i| 
            pos += 1
          else
            0.upto(size) do  |i|
              el = pos - size + i
              s[el],s[el - 1] = s[el - 1],s[el]
            end # 0.upto(size) do
            pos += -1
          end # @@dir == :forward
          onFStop if pos >= @@params[:len]
          onBStop if pos - size == -1
          onReturn if pos == spos
          sleep @@params[:speed]
        end # true
      end # do 
    end # start    

    #
    # Sweeper has reached the end of the front
    # sweep.
    def onFStop
      @@dir    = :backward
      @@fcount += 1
      @@count += 1
    end # self.fStop

    #
    # Sweeper has reached the end of the back
    # sweep.
    def onBStop
      @@dir    = :forward
      @@bcount += 1
    end # self.bStop

    #
    # Sweeper has returned to the starting point
    def onReturn
    end # self.onReturn

    #
    # Reset the counters
    def reset
      @@dir     = :backward
      @@fcount  = @@bcount = @@count = 0
    end # reset

    #
    # TBD
    def stop
      return unless STDOUT.tty?
      @thrd.kill
      print (0..@@params[:len] + @@params[:format].length).to_a.inject("\r"){ |str| str << " " } + "\r"
    end # self.stop
  end # class::Sweep 
  
  class Roller
    include Singleton    
    @@params    = {:els => ["\\", "-", "/", "|"], :speed => 0.25, :format => "%s"}
    
    #
    # TBD
    def start(args = {})
      return unless STDOUT.tty?
      @@params.merge!(args)
      @thrd = Thread.new do
        while true
          sleep(@@params[:speed])
          el  = @@params[:els].pop
          print sprintf("\r#{@@params[:format]}", el)
          @@params[:els].unshift(el)        
        end # true
      end # Thread.new
    end # start

    #
    # TBD
    def stop
      return unless STDOUT.tty?
      @thrd.kill
      print (0..@@params[:format].length).to_a.inject("\r"){ |str| str << " " } + "\r"
    end # stop
    
  end # class::Roller 
end # module::Spinner



