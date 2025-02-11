# Helper function to install all Flutter plugins.
def install_all_flutter_pods(flutter_application_path)
  flutter_application_path = File.expand_path(flutter_application_path)
  raise "Could not find Flutter at #{flutter_application_path}" unless File.exist?(flutter_application_path)

  # Load the Flutter engine and plugins.
  flutter_engine_dir = File.join(flutter_application_path, 'Flutter')
  raise "Could not find Flutter engine at #{flutter_engine_dir}" unless File.exist?(flutter_engine_dir)

  # Load the Flutter plugins.
  flutter_plugins_file = File.join(flutter_engine_dir, '.flutter-plugins')
  raise "Could not find Flutter plugins at #{flutter_plugins_file}" unless File.exist?(flutter_plugins_file)

  # Read the plugins file.
  plugins = {}
  File.foreach(flutter_plugins_file) do |line|
    name, path = line.strip.split('=')
    plugins[name] = path
  end

  # Install each plugin.
  plugins.each do |name, path|
    pod name, :path => path
  end
end