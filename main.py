def main():
    with open("books/frankenstein.txt") as f:
        file_contents = f.read()
        return file_contents

def countWords(corpus):
    wordCount = corpus.split(" ")
    print(len(wordCount))

countWords(main())
