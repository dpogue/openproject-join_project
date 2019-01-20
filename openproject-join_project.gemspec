# encoding: UTF-8
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

$:.push File.expand_path("../lib", __FILE__)

require 'open_project/join_project/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openproject-join_project"
  s.version     = OpenProject::JoinProject::VERSION

  s.authors     = ["Darryl Pogue", "Splendeo Innovación", "Eric Davis"]
  s.email       = "darryl@dpogue.ca"
  s.homepage    = "https://github.com/dpogue/openproject-join_project"
  s.summary     = 'OpenProject Join Project'
  s.description = "This plugin provides a mechanism to allow non-members to join a project."
  s.license     = "GPL-2.0-or-later"

  s.files = Dir["{app,config,db,lib}/**/*"] + %w(Rakefile CHANGELOG.md README.md LICENCE CODE_OF_CONDUCT.md)
end
