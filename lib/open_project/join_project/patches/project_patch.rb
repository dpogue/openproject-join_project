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

require_dependency 'project'

module OpenProject::JoinProject::Patches::ProjectPatch
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include InstanceMethods

      validates_inclusion_of :project_subscription, :in => join_options, :allow_nil => true, :allow_blank => true
    end
  end

  module ClassMethods
    def join_options
      ['none','self-subscribe','request']
    end

    def join_options_for_select
      [
        [l(:label_none),'none'],
        [l(:join_project_text_self_subscribe), 'self-subscribe'],
        [l(:join_project_text_request_to_join), 'request']
      ]
    end
  end

  module InstanceMethods
    def self_subscribe_allowed?
      project_subscription == 'self-subscribe'
    end

    def request_to_join?
      project_subscription == 'request'
    end

    def joining_allowed?
      ['request', 'self-subscribe'].include?(project_subscription)
    end
  end
end

Project.send(:include, OpenProject::JoinProject::Patches::ProjectPatch)
