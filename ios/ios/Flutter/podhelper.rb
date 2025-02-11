require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'))

flutter_root = File.expand_path('..', '..', 'flutter')

install_all_flutter_pods(flutter_application_path: flutter_root)
