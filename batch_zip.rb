#!/usr/bin/env ruby

require 'rubygems'
require 'zip'

def zip_files(dir, skip="")
  Dir[File.join(dir, '**')].each do |f|
    if f.casecmp(skip) == 0
      next
    end
  
    if File.directory?(f)
      zip_files(f)
      next
    end
    
    puts f
    Zip::File.open(f + '.zip', Zip::File::CREATE) do |zipfile|
      zipfile.add(f.sub(File.join(dir, ''), ''), f)
    end
  end
end

Zip.continue_on_exists_proc = true

zip_files('.', File.join('.', File.basename(__FILE__)))

