def main():
    with open("books/frankenstein.txt") as f:
        file_contents = f.read()
        return file_contents

def countWords(corpus):
    wordCount = corpus.split(" ")
    return wordCount

def countLetters(list1, list2):
    for char in list1:
        for word in list2:
            result = word.count(char)

def countChars(corpus):
    charList = list(set([char.lower() for char in corpus if char.lower().isalpha()]))
    countDict = {char: count for char,count in zip(charList, list(map(lambda char: corpus.count(char), charList)))}
    return countDict

def report(corpus):
    print(f"--- Begin report of frankenstein.txt ---")
    print(f"{len(countWords(corpus))} words found in document\n\n")
    for letter,count in countChars(corpus).items():
        print(f'The "{letter}" character was found {count} times')
    print(f"--- End report ---")

#countWords(main())
#countChars(main())
report(main())
