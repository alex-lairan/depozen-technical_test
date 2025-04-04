require "dry-effects"

class DatabaseSelectorMiddleware
  include Dry::Effects::Handler.Resolve

  def initialize(app)
    @app = app
  end

  def call(env)
    case env["HTTP_X_SPACINOV_COURTIER"]
    when "alpha"
      provide(databases: [ "db1.container" ]) { @app.call(env) }
    when "beta"
      provide(databases: [ "db2.container" ]) { @app.call(env) }
    else
      provide(databases: [ "db1.container", "db2.container" ]) { @app.call(env) }
    end
  end
end
