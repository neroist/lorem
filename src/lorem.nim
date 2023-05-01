import std/strutils
import std/random

import lorem/words

randomize()

proc word*(): string =
  ## Return a random word of Lorem Ipsum text.
  
  return sample(Words)

proc lorem*(): string = 
  ## Return the basic "Lorem ipsum..." sentence.

  return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."

proc sentence*(length: int = rand(5..20); `end`: char = '.'): string = 
  ## Generate an sentence of Lorem Ipsum text. 
  ## 
  ## :length: How long the sentence should be.
  ## :end: What puctuation to end the sentence with.

  var lst: seq[string]

  for i in 1..length:
    lst.add word()

    let fun = rand(1..200)

    if i != length:
      if fun >= 191: # 4.5% chance
        lst.add ", "
      elif fun <= 5: # 2.5% chance
        lst.add "; "
      elif fun <= 1: # 0.5% chance
        lst.add "—"
      else:
        lst.add " "

  result = lst.join()
  result[0] = result[0].toUpperAscii()
  result.add `end`

  # TODO add possibilites for other ending punctuation marks

proc sentence*(length: Slice; `end`: char = '.'): string = 
  ## Generate an sentence of Lorem Ipsum text. 
  ## 
  ## :length: The range of how long the sentence should be.
  ## :end: What puctuation to end the sentence with.

  sentence(rand(length), `end`)

proc paragraph*(length: int = rand(1..7); indent: int = 4): string = 
  ## Generate an paragraph of Lorem Ipsum text. 
  ## 
  ## :length: The range of how long the paragraph should be in sentences.
  ## :indent: How much to indent each paragraph, in spaces.

  if indent > 0:
    result.add " ".repeat(indent)

  for _ in 0..<length:
    result.add sentence(10..25) & ' '

proc paragraph*(length: Slice; indent: int = 4): string = 
  ## Generate an paragraph of Lorem Ipsum text, with a random length between
  ## `length.a .. length.b`. 
  ## 
  ## :length: The range of how long the paragraph should be. A random length 
  ##       is chosen between `length.a .. length.b`.
  ## :indent: How much to indent each paragraph, in spaces.

  paragraph(rand(length), indent)

proc essay*(length: int = rand(3..8); paragraphLength: int | Slice = rand(2..7); indent: int = 4): string = 
  ## Generate an essay of Lorem Ipsum text. 
  ## 
  ## Paragraphs are seperated by two newlines.
  ## 
  ## :length: The length of the essay in parargraphs.
  ## :paragraphLength: The length of each paragraph in sentences.
  ## :indent: How much to indent each paragraph, in spaces.
  
  for i in 1..length:
    result.add paragraph(paragraphLength, indent) 

    if i != length:
      result.add "\n\n"

proc essay*(length: Slice; paragraphLength: int | Slice = rand(2..7); indent: int = 4): string = 
  ## Generate an essay of Lorem Ipsum text, with a random length between
  ## `length.a .. length.b`. 
  ## 
  ## Paragraphs are seperated by two newlines.
  ## 
  ## :length: The range of how long the essay should be. A random length 
  ##          is chosen between `length.a .. length.b`.
  ## :paragraphLength: The length of each paragraph in sentences.
  ## :indent: How much to indent each paragraph, in spaces. 

  essay(rand(length), paragraphLength, indent)
