module SidekiqSendToWorker
  class Sender
    include Sidekiq::Worker
    sidekiq_options backtrace: true, queue: 'send_to_worker', retry: 1

    include SidekiqRunner::SidekiqPerform

    def perform(worker_name, method_name, args)
      SidekiqRunner::Runner.enqueue(worker_name, method_name, args)
    end

  end
end
