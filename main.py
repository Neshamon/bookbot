def main():
    with open("books/frankenstein.txt") as f:
        file_contents = f.read()
        return file_contents

def countWords(corpus):
    wordCount = corpus.split(" ")
    print(len(wordCount))

def countChars(corpus):
    charCount = [char.lower() for char in corpus]
    print(len(charCount))

#countWords(main())
countChars(main())
