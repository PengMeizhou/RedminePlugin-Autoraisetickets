Redmine::Plugin.register :autoraisetickets do
  name 'Autoraisetickets plugin'
  author 'Sean.Peng'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  project_module :autoraisetickets do
    permission :view_autoraisetickets, :autoraisetickets => :index
  end
end

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require 'autoraiseticketissuepatch'
    Issue.send(:include, Autoraiseticketissuepatch::Patches::IssuePatch)
  end
end