#compas = {:N => 'y+1', :S => 'y-1', :E => 'x+1', :W => 'x-1'}
$stdout = File.open('Result.txt', 'w')
compas = ['N','W','S','E'] 
position_commands = {}
rovers = Hash.new()
rover = Hash.new()


def move(rover, data)
  case rover[:d]
	when 'N'
      rover[:y]+1 >  data[:max_y] ? rover[:y]=0 : rover[:y]+=1     
	when 'S'
      rover[:y]-1 == -1 ? rover[:y]=data[:max_y] : rover[:y]-=1
	when 'E'
      rover[:x]+1 > data[:max_x] ? rover[:x]=0 : rover[:x]+=1
	when 'W'
	  rover[:x]-1 == -1 ? rover[:x]=data[:max_x] : rover[:x]-=1
  end  
end

def activate(rover, command, compas, data)
  case command
    when 'l'
      rover[:i] = (rover[:i]+1)%compas.size
	  rover[:d] = compas[rover[:i]]
    when 'r'
      rover[:i] = (rover[:i]-1+compas.size)%compas.size
      rover[:d] = compas[rover[:i]]
    when 'm'
      move(rover, data)
  end
end

def read_file
  lines = File.readlines("dataf")
  data = {:max_x=>lines[0][0].to_i, :max_y=>lines[0][2].to_i, :lines=>lines[1..lines.size]}
end

def create_hash_position_commands(data)
  a=Array.new
  data[:lines].each do |line| 
    a.push(line.split("\n"))
  end
  Hash[*a]
end

  data = read_file
  puts position_commands = create_hash_position_commands(data)
 
  position_commands.each do |key, value|
    rover = {:x=>key.inspect[2].to_i, :y=>key.inspect[4].to_i, :d=>key.inspect[6], :i=>compas.rindex(key.inspect[6])}
   
    value.each do |commands| 
      commands.downcase.each_char do |com|
        activate(rover, com, compas, data)
      end
      rovers[key] = rover
    end
  end
 puts rovers
 




