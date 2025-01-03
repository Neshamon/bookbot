def main():
    with open("books/frankenstein.txt") as f:
        file_contents = f.read()
        return file_contents

def countWords(corpus):
    wordCount = corpus.split(" ")
    return wordCount

def countLetters(list1, list2):
    for word in list1:
        word.count()

def countChars(corpus):
    charList = list(set([char.lower() for char in corpus if char.lower().isalpha()]))
    wordList = countWords(corpus)
    #countList = map(lambda x, y: for char in x: char.count(y), wordList, charList)
    charCount = {char: [x.count(char) for x in word] for char,word in zip(charList, wordList)}
    test = {char: [word.count(char) for word in corpus.split(" ")] for char,word in zip(charList, wordList)}
    print(test)

def report(corpus):
    print(f"--- Begin report of frankenstein.txt ---")
    print(f"{len(countWords(corpus))} words found in document\n\n")
    for letter in countChars(corpus):
        print(f'The "{letter}" character was found {count} times')

#countWords(main())
countChars(main())
