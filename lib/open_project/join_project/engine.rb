#-- copyright
# OpenProject Join Project Plugin
#
# Copyright (C) 2019 Darryl Pogue
# Copyright (C) 2012 Splendeo Innovación
# Copyright (C) 2010 Eric Davis, Little Stream Software
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#++

# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'open_project/plugins'

module OpenProject::JoinProject
  class Engine < ::Rails::Engine
    engine_name :openproject_join_project

    include OpenProject::Plugins::ActsAsOpEngine

    def self.settings
      {
        :partial => 'settings/openproject_join_project',
        :default => {
          'roles' => [],
          'email_content' => 'A user would like to join your project. To approve or deny the request, use the link below:'
        }
      }
    end

    register 'openproject-join_project',
             :author_url => 'https://openproject.org',
             :requires_openproject => '>= 6.0.0',
             :settings => settings do


      permission :approve_join_requests, { :join_project_requests => [:index, :accept, :decline] }, :require => :member
      permission :request_to_join, { :join_projects => [:create], :join_project_requests => [:create] }, :require => :loggedin
    end

    patches [:Project, :PermittedParams]

    initializer 'join_project.hooks' do
      require 'open_project/join_project/hooks'
      require 'open_project/join_project/hooks/project_hook'
    end
  end
end
