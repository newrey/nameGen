### nameGen.rb

A ruby script that will create a list of user names in common domain naming convention formats.

#### Usage

``` shell
skawa-mbp:username_generators $ ruby nameGen.rb 
Usage: ruby nameGen.rb [options]
Main Arguments:
    -f, --first FIRSTNAMES_FILE      A file containing a list of first names
    -l, --last LASTNAMES_FILE        A file containing a list of last names
Options:
    -i, --initial                    Create a list of names prepended with a-z
    -d, --dot                        Create a list of names in a fname.lname format from a file of first names and last names
    -r, --reverse                    Create a list of names appended with a-z
    -o, --output OUTPUT_FILE         Outfile name
    -e, --examples                   Show some usage examples```

#### Command Usage
```
ruby nameGen.rb -l lastnames_sample.txt -i -o first-initial-last-name.txt
ruby nameGen.rb -f firstnames_sample.txt -i -o last-initial-first-name.txt
ruby nameGen.rb -f firstnames_sample.txt -l lastnames_sample.txt -d -o firstname-dot-lastname.txt
ruby nameGen.rb -l lastnames_sample.txt -r -o last-name-first-initial.txt
ruby nameGen.rb -f firstnames_sample.txt -r -o first-name-last-initial.txt
```

#### Expected Output
```
skawa-mbp:username_generators $  ruby nameGen.rb -f firstnames_sample.txt -l lastnames_sample.txt -d -o firstname-dot-lastname.txt | tail -n 10
bob.yates
bob.yoder
bob.york
bob.young
bob.yu
bob.zamora
bob.zavala
bob.zhang
bob.zimmerman
bob.zuniga
```