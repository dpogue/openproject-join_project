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

class JoinProjectsController < ApplicationController
  before_action :find_project
  before_action :authorize

  def create
    @member = @project.members.build.tap do |m|
      m.user = User.current
      m.roles = Role.find(Setting.plugin_openproject_join_project['roles'])
    end

    if @member.save
      flash[:notice] = l(:notice_successful_create)
    else
      flash[:error] = l(:join_project_error_cant_join)
    end
    redirect_to project_path(@project)
  end


  private
  def find_project
    @project = Project.find(params[:project_id])
    unless @project.self_subscribe_allowed?
      render_404
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
