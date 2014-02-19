module TestSunspot
  class << self
    attr_accessor :pid, :original_session, :stub_session, :server

    def setup
      TestSunspot.original_session = Sunspot.session
      Sunspot.session = TestSunspot.stub_session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
    end
  end
  def self.included(klass)
      klass.instance_eval do
        def startup

          Sunspot.session = TestSunspot.original_session
          rd, wr = IO.pipe
          pid = fork do
            STDOUT.reopen(wr)
            STDERR.reopen(wr)
            TestSunspot.server ||= Sunspot::Rails::Server.new
            begin
              TestSunspot.server.run
            ensure
              wr.close
            end
          end
          TestSunspot.pid = pid
          ready = false
          until ready do
            ready = true if rd.gets =~ /Started\ SocketConnector/
            sleep 0.5
          end
          rd.close
        end

        def shutdown
          Sunspot.remove_all!
          Process.kill("HUP",TestSunspot.pid)
          Process.wait
          Sunspot.session = TestSunspot.stub_session
        end
      end
      def teardown
        Sunspot.remove_all!
      end
    end


end