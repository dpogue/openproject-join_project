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

require_dependency 'permitted_params'

module OpenProject::JoinProject::Patches::PermittedParamsPatch
  def self.included(base)
    base.prepend InstanceMethods
  end

  module InstanceMethods
    def project
      permitted_params = super
      permitted_params.merge!(params.require(:project).permit(:project_subscription))

      permitted_params
    end
  end
end

PermittedParams.send(:include, OpenProject::JoinProject::Patches::PermittedParamsPatch)
