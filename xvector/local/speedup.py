
#this script is converting .sph files to wav, and then applying speedup
#uses - python3 speedup.py
# SR - The speed rate
# Speed_rate - the additional string to the new files directory path
# It will copy the directories of th ".sph" files to a new directory
# uses : python3 speedup.py {ROOT_PATH} {speed_rate}
# For example : python3 speedup.py /home/madarb/storage/LDC2020E28/data 08
# Writing by Bar Madar
# pip install sphfile - reauested
#from sphfile import SPHFile
import os
import fnmatch
import sys

def main():
    ROOT_PATH = sys.argv[1]
    speed_rate = sys.argv[2]
    #ROOT_PATH = '/home/madarb/storage/sox/speedup'
    #speed_rate = "08"
    sr = "{}.{}".format(speed_rate[0],speed_rate[1])
    format_file = "*.sph"
    root_folder = "data"
    sph2pip_dir = "/common_space_docker/storage_4TSSD/kaldi/tools/sph2pipe_v2.5"
    new_root_folder = "{}_SP{}".format(root_folder, speed_rate)
    print(ROOT_PATH)
    for dirpath, dirs, files in os.walk(ROOT_PATH):
         print(ROOT_PATH)
        #for filename in fnmatch.filter(files, '*.wav'):
         for filename in fnmatch.filter(files, format_file):
            new_dirpath = dirpath.replace(root_folder, new_root_folder , 1)
            print(filename)
            if not os.path.exists(new_dirpath):
                os.makedirs(new_dirpath)
            file_old = os.path.join(dirpath, filename)
            name = filename[:-4]
            file_tmp = (os.path.join(new_dirpath, name))+"_tmp.wav"
            file_new = (os.path.join(new_dirpath, name))+".wav"
            speedup = '{}/sph2pipe -f wav -p -c 1 {} {}'.format(sph2pip_dir, file_old, file_tmp )
            os.system(speedup)    # create the temporary "_tmp.wav" new file
            speedup = 'sox -v 0.78 {} {} speed {}'.format(file_tmp, file_new, sr )
            os.system(speedup)    # create the speed up ".wav" new file
            os.system('rm -R {}'.format(file_tmp))

if __name__ == "__main__":
    main()





