$path = 'E:/OriginDebug/Sources'

def find_file(name) 
  Dir[File.join($path, '**/*.{vcxproj,sln}')].each do |f|
    return f if File.basename(f, '.*').casecmp(name) == 0
  end
  return nil
end

while true
  print 'Project / Solution name : '
  file = gets
  break if !file
  file.strip!
  break if file.empty?

  opts = file.split('/')
  file = opts[0]
  opts.delete_at(0)
  file.rstrip!
  
  projfile = find_file(file)
  if projfile
      cmd = 'c:\dropbox\Handy\Build.bat %s' % projfile
      opts.each {|c| cmd += ' "/%s"' % c.strip}
      # puts cmd
      system(cmd)
  else
    puts 'Project / Solution file cannot be found !!!'
  end
end