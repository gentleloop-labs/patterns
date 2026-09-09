#!/usr/bin/env ruby

require 'xcodeproj'

LOCALES = %w[en pt-BR de ja es fr].freeze

def add_localizations(project_path)
  project = Xcodeproj::Project.open(project_path)
  runner_group = project.main_group.groups.find { |group| group.display_name == 'Runner' }
  raise "Runner group not found in #{project_path}" unless runner_group

  variant = runner_group.children.find do |group|
    group.isa == 'PBXVariantGroup' && group.display_name == 'InfoPlist.strings'
  end
  variant ||= runner_group.new_variant_group('InfoPlist.strings')

  LOCALES.each do |locale|
    next if variant.files.any? { |file| file.name == locale }

    reference = variant.new_file("#{locale}.lproj/InfoPlist.strings")
    reference.name = locale
  end

  target = project.targets.find { |candidate| candidate.name == 'Runner' }
  raise "Runner target not found in #{project_path}" unless target

  unless target.resources_build_phase.files_references.include?(variant)
    target.resources_build_phase.add_file_reference(variant)
  end

  LOCALES.each do |locale|
    project.root_object.known_regions << locale unless project.root_object.known_regions.include?(locale)
  end

  project.save
end

add_localizations('ios/Runner.xcodeproj')
add_localizations('macos/Runner.xcodeproj')
