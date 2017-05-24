Gem.loaded_specs['hackathon_manager'].dependencies.each do |d|
 require d.name
end

module HackathonManager
  class Engine < ::Rails::Engine
  end
end
