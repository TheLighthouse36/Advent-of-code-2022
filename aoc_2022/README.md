# AOC Mix

I will briefly explain the folder structure of this project

## _build
build artefacts. generated automatically no need to touch

## lib
where all the actual code is written it's further broken down into a year folder with day folders in them. inside those day folders is all the code necessary for that day

besides the days there is an aoc.ex file that contains broad utility functions.

## priv
this is where all the data is stored from and is accessed using `AOC.Parsing.__getInput(fileName)` 

## test
this is where all unit tests exist. This is how the actual code gets run. using the command `mix test` at the root of the repository will run all the days. there are further controls for only testing certain days using tags.

