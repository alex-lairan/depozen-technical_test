Depozen::Container.register_provider(:database) do
  prepare do
    require "rom-sql"
    require "rom"
  end

  # Setup for 2 databases
  # The next goal is to make it configurable for more than 2 databases
  # For now, we only have 2 databases and use a pool class that call the correct database
  start do
    connection_1 = Sequel.connect(ENV['DATABASE_URL_1'], extensions: %i[pg_timestamptz])
    configuration_1 = ROM::Configuration.new(:sql, connection_1)
    configuration_1.auto_registration(target.root.join("lib/infrastructure"), namespace: 'Infrastructure')
    db_container_1 = ROM.container(configuration_1)

    connection_2 = Sequel.connect(ENV['DATABASE_URL_2'], extensions: %i[pg_timestamptz])
    configuration_2 = ROM::Configuration.new(:sql, connection_2)
    configuration_2.auto_registration(target.root.join("lib/infrastructure"), namespace: 'Infrastructure')
    db_container_2 = ROM.container(configuration_2)

    register("db1.connection", connection_1)
    register("db1.configuration", configuration_1)
    register("db1.container", db_container_1)

    register("db2.connection", connection_2)
    register("db2.configuration", configuration_2)
    register("db2.container", db_container_2)
  end
end
