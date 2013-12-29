#!/usr/bin/env ruby

class XFGUI
  def initialize
    @path = 'c:\xfgui'
  end
  
  def GUI2XF
    script = ''
    do_entries do |file|
      m = file.match(/(.)XFGUI_(.*)\.xml/)
      if m
        s = "gui2xf %s l:=%s;" % [m[2], m[1]]
        script += s
        puts s
      end
    end
    run(script)
  end
  
  def XF2GUI
    report = 'd:\report.txt'
    begin
      File.open(report, 'r') do |file|
        script = ''
        while (line=file.gets)
          m = line.match(/.*\\(.*)\.oxf/i)
          m = line.match(/(.*) changes:/i) if !m
          m = line.match(/(\w+)/) if !m
          if m
            puts m[1]
            'JG'.each_char {|c| script += "xf2gui %s l:=%s;" % [m[1],c] }
          end				
        end
        run(script)
      end
    rescue Exception => e
      puts e
    end
  end
  
  def clear
    do_entries do |file|
      File.delete(File.join(@path, file)) if file.match(/.XFGUI_[^.]*\.xml/)
    end
  end
private
  def do_entries(&block)
    begin
      Dir.entries(@path).each {|file| block.call(file) }
    rescue Exception => e
      puts e
    end
  end
  
  def run(script)
    system('G:\F_C_VC32\origin9 -h -rs %s;exit;' % script) if !script.empty?
  end
end

if __FILE__ == $0
  puts 'What do you want ?

1. XF to GUI
2. GUI to XF
3. Clean all all XMLs

'
  xf = XFGUI.new
  while true
    print 'Choose one operation, or press any other to quit : '
    choice = gets.chomp.to_i
    case choice
    when 1 then xf.XF2GUI
    when 2 then xf.GUI2XF
    when 3 then xf.clear
    else
      break
    end
  end
end
