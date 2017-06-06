# Findsyslibs

This is a ruby gem that detects system dependencies of other ruby gems with the help of the nodejs api in this repo.

## Installation

Run the following command in this directory (the dir that contains .gemspec file)

gem build findsyslibs.spec

This will create a .gem archive that you can install in your gemset using the following command

gem install findsyslibs.gem

## Usage

To use the gem you just have to type the following instruction on the command line 

findsyslibs list gemName

You can also type the following command to get the dependencies directly from a gem file. 

Browse first to the directory that contins the gemfile and type :

findsyslibs listGemFile

This will list all the system libraries required by the gems in the gem file

*Note that the gems supported are the ones available in the gedataset.json file in the api folder in this repo.

** This gem was built using ruy-2.4.0
