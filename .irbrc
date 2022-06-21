begin
  require "pry"

  if defined?(Rails) && Rails.env
    extend Rails::ConsoleMethods
  end

  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end
