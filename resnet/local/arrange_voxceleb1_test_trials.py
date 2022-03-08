#Code to arrange the trial.txt file of voxceleb_test_1 and delete the ".wav" from the name of the utterances
import sys

def main():
    if len(sys.argv) < 2:
        print('you did not enter files name')
        exit()

    input_file = sys.argv[1]


infile = sys.argv[1]
outfile = sys.argv[2]

delete_list = [".wav"]
fin = open(infile)
fout = open(outfile, "w+")
for line in fin:
    for word in delete_list:
        line = line.replace(word, "")
    fout.write(line)
fin.close()
fout.close()

if __name__ == "__main__":
    main()
