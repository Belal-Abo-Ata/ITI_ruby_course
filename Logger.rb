require 'date'
# require 'singleton'

module Logger
  # include Singleton
  def self.info(message)
    log('info', message)
  end

  def self.warning(message)
    log('warning', message)
  end

  def self.error(message)
    log('error', message)
  end

  # def self.create_obj
  #   return @@logger_obj if @@logger_obj

  #   @@logger_obj = Logger.new
  #   @@logger_obj
  # end

  def self.log(log_type, message)
    timestamp = DateTime.now.rfc3339
    log_message = "#{timestamp} -- #{log_type} -- #{message}"
    File.open('app.logs', 'a') { |file| file.write("#{log_message}\n") }
  end
end
