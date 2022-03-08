
#this script is downsampling the Voxceleb corpora from 16Khz to any sample rate you choose
#uses - python3 downsample.py <root_path> <corporate> <sample_rate(k)>
#for example - python3 downsample.py /home/madarb/storge/voxceleb_data/voxceleb1 voxceleb1 8k

#voxceleb1 - 16KHz.wav ----> 8KHz.wav
#voxceleb2 - 16KHz.m4a-----> 16KHz.wav -----> 8KHz.wav ----->8KHz.m4a  (using ffmpeg to convert codec)
#Writing by Bar Madar

import os
import fnmatch
import sys

def main():
#    ROOT_PATH = '/home/madarb/storage/sox/check'
#   ROOT_PATH = "/home/madarb/storage/voxceleb_data/voxceleb1"
#    corporate = "voxceleb2"
#    sample_rate = "8k"
    ROOT_PATH = sys.argv[1]
    corporate = sys.argv[2]
    sample_rate = sys.argv[3]
    if corporate == "voxceleb1":
        format_file = "*.wav"
        flag = 0
    else:
        format_file = "*.m4a"
        flag = 1
    new_corporate = "{}_{}".format(corporate, sample_rate)
    print(ROOT_PATH)
    for dirpath, dirs, files in os.walk(ROOT_PATH):
        #for filename in fnmatch.filter(files, '*.wav'):
         for filename in fnmatch.filter(files, format_file):
            new_dirpath = dirpath.replace(corporate, new_corporate , 1)
            print(new_dirpath)
            if not os.path.exists(new_dirpath):
                os.makedirs(new_dirpath)
            file_old = os.path.join(dirpath, filename)
            old_name = file_old[:-4]
            file_new = os.path.join(new_dirpath, filename)
            new_name = file_new[:-4]
            if not flag:  # downsampling the voxceleb1
                downsample = "sox {} -r 8k {}".format(file_old, file_new)
                os.system(downsample)
            else:
                convert1 = "ffmpeg -i {} {}.wav".format(file_old, old_name ) #convert from .m4a to wav
                downsample = "sox {}.wav -r 8k {}.wav".format(old_name, new_name) #downsample the .wav to 8k and save in new path
                remove = "rm {}.wav".format(old_name) #remove the .wav 16Khz
                convert2 = "ffmpeg -i {}.wav {}".format(new_name, file_new ) #convert the .wav 8Khz to .m4a
                remove2 = "rm {}.wav".format(new_name) #remove the .wav 8KHz
                os.system(convert1)
                os.system(downsample)
                os.system(remove)
                os.system(convert2)
                os.system(remove2)
if __name__ == "__main__":
    main()






