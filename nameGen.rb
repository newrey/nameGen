#!/usr/local/bin/ruby

=begin
namegen.rb
=end

require 'optparse'
require 'ostruct'

def fileCheck(file)
  files = file
    
  if File.exist?(files) == false
    puts " "
    puts "Whoops!"
    puts "The file named #{files} does not exist and nameGen needs it to process this request."
    puts "EXITING!"
    abort
  end
end

def initial(lname)
  fileCheck(lname)
  
  nameArr = []
  charArr = ("a".."z").to_a
  charLen = charArr.length
      
  File.foreach(lname) do |name|
    nameArr.push name
  end
  
  nameLen = nameArr.length
  nameCount = 0
  initialArr = []
  
  until nameCount == nameLen
    charCount = 0
    until charCount == charLen
      initialArr.push (charArr[charCount]) + nameArr[nameCount]
      charCount = charCount + 1
    end
    nameCount = nameCount + 1
  end
  
  @initialArr = initialArr.sort.uniq
  puts @initialArr
end

def reverseInitial(lname)
  fileCheck(lname)
  
  nameArr = []
  charArr = ("a".."z").to_a
  charLen = charArr.length
      
  File.foreach(lname) do |name|
    nameArr.push name
  end
  
  nameLen = nameArr.length
  nameCount = 0
  initialArr = []
  
  until nameCount == nameLen
    charCount = 0
    until charCount == charLen
      initialArr.push nameArr[nameCount].chomp + charArr[charCount]
      charCount = charCount + 1
    end
    nameCount = nameCount + 1
  end
  
  @initialArr = initialArr.sort.uniq
  puts @initialArr
end

def dot(fname,lname)
  fileCheck(fname)
  fileCheck(lname)
  
  fnameArr = []
  lnameArr = []
  dot = []
  
  File.foreach(fname) do |name|
    fnameArr.push name
  end
  
  File.foreach(lname) do |name|
    lnameArr.push name
  end
  
  fnameLen = fnameArr.length
  lnameLen =  lnameArr.length
  lnameCount = 0
  dotArr = []
  
  until lnameCount == lnameLen
    fnameCount = 0
    until fnameCount == fnameLen
      dotArr.push fnameArr[fnameCount].chomp + '.' +  lnameArr[lnameCount].chomp
      fnameCount = fnameCount + 1
    end
    lnameCount = lnameCount + 1
  end
  
  @dotArr = dotArr.sort.uniq
  puts @dotArr
end

def output(file)
  if @initialArr.nil? == false
    File.open(file,"w" ) do |f|
      @initialArr.each {|line| f.puts(line.to_s)}
    end
  end
  
  if @dotArr.nil? == false
    File.open(file,"w" ) do |f|
      @dotArr.each {|line| f.puts(line.to_s)}
    end
  end
  
end

def examples()
  puts "ruby nameGen.rb -l lastnames_sample.txt -i -o first-initial-last-name.txt"
  puts "ruby nameGen.rb -f firstnames_sample.txt -i -o last-initial-first-name.txt"
  puts "ruby nameGen.rb -f firstnames_sample.txt -l lastnames_sample.txt -d -o firstname-dot-lastname.txt"
  puts "ruby nameGen.rb -l lastnames_sample.txt -r -o last-name-first-initial.txt"
  puts "ruby nameGen.rb -f firstnames_sample.txt -r -o first-name-last-initial.txt"
end

def cli()
  options = OpenStruct.new
  ARGV << '-h' if ARGV.empty?
  OptionParser.new do |opt|
    opt.banner = "Usage: ruby nameGen.rb [options]"
    opt.on('Main Arguments:')
    opt.on('-f', '--first FIRSTNAMES_FILE', 'A file containing a list of first names') { |o| options.f = o }
    opt.on('-l', '--last LASTNAMES_FILE', 'A file containing a list of last names') { |o| options.l = o }
    opt.on('Options:')
    opt.on('-i', '--initial', 'Create a list of names prepended with a-z') { |o| options.initial = o }
    opt.on('-d', '--dot', 'Create a list of names in a fname.lname format from a file of first names and last names') { |o| options.dot = o }
    opt.on('-r', '--reverse', 'Create a list of names appended with a-z') { |o| options.reverse = o }
    opt.on('-o', '--output OUTPUT_FILE', 'Outfile name') { |o| options.out = o }
    opt.on('-e', '--examples', 'Show some usage examples') { |o| options.examples = o }
  end.parse!

  fname = options.f
  lname = options.l
  firstInitialLastName = options.initial
  firstNameDotLastName = options.dot
  nameInitial = options.reverse
  output = options.out
  examples = options.examples
  
  if lname.nil? == false && firstInitialLastName == true then initial(lname) end  
  if fname.nil? == false && firstInitialLastName == true then initial(fname) end    
  if lname.nil? == false && nameInitial == true then reverseInitial(lname) end  
  if fname.nil? == false && nameInitial == true then reverseInitial(fname) end  
  if fname.nil? == false && lname.nil? == false && firstNameDotLastName == true then dot(fname,lname) end  
  if firstInitialLastName == true && output.nil? == false then output(output) end
  if firstNameDotLastName == true && output.nil? == false then output(output) end
  if nameInitial == true && output.nil? == false then output(output) end
  if examples == true then examples() end  
    
end

cli()

